package ArchitectureDesign_DesignParametersExample {
    doc /*
    Example showing the different roles that attributes may play in an architecture optimization problem:
    - Input to the evaluation/simulation:
      - Static input
      - Discrete design variable
      - Continuous design variable
    - Output from the evaluation/simulation:
      - Metric
      - Objective
      - Constraint
    
    If no annotation is applied to an attribute, the following logic is applied to determine the role:
    - If the attribute has a value assigned, assume the role is "static input"
    - Else, assume it is an output
      - If the attribute has one or more constraints, assume the role is "constraint"
      - Else, assume the role is "metric"
    
    Additionally, it demonstrates a mixture between where the attributes are defined (defs or usages).

    Architecture instances have values assigned to the attributes using the following logic:
    - Input attributes (static inputs and design variables) always have values assigned
      - Note that in SysML, static inputs do not have a value re-assigned in the architecture instance,
        because the static input value was a "default" value, so it always applied
    - Output attributes optionally have values assigned:
      - If the architecture has not yet been evaluated, the output attributes
      - If the evaluation was not succesfull (for example, the simulation/calculations failed), it has a value of "CouldNotCompute" assigned
        - In other modeling languages this is normally represented using NaN (Not-a-Number), however KerML/SysML cannot represent NaN
      - If evaluation was succesfull, the resulting value is assigned
    
    Copyright: (c) 2026, The Contributors to the ODE4HERA SysML v2 Libraries.
    */
    private import ArchitectureDesign::*;

    package ElementLibrary {

        action def GenerateThrust {

            attribute seaLevelThrust :> ISQ::force default 150000[SI::N] {
                doc /* Static input: numerical value with units */
            }

        }

        part def Turboprop {

            attribute airfoil : ScalarValues::String;

            #integerDesignVariable attribute nrStages : ScalarValues::Integer {
                doc /* Integer discrete design variable:
                values can be anything between the bounds (inclusive). */
                redefines lowerBound = 1;
                :>> upperBound = 3;
            }

            #numericalOrdinalDesignVariable attribute nrBlades : ScalarValues::Integer {
                doc /* Ordinal discrete design variable:
                values can be any of [3, 4, 6, 8]. */
                redefines values = (3, 4, 6, 8);
            }

            #categoricalDesignVariable attribute bladeManufacturer : ScalarValues::String {
                doc /* Categorical discrete design variable:
                any of the values can be chosen, but there is no inherent ordering between the values. */
                :>> values = ("MT", "Hartzell", "Sensenich");
            }

            #continuousDesignVariable attribute pressureRatio {
                doc /* Continuous design variable:
                pressure ratio can have any value between (including) 10 and 30. */
                redefines lowerBound = 10.0;
                redefines upperBound = 30.0;
            }

            #continuousStepDesignVariable attribute bladeThickness {
                doc /* Continuous design variable with a step:
                values can be anything between the bounds, constrainted by a step size. */
                :>> lowerBound = 5[SI::mm];
                :>> upperBound = 30[SI::mm];
                :>> step = 5[SI::mm];
            }

            #minimizationObjective attribute thrustSpecificFuelConsumption {
                doc /* Objective to be minimized */
            }

            #constraintOutput attribute turbineInletTemperature :> ISQ::temperature {
                doc /* Inequality constraint */

                assert constraint { that <= 1500[SI::'°C_abs'] }
            }

            #evaluationOutput attribute propPressureRatio {
                doc /* Output metric (explicitly defined) */
                redefines role = OutputRole::Metric;
            }

        }
    }

    package ArchitectureDesignSpace {
        #architectureDesignSpace part def DesignSpace {
            doc /* The architecture design space definition with usages of
            part/action defs that can additionally define attributes. */

            action generateThrust[1] : ElementLibrary::GenerateThrust :> boundaryFunctions;

            part turboprop[1] : ElementLibrary::Turboprop {
                perform generateThrust[1];

                attribute redefines airfoil = "NACA0016" {
                    doc /* Static input: string value */
                }

                attribute mass :> ISQ::mass {
                    doc /* Output metric (implicitly defined) */
                }

            }

            // List of architectural choices
            :>> architecturalChoices {
                :>> choices[5] ordered = (
                    turboprop.nrStages,
                    turboprop.nrBlades,
                    turboprop.bladeManufacturer,
                    turboprop.pressureRatio,
                    turboprop.bladeThickness,
                );
            }

            // Formalization of the design problem
            :>> formalDesignProblem {
                :>> designVariables[5] ordered = (
                    turboprop.nrStages,
                    turboprop.nrBlades,
                    turboprop.bladeManufacturer,
                    turboprop.pressureRatio,
                    turboprop.bladeThickness,
                );
                :>> objectives[1] = turboprop.thrustSpecificFuelConsumption;
                :>> constraints[1] = turboprop.turbineInletTemperature;
            }
        }
    }

    package ArchitectureInstances {
        #architecture part def Arch specializes ArchitectureDesignSpace::DesignSpace {
            doc /* A specific architecture instance with values assigned to the attributes.
            For output values */

            action redefines generateThrust[1] {
                // Static input value cannot be reassigned a value
                attribute redefines seaLevelThrust;
            }

            part redefines turboprop[1] {
                perform action :>> generateThrust[1];

                // Input values (design variables)
                attribute redefines nrStages = 2;
                attribute :>> nrBlades = 4;
                attribute :>> bladeManufacturer = "MT";
                attribute :>> pressureRatio = 25.0;
                :>> bladeThickness = 15[SI::mm];

                // Output values
                attribute redefines mass; // Not evaluated
                attribute redefines thrustSpecificFuelConsumption = null; // Evaluated without result (e.g. because of failure)
                attribute redefines turbineInletTemperature = 1500[SI::K]; // Evaluation success (with unit)
                attribute redefines propPressureRatio = 1.5; // Evaluation success
            }

        }
    }
}
