package ArchitectureDesign_AdvancedFunctionAllocationExample {
    doc /*
    Example demonstrating in addition to function fulfillment and induction:
    - Function decompositions for mapping one function to multiple functions
    - Concepts for mapping a neutral to a specific function
    - Non-fulfillment for specifying a function can also be left unfulfilled
    - Multi-fulfillment for specifying a function can be fulfilled by multiple components at a time
    - Subsystems for decomposing the design space
    - Instantiation choices
    
    Copyright: (c) 2026, The Contributors to the ODE4HERA SysML v2 Libraries.
    */
    private import ArchitectureDesign::*;

    #architectureDesignSpace part def DesignSpace {
        action transportPax[1] :> boundaryFunctions;

        abstract #concept allocation byAir[0..1] allocate transportPax to transportPaxByAir;
        abstract #concept allocation byLand[0..1] allocate transportPax to transportPaxByLand;

        action transportPaxByAir[0..1];
        action transportPaxByLand[0..1];

        part landTransportSystem[0..1] { perform transportPaxByLand; }

        #subsystem part airTransportSystem[0..1] {

            abstract #decomposition connection airTransportFunctions[1] connect (
                transportPaxByAir,
                containPax, controlAircraft, generateLift, generateThrust
            );
            
            action containPax[1];
            action controlAircraft[1];
            action generateLift[1];
            action generateThrust[1];

            part fuselage[1] { perform containPax; }

            part controlSystem[1] {
                perform controlAircraft;
                ref #needsAction ::> providePower;
            }
            action providePower[1];
            part powerGenerationDistributionSystem[1] { perform providePower; }

            part wing[2] {
                perform generateLift;
                ref #needsAction ::> improveAerodynamics;
            }
            action improveAerodynamics[1];
            part winglets[0..1] { perform improveAerodynamics; }
            abstract #nonFulfillment occurrence noWinglets[0..1] {
                :>> nonFulfilledActions[1] default improveAerodynamics;
            }

            part turboprop[(0, 2, 4)] { perform generateThrust; }
            part electricPropulsionAssembly[(0, 2, 4)] { perform generateThrust; }
            abstract #multiFulfillment occurrence hybridElectric[0..1] {
                :>> fulfilledActions[1] default generateThrust;
                :>> fulfillingParts[2] default (turboprop, electricPropulsionAssembly);
            }
        }

        :>> architecturalChoices {
            :>> choices[5] ordered = (transportPaxFulfillmentChoice, improveAerodynamicsFulfillmentChoiceSys1,
                generateThrustFulfillmentChoiceSys1, electricPropulsionAssemblyInstantiationChoiceSys1, turbopropInstantiationChoiceSys1);

            derived occurrence transportPaxFulfillmentChoice :> choices : FunctionFulfillmentChoice {
                ref :>> actionToPerform[1] = transportPax;
                ref :>> performingAlternatives[2] = (byAir, byLand);
            }

            derived occurrence improveAerodynamicsFulfillmentChoiceSys1 :> choices : FunctionFulfillmentChoice {
                ref :>> actionToPerform[1] = airTransportSystem#(1).improveAerodynamics;
                ref :>> performingAlternatives[2] = (airTransportSystem#(1).winglets, airTransportSystem#(1).noWinglets);
            }

            derived occurrence generateThrustFulfillmentChoiceSys1 :> choices : FunctionFulfillmentChoice {
                ref :>> actionToPerform[1] = airTransportSystem#(1).generateThrust;
                ref :>> performingAlternatives[3] =
                    (airTransportSystem#(1).turboprop,
                    airTransportSystem#(1).electricPropulsionAssembly,
                    airTransportSystem#(1).hybridElectric,
                );
            }

            derived attribute electricPropulsionAssemblyInstantiationChoiceSys1 :> choices, InstantiationChoice {
                ref :>> instantiatingElement[1] = airTransportSystem#(1).electricPropulsionAssembly;
                :>> values[2] = (2, 4);
            }

            derived attribute turbopropInstantiationChoiceSys1 :> choices, InstantiationChoice {
                ref :>> instantiatingElement[1] = airTransportSystem#(1).turboprop;
                :>> values[2] = (2, 4);
            }

            :>> choiceConstraints[1] = propulsionInstantiationConstraint;
            
            #choiceConstraint occurrence propulsionInstantiationConstraint :> choiceConstraints {
                doc /* Ensure we have the same nr of turboprops and electric
                propulsion assembly in case hybrid-electric propulsion is chosen. */
                ref :>> choices[2] = (turbopropInstantiationChoiceSys1, electricPropulsionAssemblyInstantiationChoiceSys1);
                :>> constraintType = ChoiceConstraintType::Linked;
            }
        }

        :>> formalDesignProblem {
            :>> designVariables[5] ordered = (transportPaxFulfillmentDesVar, improveAerodynamicsFulfillmentChoiceSys1DesVar,
                generateThrustFulfillmentChoiceSys1DesVar, electricPropulsionAssemblyInstantiationChoiceSys1DesVar,
                turbopropInstantiationChoiceSys1DesVar);

            derived #catX attribute transportPaxFulfillmentDesVar : ScalarValues::Integer {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.transportPaxFulfillmentChoice to transportPaxFulfillmentDesVar;

            derived #catX attribute improveAerodynamicsFulfillmentChoiceSys1DesVar : ScalarValues::Integer {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.improveAerodynamicsFulfillmentChoiceSys1 to improveAerodynamicsFulfillmentChoiceSys1DesVar;

            derived #catX attribute generateThrustFulfillmentChoiceSys1DesVar : ScalarValues::Integer {
                :>> values = (0, 1, 2);
            }
            allocate architecturalChoices.generateThrustFulfillmentChoiceSys1 to generateThrustFulfillmentChoiceSys1DesVar;

            derived #numOrdX attribute electricPropulsionAssemblyInstantiationChoiceSys1DesVar : ScalarValues::Integer {
                :>> values = (2, 4);
            }
            allocate architecturalChoices.electricPropulsionAssemblyInstantiationChoiceSys1 to electricPropulsionAssemblyInstantiationChoiceSys1DesVar;

            derived #numOrdX attribute turbopropInstantiationChoiceSys1DesVar : ScalarValues::Integer {
                :>> values = (2, 4);
            }
            allocate architecturalChoices.turbopropInstantiationChoiceSys1 to turbopropInstantiationChoiceSys1DesVar;
        }
    }

    #architecture part def HybridArchitecture specializes DesignSpace {
        action :>> transportPax[1];

        #concept allocation :>> byAir[1];
        #concept allocation :>> byLand[0];

        action :>> transportPaxByAir[1];
        action :>> transportPaxByLand[0];

        part :>> landTransportSystem[0];

        #subsystem part :>> airTransportSystem[1] {

            #decomposition connection :>> airTransportFunctions[1];

            action :>> containPax;
            action :>> controlAircraft;
            action :>> generateLift;
            action :>> generateThrust;

            part :>> fuselage[1] {
                perform action :>> containPax[1];
            }

            part :>> controlSystem[1] {
                perform action :>> controlAircraft[1];
            }
            action :>> providePower[1];
            part :>> powerGenerationDistributionSystem[1] {
                perform action :>> providePower;
            }

            part :>> wing[2] = (wing1, wing2);
            part wing1 :> wing {
                perform action :>> generateLift;
            }
            part wing2 :> wing {
                perform action :>> generateLift;
            }
            
            action :>> improveAerodynamics[1];
            part :>> winglets[0];
            #nonFulfillment occurrence :>> noWinglets[1] {
                :>> nonFulfilledActions[1] = improveAerodynamics;
            }

            part :>> turboprop[2] = (turboprop1, turboprop2);
            part turboprop1 :> turboprop {
                perform action :>> generateThrust;
            }
            part turboprop2 :> turboprop {
                perform action :>> generateThrust;
            }
            part :>> electricPropulsionAssembly[2] ordered = (electricPropulsionAssembly1, electricPropulsionAssembly2);
            part electricPropulsionAssembly1 :> electricPropulsionAssembly {
                perform action :>> generateThrust;
            }
            part electricPropulsionAssembly2 :> electricPropulsionAssembly {
                perform action :>> generateThrust;
            }
            #multiFulfillment occurrence :>> hybridElectric[1] {
                :>> fulfilledActions[1] = generateThrust;
                :>> fulfillingParts[2] = (turboprop, electricPropulsionAssembly);
            }

        }

        :>> architecturalChoices {
            :>> transportPaxFulfillmentChoice references transportPaxByAir;
            :>> improveAerodynamicsFulfillmentChoiceSys1 references airTransportSystem.noWinglets;
            :>> generateThrustFulfillmentChoiceSys1 references airTransportSystem.hybridElectric;
            :>> electricPropulsionAssemblyInstantiationChoiceSys1 = 2;
            :>> turbopropInstantiationChoiceSys1 = 2;
        }
        :>> formalDesignProblem {
            :>> transportPaxFulfillmentDesVar = 0;
            :>> improveAerodynamicsFulfillmentChoiceSys1DesVar = 1;
            :>> generateThrustFulfillmentChoiceSys1DesVar = 2;
            :>> electricPropulsionAssemblyInstantiationChoiceSys1DesVar = 2;
            :>> turbopropInstantiationChoiceSys1DesVar = 2;
        }
    }
}