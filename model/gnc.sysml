package 'Guidance, Navigation & Control' {
    doc
    /* The Guidance, Navigation and Control (GNC) problem implemented in SysML v2.
     * The GNC problem is a System Architecture Optimization (SAO) problem, that features the
     * selection of the number of objects, object types, and object connections for
     * connecting sensors to computers to actuators.
     * Based on the implementation in SBArchOpt: https://sbarchopt.readthedocs.io/
     *
     * See `annotated_example_architecture.sysml` for an example of an architecture
     * instance defined from the architecture design space.
     */

    private import ScalarValues::*;
    private import SI::kg;

    private import ArchitectureDesign::*;

    item def Data;

    port def DataOutPort {
        doc
        /* Port outputting data. */
        out item data : Data [1..*] ordered {
            doc
            /* The outputted data item.
             * It should establish at least 1 connection, but more can be
             * established for redundancy (to reduce the system-level failure rate).
             * We set it to ordered to declare that it matters in which
             * order connections are established from a part that uses the port.
             */
        }
    }

    item def ActuationSignal;

    port def ActuationSignalOutPort {
        out item actuationSignal : ActuationSignal [1..*] ordered;
    }

    part def Object {
        doc
        /* Base part def for anything with a mass and a failure rate. */
        attribute mass :> ISQ::mass;
        attribute failureRate : Real;
    }

    part def Sensor :> Object {
        doc
        /* Sensor: senses data and sends it to the computer. */

        port dataOutPort : DataOutPort ordered;
    }
    part def Computer :> Object {
        doc
        /* Computer: takes data and computes desired actuation signals. */

        port dataInPort : ~DataOutPort ordered;
        port actuationSignalOutPort : ActuationSignalOutPort ordered;
    }
    part def Actuator :> Object {
        doc
        /* Actuator: applies the actuation signal. */

        port actuationSignalInPort : ~ActuationSignalOutPort ordered;
    }

    part def SensorA :> Sensor {
        :>> mass default 3.0 [kg];
        :>> failureRate default .00015;
    }
    part def SensorB :> Sensor {
        :>> mass default 6.0 [kg];
        :>> failureRate default .00010;
    }
    part def SensorC :> Sensor {
        :>> mass default 9.0 [kg];
        :>> failureRate default .00005;
    }

    part def ComputerA :> Computer {
        :>> mass default 3.0 [kg];
        :>> failureRate default .00010;
    }
    part def ComputerB :> Computer {
        :>> mass default 5.0 [kg];
        :>> failureRate default .00004;
    }
    part def ComputerC :> Computer {
        :>> mass default 10.0 [kg];
        :>> failureRate default .00002;
    }

    part def ActuatorA :> Actuator {
        :>> mass default 3.5 [kg];
        :>> failureRate default .00008;
    }
    part def ActuatorB :> Actuator {
        :>> mass default 5.5 [kg];
        :>> failureRate default .00020;
    }
    part def ActuatorC :> Actuator {
        :>> mass default 9.5 [kg];
        :>> failureRate default .00010;
    }

    abstract #architectureDesignSpace part def GNCDesignSpace :> Object {
        #minObj attribute mass :>> mass default QuantityCalculations::sum(
            (sensors.mass, computers.mass, actuators.mass)
        ) {
            doc
            /* Redefinition of the mass as a minimization objective. */
            units :>> DesignProblemDefs::EvaluationOutput::units = kg;
        }

        #evalOut attribute failureRate :>> failureRate {
            doc
            /* Redefinition of the failure rate as a generic output metric. */
            role :>> DesignProblemDefs::EvaluationOutput::role = DesignProblemDefs::OutputRole::Metric;
        }

        #minObj attribute logFailureRate {
            doc
            /* Log failure rate, which will be the second minimization objective. */
        }

        action provideSensorData [0..1];

        #subsystem part sensors : Object [1..3] {
            doc
            /* Sensors subsystem, which can be instantiated between 1 and 3 times. */

            #evalOut attribute mass :>> mass default QuantityCalculations::sum(
                (sensorA.mass, sensorB.mass, sensorC.mass)
            ) {
                units :>> DesignProblemDefs::EvaluationOutput::units = kg;
                role :>> DesignProblemDefs::EvaluationOutput::role = DesignProblemDefs::OutputRole::Metric;
            }

            #evalOut attribute failureRate :>> failureRate {
                role :>> DesignProblemDefs::EvaluationOutput::role = DesignProblemDefs::OutputRole::Metric;
            }

            part sensorA : SensorA [0..1] {
                perform action provideSensorDataPerformance ::> provideSensorData;
                attribute mass :>> mass;
                attribute failureRate :>> failureRate;
            }
            part sensorB : SensorB [0..1] {
                perform action provideSensorDataPerformance ::> provideSensorData;
                attribute mass :>> mass;
                attribute failureRate :>> failureRate;
            }
            part sensorC : SensorC [0..1] {
                perform action provideSensorDataPerformance ::> provideSensorData;
                attribute mass :>> mass;
                attribute failureRate :>> failureRate;
            }
        }

        connection dataConnection [0..1] connect (
            sensors.sensorA.dataOutPort,
            sensors.sensorB.dataOutPort,
            sensors.sensorC.dataOutPort,
            computers.computerA.dataInPort,
            computers.computerB.dataInPort,
            computers.computerC.dataInPort
        ) {
            doc
            /* Data connection from sensors to computers. */
        }

        action sendActuatorSignal [0..1];

        #subsystem part computers : Object [1..3] {
            #evalOut attribute mass :>> mass default QuantityCalculations::sum(
                (computerA.mass, computerB.mass, computerC.mass)
            ) {
                units :>> DesignProblemDefs::EvaluationOutput::units = kg;
                role :>> DesignProblemDefs::EvaluationOutput::role = DesignProblemDefs::OutputRole::Metric;
            }

            #evalOut attribute failureRate :>> failureRate {
                role :>> DesignProblemDefs::EvaluationOutput::role = DesignProblemDefs::OutputRole::Metric;
            }

            part computerA : ComputerA [0..1] {
                perform action sendActuatorSignalPerformance ::> sendActuatorSignal;
                attribute mass :>> mass;
                attribute failureRate :>> failureRate;
                ref #ArchDesignSpaceDefs::needsAction ::> provideSensorData;
            }
            part computerB : ComputerB [0..1] {
                perform action sendActuatorSignalPerformance ::> sendActuatorSignal;
                attribute mass :>> mass;
                attribute failureRate :>> failureRate;
                ref #ArchDesignSpaceDefs::needsAction ::> provideSensorData;
            }
            part computerC : ComputerC [0..1] {
                perform action sendActuatorSignalPerformance ::> sendActuatorSignal;
                attribute mass :>> mass;
                attribute failureRate :>> failureRate;
                ref #ArchDesignSpaceDefs::needsAction ::> provideSensorData;
            }
        }

        connection actuatorSignalConnection [0..1] connect (
            computers.computerA.actuationSignalOutPort,
            computers.computerB.actuationSignalOutPort,
            computers.computerC.actuationSignalOutPort,
            actuators.actuatorA.actuationSignalInPort,
            actuators.actuatorB.actuationSignalInPort,
            actuators.actuatorC.actuationSignalInPort
        ) {
            doc
            /* Computer to actuator connections. */
        }

        action controlOrientation :> boundaryFunctions;

        #subsystem part actuators : Object [1..3] {
            #evalOut attribute mass :>> mass default QuantityCalculations::sum(
                (actuatorA.mass, actuatorB.mass, actuatorC.mass)
            ) {
                units :>> DesignProblemDefs::EvaluationOutput::units = kg;
                role :>> DesignProblemDefs::EvaluationOutput::role = DesignProblemDefs::OutputRole::Metric;
            }

            #evalOut attribute failureRate :>> failureRate {
                role :>> DesignProblemDefs::EvaluationOutput::role = DesignProblemDefs::OutputRole::Metric;
            }

            part actuatorA : ActuatorA [0..1] {
                perform action controlOrientationPerformance ::> controlOrientation;
                attribute mass :>> mass;
                attribute failureRate :>> failureRate;
                ref #ArchDesignSpaceDefs::needsAction ::> sendActuatorSignal;
            }
            part actuatorB : ActuatorB [0..1] {
                perform action controlOrientationPerformance ::> controlOrientation;
                attribute mass :>> mass;
                attribute failureRate :>> failureRate;
                ref #ArchDesignSpaceDefs::needsAction ::> sendActuatorSignal;
            }
            part actuatorC : ActuatorC [0..1] {
                perform action controlOrientationPerformance ::> controlOrientation;
                attribute mass :>> mass;
                attribute failureRate :>> failureRate;
                ref #ArchDesignSpaceDefs::needsAction ::> sendActuatorSignal;
            }
        }

        :>> architecturalChoices {
            :>> choices [14] ordered = (
                actuatorsInstantiationChoice, computersInstantiationChoice, sensorsInstantiationChoice,
                controlOrientationFulfillmentChoiceSys1, controlOrientationFulfillmentChoiceSys2,
                controlOrientationFulfillmentChoiceSys3, sendActuatorSignalFulfillmentChoiceSys1,
                sendActuatorSignalFulfillmentChoiceSys2, sendActuatorSignalFulfillmentChoiceSys3,
                provideSensorDataFulfillmentChoiceSys1, provideSensorDataFulfillmentChoiceSys2,
                provideSensorDataFulfillmentChoiceSys3, actuatorSignalConnectionConnectionChoice,
                dataConnectionConnectionChoice
            );

            derived attribute actuatorsInstantiationChoice :> choices, InstantiationChoice {
                doc
                /* Instantiation choice for the actuators subsystem, with between 1 and 3 instances. */
                :>> instantiatingElement = actuators;
                :>> values [3] = (1, 2, 3);
            }
            derived attribute computersInstantiationChoice :> choices, InstantiationChoice {
                :>> instantiatingElement = computers;
                :>> values [3] = (1, 2, 3);
            }
            derived attribute sensorsInstantiationChoice :> choices, InstantiationChoice {
                :>> instantiatingElement = sensors;
                :>> values [3] = (1, 2, 3);
            }

            derived occurrence controlOrientationFulfillmentChoiceSys1 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = controlOrientation;
                :>> performingAlternatives [3] = (
                    actuators#(1).actuatorA, actuators#(1).actuatorB, actuators#(1).actuatorC
                );
            }
            derived occurrence controlOrientationFulfillmentChoiceSys2 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = controlOrientation;
                :>> performingAlternatives [3] = (
                    actuators#(2).actuatorA, actuators#(2).actuatorB, actuators#(2).actuatorC
                );
            }
            derived occurrence controlOrientationFulfillmentChoiceSys3 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = controlOrientation;
                :>> performingAlternatives [3] = (
                    actuators#(3).actuatorA, actuators#(3).actuatorB, actuators#(3).actuatorC
                );
            }

            derived occurrence sendActuatorSignalFulfillmentChoiceSys1 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = sendActuatorSignal;
                :>> performingAlternatives [3] = (
                    computers#(1).computerA, computers#(1).computerB, computers#(1).computerC
                );
            }
            derived occurrence sendActuatorSignalFulfillmentChoiceSys2 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = sendActuatorSignal;
                :>> performingAlternatives [3] = (
                    computers#(2).computerA, computers#(2).computerB, computers#(2).computerC
                );
            }
            derived occurrence sendActuatorSignalFulfillmentChoiceSys3 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = sendActuatorSignal;
                :>> performingAlternatives [3] = (
                    computers#(3).computerA, computers#(3).computerB, computers#(3).computerC
                );
            }

            derived occurrence provideSensorDataFulfillmentChoiceSys1 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = provideSensorData;
                :>> performingAlternatives [3] = (sensors#(1).sensorA, sensors#(1).sensorB, sensors#(1).sensorC);
            }
            derived occurrence provideSensorDataFulfillmentChoiceSys2 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = provideSensorData;
                :>> performingAlternatives [3] = (sensors#(2).sensorA, sensors#(2).sensorB, sensors#(2).sensorC);
            }
            derived occurrence provideSensorDataFulfillmentChoiceSys3 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = provideSensorData;
                :>> performingAlternatives [3] = (sensors#(3).sensorA, sensors#(3).sensorB, sensors#(3).sensorC);
            }

            derived abstract connection actuatorSignalConnectionConnectionChoice :> choices : PortConnectionChoice {
                :>> sourcePorts [3] = (
                    computers.computerA.actuationSignalOutPort, computers.computerB.actuationSignalOutPort,
                    computers.computerC.actuationSignalOutPort
                );
                targetPorts :>> targetPorts [3] = (
                    actuators.actuatorA.actuationSignalInPort, actuators.actuatorB.actuationSignalInPort,
                    actuators.actuatorC.actuationSignalInPort
                );
                :>> associatedConnection = actuatorSignalConnection;
            }
            derived abstract connection dataConnectionConnectionChoice :> choices : PortConnectionChoice {
                :>> sourcePorts [3] = (
                    sensors.sensorA.dataOutPort, sensors.sensorB.dataOutPort, sensors.sensorC.dataOutPort
                );
                :>> targetPorts [3] = (
                    computers.computerA.dataInPort, computers.computerB.dataInPort, computers.computerC.dataInPort
                );
                :>> associatedConnection = dataConnection;
            }

            :>> choiceConstraints [3] ordered = (choiceConstraint1, choiceConstraint2, choiceConstraint3);

            #choiceConstraint occurrence choiceConstraint1 :> choiceConstraints {
                :>> choices = (
                    controlOrientationFulfillmentChoiceSys1, controlOrientationFulfillmentChoiceSys2,
                    controlOrientationFulfillmentChoiceSys3
                );
                :>> constraintType = ArchDesignSpaceDefs::ChoiceConstraintType::UnorderedCombinations;
            }
            #choiceConstraint occurrence choiceConstraint2 :> choiceConstraints {
                :>> choices = (
                    sendActuatorSignalFulfillmentChoiceSys1, sendActuatorSignalFulfillmentChoiceSys2,
                    sendActuatorSignalFulfillmentChoiceSys3
                );
                :>> constraintType = ArchDesignSpaceDefs::ChoiceConstraintType::UnorderedCombinations;
            }
            #choiceConstraint occurrence choiceConstraint3 :> choiceConstraints {
                :>> choices = (
                    provideSensorDataFulfillmentChoiceSys1, provideSensorDataFulfillmentChoiceSys2,
                    provideSensorDataFulfillmentChoiceSys3
                );
                :>> constraintType = ArchDesignSpaceDefs::ChoiceConstraintType::UnorderedCombinations;
            }
        }

        :>> formalDesignProblem {
            :>> designVariables [30] ordered = (
                actuatorsInstantiationDesVar, controlOrientationFulfillmentChoiceSys1DesVar,
                controlOrientationFulfillmentChoiceSys2DesVar, controlOrientationFulfillmentChoiceSys3DesVar,
                computersInstantiationDesVar, sendActuatorSignalFulfillmentChoiceSys1DesVar,
                sendActuatorSignalFulfillmentChoiceSys2DesVar, sendActuatorSignalFulfillmentChoiceSys3DesVar,
                sensorsInstantiationDesVar, provideSensorDataFulfillmentChoiceSys1DesVar,
                provideSensorDataFulfillmentChoiceSys2DesVar, provideSensorDataFulfillmentChoiceSys3DesVar,
                actuatorSignalConnectionConnectionDesVar, actuatorSignalConnectionConnectionDesVar2,
                actuatorSignalConnectionConnectionDesVar3, actuatorSignalConnectionConnectionDesVar4,
                actuatorSignalConnectionConnectionDesVar5, actuatorSignalConnectionConnectionDesVar6,
                actuatorSignalConnectionConnectionDesVar7, actuatorSignalConnectionConnectionDesVar8,
                actuatorSignalConnectionConnectionDesVar9, dataConnectionConnectionDesVar,
                dataConnectionConnectionDesVar2, dataConnectionConnectionDesVar3, dataConnectionConnectionDesVar4,
                dataConnectionConnectionDesVar5, dataConnectionConnectionDesVar6, dataConnectionConnectionDesVar7,
                dataConnectionConnectionDesVar8, dataConnectionConnectionDesVar9
            );

            derived #integerDesignVariable attribute actuatorsInstantiationDesVar :> designVariables {
                lowerBound :>> DesignProblemDefs::IntegerDesignVariable::lowerBound = 1;
                upperBound :>> DesignProblemDefs::IntegerDesignVariable::upperBound = 3;
            }
            allocate architecturalChoices.actuatorsInstantiationChoice to actuatorsInstantiationDesVar;
            derived #categoricalDesignVariable attribute controlOrientationFulfillmentChoiceSys1DesVar
                :> designVariables { values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1, 2); }
            allocate architecturalChoices.controlOrientationFulfillmentChoiceSys1
                to controlOrientationFulfillmentChoiceSys1DesVar;
            derived #categoricalDesignVariable attribute controlOrientationFulfillmentChoiceSys2DesVar
                :> designVariables { values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1, 2); }
            allocate architecturalChoices.controlOrientationFulfillmentChoiceSys2
                to controlOrientationFulfillmentChoiceSys2DesVar;
            derived #categoricalDesignVariable attribute controlOrientationFulfillmentChoiceSys3DesVar
                :> designVariables { values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1, 2); }
            allocate architecturalChoices.controlOrientationFulfillmentChoiceSys3
                to controlOrientationFulfillmentChoiceSys3DesVar;
            derived #integerDesignVariable attribute computersInstantiationDesVar :> designVariables {
                lowerBound :>> DesignProblemDefs::IntegerDesignVariable::lowerBound = 1;
                upperBound :>> DesignProblemDefs::IntegerDesignVariable::upperBound = 3;
            }
            allocate architecturalChoices.computersInstantiationChoice to computersInstantiationDesVar;
            derived #categoricalDesignVariable attribute sendActuatorSignalFulfillmentChoiceSys1DesVar
                :> designVariables { values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1, 2); }
            allocate architecturalChoices.sendActuatorSignalFulfillmentChoiceSys1
                to sendActuatorSignalFulfillmentChoiceSys1DesVar;
            derived #categoricalDesignVariable attribute sendActuatorSignalFulfillmentChoiceSys2DesVar
                :> designVariables { values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1, 2); }
            allocate architecturalChoices.sendActuatorSignalFulfillmentChoiceSys2
                to sendActuatorSignalFulfillmentChoiceSys2DesVar;
            derived #categoricalDesignVariable attribute sendActuatorSignalFulfillmentChoiceSys3DesVar
                :> designVariables { values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1, 2); }
            allocate architecturalChoices.sendActuatorSignalFulfillmentChoiceSys3
                to sendActuatorSignalFulfillmentChoiceSys3DesVar;
            derived #integerDesignVariable attribute sensorsInstantiationDesVar :> designVariables {
                lowerBound :>> DesignProblemDefs::IntegerDesignVariable::lowerBound = 1;
                upperBound :>> DesignProblemDefs::IntegerDesignVariable::upperBound = 3;
            }
            allocate architecturalChoices.sensorsInstantiationChoice to sensorsInstantiationDesVar;
            derived #categoricalDesignVariable attribute provideSensorDataFulfillmentChoiceSys1DesVar
                :> designVariables { values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1, 2); }
            allocate architecturalChoices.provideSensorDataFulfillmentChoiceSys1
                to provideSensorDataFulfillmentChoiceSys1DesVar;
            derived #categoricalDesignVariable attribute provideSensorDataFulfillmentChoiceSys2DesVar
                :> designVariables { values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1, 2); }
            allocate architecturalChoices.provideSensorDataFulfillmentChoiceSys2
                to provideSensorDataFulfillmentChoiceSys2DesVar;
            derived #categoricalDesignVariable attribute provideSensorDataFulfillmentChoiceSys3DesVar
                :> designVariables { values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1, 2); }
            allocate architecturalChoices.provideSensorDataFulfillmentChoiceSys3
                to provideSensorDataFulfillmentChoiceSys3DesVar;
            derived #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar;
            derived #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar2 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar2;
            derived #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar3 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar3;
            derived #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar4 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar4;
            derived #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar5 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar5;
            derived #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar6 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar6;
            derived #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar7 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar7;
            derived #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar8 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar8;
            derived #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar9 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar9;
            derived #categoricalDesignVariable attribute dataConnectionConnectionDesVar :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar;
            derived #categoricalDesignVariable attribute dataConnectionConnectionDesVar2 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar2;
            derived #categoricalDesignVariable attribute dataConnectionConnectionDesVar3 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar3;
            derived #categoricalDesignVariable attribute dataConnectionConnectionDesVar4 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar4;
            derived #categoricalDesignVariable attribute dataConnectionConnectionDesVar5 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar5;
            derived #categoricalDesignVariable attribute dataConnectionConnectionDesVar6 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar6;
            derived #categoricalDesignVariable attribute dataConnectionConnectionDesVar7 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar7;
            derived #categoricalDesignVariable attribute dataConnectionConnectionDesVar8 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar8;
            derived #categoricalDesignVariable attribute dataConnectionConnectionDesVar9 :> designVariables {
                values :>> DesignProblemDefs::DiscreteDesignVariable::values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar9;
            :>> objectives [2] ordered = (logFailureRate, mass);
            :>> constraints [0] ordered;
        }
    }
} // package 'Guidance, Navigation & Control'
