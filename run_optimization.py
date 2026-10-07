import shutil
import pathlib
import logging

from pymoo.optimize import minimize
from sb_arch_opt.algo.pymoo_interface import get_nsga2

import adore_sysmlv2 as ads2
from adore.ui.html_export import InteractiveHTMLExporter
from adore.graph.api.design_problem import DesignProblemTranslator
from sysmlv2_utils.syside_utils import *
from sysmlv2_utils.syside_project_utils import *

from evaluator import capture_log, evaluate_architecture
from reference_optimization import plot_results, results_dir

log = logging.getLogger('adore.sysml.gnc')

project_dir = pathlib.Path(__file__).parent.absolute()
model_dir = project_dir / 'model'


def load_project():
    # Load the ADORE and SysML models
    log.info('Loading stored ADORE and SysML models...')
    sync = ads2.ModelSynchronizer.from_file(str(model_dir / 'gnc.adore'))

    project_helper = ProjectHelper(project_dir)
    model = project_helper.load_model_helper(files=[model_dir / 'gnc.sysml'])

    # Create the optimization problem
    project = sync.manager.project
    if len(project.design_problems) == 0:
        translator = DesignProblemTranslator.from_new(
            project, sync.manager.factory, sync.manager.adore_graph, sync=False)
    else:
        translator = DesignProblemTranslator(
            project, project.design_problems[0], sync.manager.factory, sync.manager.adore_graph, sync=False)

    with open(str(model_dir / 'gp.pkl'), 'rb') as fp:
        serialized_gp = fp.read()
    translator.use_serialized_graph_processor(serialized_gp)
    log.info(f'Encoding the optimization problem...')
    translator.sync()

    # Cache the encoded optimization problem
    if not translator.gp_was_serialized:
        with open(str(model_dir / 'gp.pkl'), 'wb') as fp:
            fp.write(translator.serialize_graph_processor())

    return sync, model, translator


class GNCSysMLv2Evaluator(ads2.SysMLv2FileEvaluator):

    def _evaluate_file(self, input_file_path: str, output_file_path: str):
        evaluate_architecture(input_file_path, output_file_path)


def _get_evaluator(model: ModelHelper, translator: DesignProblemTranslator, save_path: str):
    return GNCSysMLv2Evaluator(
        translator,  # Optimization problem synchronizer
        model_helper=model,  # SysML model
        sysml_path=str(model_dir / 'gnc.sysml'),  # SysML model path
        save_to_project=True,  # Save generated architectures to the ADORE model
        save_path=save_path,  # Path to save input, output, and results files
    )


def eval_test_random_architectures(sync: ads2.ModelSynchronizer, model: ModelHelper, translator: DesignProblemTranslator,
                                   n=10):

    # (Re)create testing results folder
    testing_dir = results_dir / 'testing'
    shutil.rmtree(testing_dir, ignore_errors=True)
    testing_dir.mkdir()

    # Get the GNC SysML v2 evaluator
    evaluator = _get_evaluator(model, translator, str(testing_dir))

    # Create and evaluate random architectures
    for i in range(n):
        log.info(f'Generating random architecture {i+1}/{n}')
        dv = evaluator.get_random_design_vector()
        architecture, dv_imp, _ = evaluator.get_architecture(dv)
        obj, _ = evaluator.evaluate(architecture)

    # Save results
    sync.manager.to_file(str(testing_dir / 'gnc_eval.adore'))
    evaluator.save_results_csv(str(testing_dir / 'gnc_eval.csv'))
    InteractiveHTMLExporter.export_project(sync.manager.project, str(testing_dir / 'gnc_eval.html'))


def run_optimization(sync: ads2.ModelSynchronizer, model: ModelHelper, translator: DesignProblemTranslator,
                     pop_size=50, n_gen=20):

    # (Re)create optimization results folder
    opt_results_dir = results_dir / f'optimization_{pop_size}_{n_gen}'
    shutil.rmtree(opt_results_dir, ignore_errors=True)
    opt_results_dir.mkdir()

    # Get the GNC SysML v2 evaluator and associated SBArchOpt problem class
    evaluator = _get_evaluator(model, translator, str(opt_results_dir))
    problem = evaluator.get_arch_opt_problem()

    # Initialize the NSGA2 algorithm
    algorithm = get_nsga2(pop_size=pop_size)

    # Run the optimization
    result = minimize(problem, algorithm, termination=('n_gen', n_gen), verbose=True)

    # Save results
    sync.manager.to_file(str(opt_results_dir / 'gnc_optimized.adore'))
    evaluator.save_results_csv(str(opt_results_dir / 'gnc_optimized.csv'))
    InteractiveHTMLExporter.export_project(sync.manager.project, str(opt_results_dir / 'gnc_optimized.html'))

    # Plot results
    results_df = evaluator.get_results()
    obj_cols = [col for col in results_df.columns if col.startswith('OBJ_')]
    f_pop = results_df[obj_cols].values
    f_opt = result.opt.get('F')
    plot_results(f_pop, f_opt, save_path=str(opt_results_dir / 'gnc_optimized_plot'))


if __name__ == '__main__':
    capture_log()

    sync_, model_, translator_ = load_project()

    eval_test_random_architectures(sync_, model_, translator_)
    # run_optimization(sync_, model_, translator_, pop_size=5, n_gen=2)
    # run_optimization(sync_, model_, translator_)
