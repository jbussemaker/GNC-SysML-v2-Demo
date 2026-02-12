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

    // Determine data and actuation signal ports
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
        attribute mass : ISQ::MassValue;
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

    // Object type database, with different masses and failure rates for each type

    part def SensorA :> Sensor { :>> mass default 3.0 [kg]; :>> failureRate default .00015; }
    part def SensorB :> Sensor { :>> mass default 6.0 [kg]; :>> failureRate default .00010; }
    part def SensorC :> Sensor { :>> mass default 9.0 [kg]; :>> failureRate default .00005; }

    part def ComputerA :> Computer { :>> mass default 3.0 [kg]; :>> failureRate default .00010; }
    part def ComputerB :> Computer { :>> mass default 5.0 [kg]; :>> failureRate default .00004; }
    part def ComputerC :> Computer { :>> mass default 10.0 [kg]; :>> failureRate default .00002; }

    part def ActuatorA :> Actuator { :>> mass default 3.5 [kg]; :>> failureRate default .00008; }
    part def ActuatorB :> Actuator { :>> mass default 5.5 [kg]; :>> failureRate default .00020; }
    part def ActuatorC :> Actuator { :>> mass default 9.5 [kg]; :>> failureRate default .00010; }

    // The architecture design space, which is synchronized with the ADORE model
    #architectureDesignSpace part gncDesignSpace : Object {

        #minObj attribute :>> mass default QuantityCalculations::sum(
            (sensors.mass, computers.mass, actuators.mass)
        ) {
            doc /* Redefinition of the mass as a minimization objective. */
            :>> units = kg; // Automatically deduced from ISQ::MassValue
        }

        #evalOut attribute :>> failureRate {
            doc /* Redefinition of the failure rate as a generic output metric. */
            :>> role = OutputRole::Metric;
        }

        #minObj attribute logFailureRate {
            doc /* Log failure rate, which will be the second minimization objective. */
        }

        // Function performed by the sensors
        action provideSensorData [0..1];

        #subsystem part sensors : Object [1..3] {
            doc /* Sensors subsystem, which can be instantiated between 1 and 3 times. */

            // System-level attributes
            #evalOut attribute :>> mass default QuantityCalculations::sum(
                (sensorA.mass, sensorB.mass, sensorC.mass)
            ) {
                :>> units = kg;
                :>> role = OutputRole::Metric;
            }

            #evalOut attribute :>> failureRate {
                :>> role = OutputRole::Metric;
            }

            // Sensor type alternatives
            part sensorA : SensorA [0..1] {
                // Action performance link
                perform action provideSensorDataPerformance ::> provideSensorData;

                attribute :>> mass;
                attribute :>> failureRate;
            }
            part sensorB : SensorB [0..1] {
                perform action provideSensorDataPerformance ::> provideSensorData;
                
                attribute :>> mass;
                attribute :>> failureRate;
            }
            part sensorC : SensorC [0..1] {
                perform action provideSensorDataPerformance ::> provideSensorData;
                
                attribute :>> mass;
                attribute :>> failureRate;
            }
        }

        connection dataConnection [0..1] connect (
            // Output ports
            sensors.sensorA.dataOutPort,
            sensors.sensorB.dataOutPort,
            sensors.sensorC.dataOutPort,

            // Input ports
            computers.computerA.dataInPort,
            computers.computerB.dataInPort,
            computers.computerC.dataInPort
        ) {
            doc
            /* Data connection from sensors to computers. */
        }

        // Computer function and parts
        action sendActuatorSignal [0..1];

        #subsystem part computers : Object [1..3] {
            
            #evalOut attribute mass :>> mass default QuantityCalculations::sum(
                (computerA.mass, computerB.mass, computerC.mass)
            ) {
                units :>> units = kg;
                role :>> role = OutputRole::Metric;
            }

            #evalOut attribute :>> failureRate {
                :>> role = OutputRole::Metric;
            }

            part computerA : ComputerA [0..1] {
                // Action performance link
                perform action sendActuatorSignalPerformance ::> sendActuatorSignal;

                // Needs action (function induction) link
                #needsAction ::> provideSensorData;

                attribute :>> mass;
                attribute :>> failureRate;
            }
            part computerB : ComputerB [0..1] {
                perform action sendActuatorSignalPerformance ::> sendActuatorSignal;
                #needsAction ::> provideSensorData;
                
                attribute :>> mass;
                attribute :>> failureRate;
            }
            part computerC : ComputerC [0..1] {
                perform action sendActuatorSignalPerformance ::> sendActuatorSignal;
                #needsAction ::> provideSensorData;

                attribute :>> mass;
                attribute :>> failureRate;
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
            doc /* Computer to actuator connections. */
        }

        // Actuator function, which is a top-level (boundary) function
        action controlOrientation :> boundaryFunctions;

        #subsystem part actuators : Object [1..3] {
            
            #evalOut attribute :>> mass default QuantityCalculations::sum(
                (actuatorA.mass, actuatorB.mass, actuatorC.mass)
            ) {
                :>> units = kg;
                :>> role = OutputRole::Metric;
            }
            
            #evalOut attribute :>> failureRate {
                :>> role = OutputRole::Metric;
            }

            part actuatorA : ActuatorA [0..1] {
                perform action controlOrientationPerformance ::> controlOrientation;
                #needsAction ::> sendActuatorSignal;

                attribute :>> mass;
                attribute :>> failureRate;
            }
            part actuatorB : ActuatorB [0..1] {
                perform action controlOrientationPerformance ::> controlOrientation;
                #needsAction ::> sendActuatorSignal;

                attribute :>> mass;
                attribute :>> failureRate;
            }
            part actuatorC : ActuatorC [0..1] {
                perform action controlOrientationPerformance ::> controlOrientation;
                #needsAction ::> sendActuatorSignal;

                attribute :>> mass;
                attribute :>> failureRate;
            }
        }
        
        // Listing of the architectural choices defined in this design space (exported by ADORE)
        :>> architecturalChoices {

            :>> choices [14] = (
                // Subsystem instantiation choices
                actuatorsInstantiationChoice, computersInstantiationChoice, sensorsInstantiationChoice,

                // Function fulfillment choices, for selecting the object types
                controlOrientationFulfillmentChoiceSys1, controlOrientationFulfillmentChoiceSys2,
                controlOrientationFulfillmentChoiceSys3,
                
                sendActuatorSignalFulfillmentChoiceSys1, sendActuatorSignalFulfillmentChoiceSys2,
                sendActuatorSignalFulfillmentChoiceSys3,
                
                provideSensorDataFulfillmentChoiceSys1, provideSensorDataFulfillmentChoiceSys2,
                provideSensorDataFulfillmentChoiceSys3,
                
                // Port connection choices
                actuatorSignalConnectionConnectionChoice, dataConnectionConnectionChoice
            );

            // Subsystem instantiation choices
            attribute actuatorsInstantiationChoice :> choices, InstantiationChoice {
                doc /* Instantiation choice for the actuators subsystem, with between 1 and 3 instances. */
                :>> instantiatingElement = actuators;
                :>> values [3] = (1, 2, 3);
            }
            attribute computersInstantiationChoice :> choices, InstantiationChoice {
                :>> instantiatingElement = computers;
                :>> values [3] = (1, 2, 3);
            }
            attribute sensorsInstantiationChoice :> choices, InstantiationChoice {
                :>> instantiatingElement = sensors;
                :>> values [3] = (1, 2, 3);
            }

            // Actuator type choices (one for each actuators subsystem instance)
            occurrence controlOrientationFulfillmentChoiceSys1 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = controlOrientation;
                :>> performingAlternatives [3] = (
                    actuators#(1).actuatorA, actuators#(1).actuatorB, actuators#(1).actuatorC);
            }
            occurrence controlOrientationFulfillmentChoiceSys2 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = controlOrientation;
                :>> performingAlternatives [3] = (
                    actuators#(2).actuatorA, actuators#(2).actuatorB, actuators#(2).actuatorC);
            }
            occurrence controlOrientationFulfillmentChoiceSys3 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = controlOrientation;
                :>> performingAlternatives [3] = (
                    actuators#(3).actuatorA, actuators#(3).actuatorB, actuators#(3).actuatorC);
            }

            // Computer type choices (one for each computers subsystem instance)
            occurrence sendActuatorSignalFulfillmentChoiceSys1 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = sendActuatorSignal;
                :>> performingAlternatives [3] = (
                    computers#(1).computerA, computers#(1).computerB, computers#(1).computerC);
            }
            occurrence sendActuatorSignalFulfillmentChoiceSys2 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = sendActuatorSignal;
                :>> performingAlternatives [3] = (
                    computers#(2).computerA, computers#(2).computerB, computers#(2).computerC);
            }
            occurrence sendActuatorSignalFulfillmentChoiceSys3 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = sendActuatorSignal;
                :>> performingAlternatives [3] = (
                    computers#(3).computerA, computers#(3).computerB, computers#(3).computerC);
            }
            
            // Sensor type choices (one for each sensors subsystem instance)
            occurrence provideSensorDataFulfillmentChoiceSys1 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = provideSensorData;
                :>> performingAlternatives [3] = (
                    sensors#(1).sensorA, sensors#(1).sensorB, sensors#(1).sensorC);
            }
            occurrence provideSensorDataFulfillmentChoiceSys2 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = provideSensorData;
                :>> performingAlternatives [3] = (
                    sensors#(2).sensorA, sensors#(2).sensorB, sensors#(2).sensorC);
            }
            occurrence provideSensorDataFulfillmentChoiceSys3 :> choices : FunctionFulfillmentChoice {
                :>> actionToPerform = provideSensorData;
                :>> performingAlternatives [3] = (
                    sensors#(3).sensorA, sensors#(3).sensorB, sensors#(3).sensorC);
            }

            // Port connection choices
            abstract connection actuatorSignalConnectionConnectionChoice :> choices : PortConnectionChoice {
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
            abstract connection dataConnectionConnectionChoice :> choices : PortConnectionChoice {
                :>> sourcePorts [3] = (
                    sensors.sensorA.dataOutPort, sensors.sensorB.dataOutPort, sensors.sensorC.dataOutPort
                );
                :>> targetPorts [3] = (
                    computers.computerA.dataInPort, computers.computerB.dataInPort, computers.computerC.dataInPort
                );
                :>> associatedConnection = dataConnection;
            }

            // Choice constrains between the object type choices, to ensure only unordered combinations can be chosen:
            // This is needed, because otherwise permutations of object types would be treated as separate architecture
            // instances, whereas this is not captured in the evaluation function.
            // "Unordered combinations" means that AAA, AAB, ABB, ABC etc are possible, but BAA not for example,
            // as that would be a permutation of AAB.
            :>> choiceConstraints [3] = (choiceConstraint1, choiceConstraint2, choiceConstraint3);

            #choiceConstraint occurrence choiceConstraint1 :> choiceConstraints {
                :>> choices = (
                    controlOrientationFulfillmentChoiceSys1, controlOrientationFulfillmentChoiceSys2,
                    controlOrientationFulfillmentChoiceSys3
                );
                :>> constraintType = ChoiceConstraintType::UnorderedCombinations;
            }
            #choiceConstraint occurrence choiceConstraint2 :> choiceConstraints {
                :>> choices = (
                    sendActuatorSignalFulfillmentChoiceSys1, sendActuatorSignalFulfillmentChoiceSys2,
                    sendActuatorSignalFulfillmentChoiceSys3
                );
                :>> constraintType = ChoiceConstraintType::UnorderedCombinations;
            }
            #choiceConstraint occurrence choiceConstraint3 :> choiceConstraints {
                :>> choices = (
                    provideSensorDataFulfillmentChoiceSys1, provideSensorDataFulfillmentChoiceSys2,
                    provideSensorDataFulfillmentChoiceSys3
                );
                :>> constraintType = ChoiceConstraintType::UnorderedCombinations;
            }
        }

        // Formalization of the design problem into a set of design variables, objectives and constraints
        :>> formalDesignProblem {

            :>> designVariables [30] = (
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
                actuatorSignalConnectionConnectionDesVar9,
                
                dataConnectionConnectionDesVar, dataConnectionConnectionDesVar2, dataConnectionConnectionDesVar3,
                dataConnectionConnectionDesVar4, dataConnectionConnectionDesVar5, dataConnectionConnectionDesVar6,
                dataConnectionConnectionDesVar7, dataConnectionConnectionDesVar8, dataConnectionConnectionDesVar9
            );

            // Design variables allocated to actuator instantiation and type choices
            #integerDesignVariable attribute actuatorsInstantiationDesVar :> designVariables {
                :>> lowerBound = 1;
                :>> upperBound = 3;
            }
            // Each architectural choices is allocated to one or more design variables
            allocate architecturalChoices.actuatorsInstantiationChoice to actuatorsInstantiationDesVar;

            #categoricalDesignVariable attribute controlOrientationFulfillmentChoiceSys1DesVar
                :> designVariables {
                :>> values = (0, 1, 2);
            }
            allocate architecturalChoices.controlOrientationFulfillmentChoiceSys1
                to controlOrientationFulfillmentChoiceSys1DesVar;
            
            #categoricalDesignVariable attribute controlOrientationFulfillmentChoiceSys2DesVar
                :> designVariables {
                :>> values = (0, 1, 2);
            }
            allocate architecturalChoices.controlOrientationFulfillmentChoiceSys2
                to controlOrientationFulfillmentChoiceSys2DesVar;
            
            #categoricalDesignVariable attribute controlOrientationFulfillmentChoiceSys3DesVar
                :> designVariables {
                :>> values = (0, 1, 2);
            }
            allocate architecturalChoices.controlOrientationFulfillmentChoiceSys3
                to controlOrientationFulfillmentChoiceSys3DesVar;
            
            // Computer instantiation and type design variables
            #integerDesignVariable attribute computersInstantiationDesVar :> designVariables {
                :>> lowerBound = 1;
                :>> upperBound = 3;
            }
            allocate architecturalChoices.computersInstantiationChoice to computersInstantiationDesVar;

            #categoricalDesignVariable attribute sendActuatorSignalFulfillmentChoiceSys1DesVar
                :> designVariables {
                :>> values = (0, 1, 2);
            }
            allocate architecturalChoices.sendActuatorSignalFulfillmentChoiceSys1
                to sendActuatorSignalFulfillmentChoiceSys1DesVar;

            #categoricalDesignVariable attribute sendActuatorSignalFulfillmentChoiceSys2DesVar
                :> designVariables {
                :>> values = (0, 1, 2);
            }
            allocate architecturalChoices.sendActuatorSignalFulfillmentChoiceSys2
                to sendActuatorSignalFulfillmentChoiceSys2DesVar;
            
            #categoricalDesignVariable attribute sendActuatorSignalFulfillmentChoiceSys3DesVar
                :> designVariables {
                :>> values = (0, 1, 2);
            }
            allocate architecturalChoices.sendActuatorSignalFulfillmentChoiceSys3
                to sendActuatorSignalFulfillmentChoiceSys3DesVar;
            
            // Sensor instantiation and type design variables
            #integerDesignVariable attribute sensorsInstantiationDesVar
                :> designVariables {
                lowerBound :>> lowerBound = 1;
                upperBound :>> upperBound = 3;
            }
            allocate architecturalChoices.sensorsInstantiationChoice to sensorsInstantiationDesVar;

            #categoricalDesignVariable attribute provideSensorDataFulfillmentChoiceSys1DesVar
                :> designVariables {
                :>> values = (0, 1, 2);
            }
            allocate architecturalChoices.provideSensorDataFulfillmentChoiceSys1
                to provideSensorDataFulfillmentChoiceSys1DesVar;
            
            #categoricalDesignVariable attribute provideSensorDataFulfillmentChoiceSys2DesVar
                :> designVariables {
                :>> values = (0, 1, 2);
            }
            allocate architecturalChoices.provideSensorDataFulfillmentChoiceSys2
                to provideSensorDataFulfillmentChoiceSys2DesVar;
            
            #categoricalDesignVariable attribute provideSensorDataFulfillmentChoiceSys3DesVar
                :> designVariables {
                :>> values = (0, 1, 2);
            }
            allocate architecturalChoices.provideSensorDataFulfillmentChoiceSys3
                to provideSensorDataFulfillmentChoiceSys3DesVar;
            
            // Computer to actuator connection design variables
            #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar;
            
            #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar2 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar2;
            
            #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar3 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar3;
            
            #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar4 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar4;
            
            #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar5 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar5;
            
            #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar6 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar6;
            
            #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar7 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar7;
            
            #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar8 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar8;
            
            #categoricalDesignVariable attribute actuatorSignalConnectionConnectionDesVar9 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.actuatorSignalConnectionConnectionChoice
                to actuatorSignalConnectionConnectionDesVar9;
            
            // Sensor to computer connection design variables
            #categoricalDesignVariable attribute dataConnectionConnectionDesVar :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar;
            
            #categoricalDesignVariable attribute dataConnectionConnectionDesVar2 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar2;
            
            #categoricalDesignVariable attribute dataConnectionConnectionDesVar3 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar3;
            
            #categoricalDesignVariable attribute dataConnectionConnectionDesVar4 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar4;
            
            #categoricalDesignVariable attribute dataConnectionConnectionDesVar5 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar5;
            
            #categoricalDesignVariable attribute dataConnectionConnectionDesVar6 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar6;
            
            #categoricalDesignVariable attribute dataConnectionConnectionDesVar7 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar7;
            
            #categoricalDesignVariable attribute dataConnectionConnectionDesVar8 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar8;
            
            #categoricalDesignVariable attribute dataConnectionConnectionDesVar9 :> designVariables {
                :>> values = (0, 1);
            }
            allocate architecturalChoices.dataConnectionConnectionChoice to dataConnectionConnectionDesVar9;

            // The two objectives to optimize for
            :>> objectives [2] = (logFailureRate, mass);
            :>> constraints [0]; // There are no output constraints
        }
    }
}
