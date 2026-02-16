# First install the reference problem: pip install sb-arch-opt

import shutil
import pathlib
import matplotlib.pyplot as plt

from pymoo.optimize import minimize
from sb_arch_opt.problems.gnc import GNC
from sb_arch_opt.algo.pymoo_interface import get_nsga2

results_dir = pathlib.Path(__file__).parent.absolute() / 'results'


def plot_results(f_pop, f_opt, save_path=None):
    plt.figure()
    plt.scatter(f_pop[:, 0], f_pop[:, 1], s=5, c='k', label='Architectures')
    plt.scatter(f_opt[:, 0], f_opt[:, 1], s=20, c='b', label='Pareto front')
    plt.xlabel('Failure rate (log 10), minimized'), plt.ylabel('Mass, minimized [kg]')
    plt.legend()

    if save_path is not None:
        plt.savefig(save_path+'.png')
        plt.savefig(save_path+'.svg')

    plt.rcParams["font.family"] = "serif"
    plt.rcParams["font.serif"] = ["Times New Roman"]
    plt.figure(figsize=(3, 2))
    plt.scatter(f_opt[:, 0], f_opt[:, 1], s=5, c='k')
    plt.xlabel('Failure rate ($log_{10}$)'), plt.ylabel('Mass [kg]')
    ax = plt.gca()
    ax.spines['top'].set_visible(False)
    ax.spines['right'].set_visible(False)
    plt.tight_layout()

    if save_path is not None:
        plt.savefig(save_path+'_paper.svg')

    if save_path is None:
        plt.show()


def optimize_reference(pop_size=50, n_gen=20):

    opt_results_dir = results_dir / f'ref_optimization_{pop_size}_{n_gen}'
    shutil.rmtree(opt_results_dir, ignore_errors=True)
    opt_results_dir.mkdir()

    problem = GNC()

    algorithm = get_nsga2(pop_size=pop_size)
    result = minimize(problem, algorithm, termination=('n_gen', n_gen), verbose=True, copy_algorithm=False)

    f_pop = algorithm.evaluator.cumulative_pop.get('F')
    f_opt = result.opt.get('F')
    plot_results(f_pop, f_opt, save_path=str(opt_results_dir / 'gnc_optimized_plot'))


if __name__ == '__main__':
    optimize_reference()
