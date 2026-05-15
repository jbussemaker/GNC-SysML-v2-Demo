package 'Architecture Package 42120' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #architecture part def <archId42120> 'Architecture #134'
        :> GNCDesignSpace {
        action provideSensorData :>> GNCDesignSpace::provideSensorData;
        action sendActuatorSignal :>> GNCDesignSpace::sendActuatorSignal;
        action controlOrientation :>> GNCDesignSpace::controlOrientation;
        connection dataConnection :>> GNCDesignSpace::dataConnection
            connect sensors.sensorA.dataOutPort to computers.computerC.dataInPort;
        connection actuatorSignalConnection :>> GNCDesignSpace::actuatorSignalConnection [2] = (
            actuatorSignalConnection_1, actuatorSignalConnection_2,
        );
        attribute mass :>> GNCDesignSpace::mass = 24 [SI::kilogram];
        attribute failureRate :>> GNCDesignSpace::failureRate = 0.00017003699320012;
        attribute logFailureRate :>> GNCDesignSpace::logFailureRate = -3.7694565833575946;
        #subsystem part sensors
            :>> GNCDesignSpace::sensors {
            part sensorA :>> GNCDesignSpace::sensors::sensorA {
                perform
                    provideSensorData [1]
                    :>> GNCDesignSpace::sensors::sensorA::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorA::mass = 3 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorA::failureRate = 0.00015;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorB :>> GNCDesignSpace::sensors::sensorB [0];
            part sensorC :>> GNCDesignSpace::sensors::sensorC [0];
            attribute mass :>> GNCDesignSpace::sensors::mass = 3 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate = 0.00015;
        }
        #subsystem part computers
            :>> GNCDesignSpace::computers {
            part computerC :>> GNCDesignSpace::computers::computerC {
                perform
                    sendActuatorSignal [1]
                    :>> GNCDesignSpace::computers::computerC::sendActuatorSignalPerformance;
                attribute mass :>> GNCDesignSpace::computers::computerC::mass = 10 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::computers::computerC::failureRate = 2e-05;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [2];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [1]; }
                #needsAction ::> provideSensorData;
            }
            part computerA :>> GNCDesignSpace::computers::computerA [0];
            part computerB :>> GNCDesignSpace::computers::computerB [0];
            attribute mass :>> GNCDesignSpace::computers::mass = 10 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::computers::failureRate = 2e-05;
        }
        part actuators :>> GNCDesignSpace::actuators [2] = (actuators_1, actuators_2,);
        #subsystem part actuators_1
            :> actuators {
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB {
                perform
                    controlOrientation [1]
                    :>> GNCDesignSpace::actuators::actuatorB::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorB::mass = 5.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorB::failureRate =
                    0.0002;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA [0];
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC [0];
            attribute mass :>> GNCDesignSpace::actuators::mass = 5.5 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate = 0.0002;
        }
        #subsystem part actuators_2
            :> actuators {
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB {
                perform
                    controlOrientation [1]
                    :>> GNCDesignSpace::actuators::actuatorB::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorB::mass = 5.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorB::failureRate =
                    0.0002;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA [0];
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC [0];
            attribute mass :>> GNCDesignSpace::actuators::mass = 5.5 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate = 0.0002;
        }
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers.computerC.actuationSignalOutPort
            to actuators_1.actuatorB.actuationSignalInPort;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers.computerC.actuationSignalOutPort
            to actuators_2.actuatorB.actuationSignalInPort;
        architecturalChoices :>> GNCDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 2;
            computersInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::computersInstantiationChoice = 1;
            sensorsInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::sensorsInstantiationChoice = 1;
            controlOrientationFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators_1.actuatorB;
            controlOrientationFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2
                ::> actuators_2.actuatorB;
            controlOrientationFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys3
                [0];
            sendActuatorSignalFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys1
                ::> computers.computerC;
            sendActuatorSignalFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys2
                [0];
            sendActuatorSignalFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys3
                [0];
            provideSensorDataFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1
                ::> sensors.sensorA;
            provideSensorDataFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2
                [0];
            provideSensorDataFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3
                [0];
            actuatorSignalConnectionConnectionChoice
                :>> GNCDesignSpace::architecturalChoices::actuatorSignalConnectionConnectionChoice
                ::> actuatorSignalConnection_1;
            dataConnectionConnectionChoice
                :>> GNCDesignSpace::architecturalChoices::dataConnectionConnectionChoice
                ::> dataConnection;
        }
        formalDesignProblem :>> GNCDesignSpace::formalDesignProblem {
            actuatorsInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::actuatorsInstantiationDesVar = 2;
            controlOrientationFulfillmentChoiceSys1DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys1DesVar = 1;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys2DesVar = 1;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys3DesVar = null;
            computersInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::computersInstantiationDesVar = 1;
            sendActuatorSignalFulfillmentChoiceSys1DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys1DesVar = 2;
            sendActuatorSignalFulfillmentChoiceSys2DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys2DesVar = null;
            sendActuatorSignalFulfillmentChoiceSys3DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys3DesVar = null;
            sensorsInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 1;
            provideSensorDataFulfillmentChoiceSys1DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys1DesVar = 0;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys2DesVar = null;
            provideSensorDataFulfillmentChoiceSys3DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys3DesVar = null;
            actuatorSignalConnectionConnectionDesVar
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar =
                1;
            actuatorSignalConnectionConnectionDesVar2
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar2 =
                1;
            actuatorSignalConnectionConnectionDesVar3
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar3 =
                null;
            actuatorSignalConnectionConnectionDesVar4
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar4 =
                null;
            actuatorSignalConnectionConnectionDesVar5
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar5 =
                null;
            actuatorSignalConnectionConnectionDesVar6
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar6 =
                null;
            actuatorSignalConnectionConnectionDesVar7
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar7 =
                null;
            actuatorSignalConnectionConnectionDesVar8
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar8 =
                null;
            actuatorSignalConnectionConnectionDesVar9
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar9 =
                null;
            dataConnectionConnectionDesVar
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar = 1;
            dataConnectionConnectionDesVar2
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar2 = null;
            dataConnectionConnectionDesVar3
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar3 = null;
            dataConnectionConnectionDesVar4
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar4 = null;
            dataConnectionConnectionDesVar5
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar5 = null;
            dataConnectionConnectionDesVar6
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar6 = null;
            dataConnectionConnectionDesVar7
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar7 = null;
            dataConnectionConnectionDesVar8
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar8 = null;
            dataConnectionConnectionDesVar9
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar9 = null;
        }
    }
}
