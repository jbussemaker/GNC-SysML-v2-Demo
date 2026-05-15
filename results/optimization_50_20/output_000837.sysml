package 'Architecture Package 323425' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #architecture part def <archId323425> 'Architecture #837'
        :> GNCDesignSpace {
        action provideSensorData :>> GNCDesignSpace::provideSensorData;
        action sendActuatorSignal :>> GNCDesignSpace::sendActuatorSignal;
        action controlOrientation :>> GNCDesignSpace::controlOrientation;
        connection dataConnection :>> GNCDesignSpace::dataConnection [3] = (
            dataConnection_1, dataConnection_2, dataConnection_3,
        );
        connection actuatorSignalConnection :>> GNCDesignSpace::actuatorSignalConnection [4] = (
            actuatorSignalConnection_1, actuatorSignalConnection_2, actuatorSignalConnection_3,
            actuatorSignalConnection_4,
        );
        attribute mass :>> GNCDesignSpace::mass = 33 [SI::kilogram];
        attribute failureRate :>> GNCDesignSpace::failureRate = 5.1497149585028497e-08;
        attribute logFailureRate :>> GNCDesignSpace::logFailureRate = -7.288216808895753;
        part sensors :>> GNCDesignSpace::sensors [2] = (sensors_1, sensors_2,);
        part computers :>> GNCDesignSpace::computers [2] = (computers_1, computers_2,);
        part actuators :>> GNCDesignSpace::actuators [2] = (actuators_1, actuators_2,);
        #subsystem part sensors_1
            :> sensors {
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
        #subsystem part sensors_2
            :> sensors {
            part sensorA :>> GNCDesignSpace::sensors::sensorA {
                perform
                    provideSensorData [1]
                    :>> GNCDesignSpace::sensors::sensorA::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorA::mass = 3 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorA::failureRate = 0.00015;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [2]; }
            }
            part sensorB :>> GNCDesignSpace::sensors::sensorB [0];
            part sensorC :>> GNCDesignSpace::sensors::sensorC [0];
            attribute mass :>> GNCDesignSpace::sensors::mass = 3 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate = 0.00015;
        }
        #subsystem part computers_1
            :> computers {
            part computerA :>> GNCDesignSpace::computers::computerA {
                perform
                    sendActuatorSignal [1]
                    :>> GNCDesignSpace::computers::computerA::sendActuatorSignalPerformance;
                attribute mass :>> GNCDesignSpace::computers::computerA::mass = 3 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::computers::computerA::failureRate =
                    0.0001;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [2];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [2]; }
                #needsAction ::> provideSensorData;
            }
            part computerB :>> GNCDesignSpace::computers::computerB [0];
            part computerC :>> GNCDesignSpace::computers::computerC [0];
            attribute mass :>> GNCDesignSpace::computers::mass = 3 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::computers::failureRate = 0.0001;
        }
        #subsystem part computers_2
            :> computers {
            part computerB :>> GNCDesignSpace::computers::computerB {
                perform
                    sendActuatorSignal [1]
                    :>> GNCDesignSpace::computers::computerB::sendActuatorSignalPerformance;
                attribute mass :>> GNCDesignSpace::computers::computerB::mass = 5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::computers::computerB::failureRate = 4e-05;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [2];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [1]; }
                #needsAction ::> provideSensorData;
            }
            part computerA :>> GNCDesignSpace::computers::computerA [0];
            part computerC :>> GNCDesignSpace::computers::computerC [0];
            attribute mass :>> GNCDesignSpace::computers::mass = 5 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::computers::failureRate = 4e-05;
        }
        #subsystem part actuators_1
            :> actuators {
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC {
                perform
                    controlOrientation [1]
                    :>> GNCDesignSpace::actuators::actuatorC::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorC::mass = 9.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorC::failureRate =
                    0.0001;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [2];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA [0];
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB [0];
            attribute mass :>> GNCDesignSpace::actuators::mass = 9.5 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate = 0.0001;
        }
        #subsystem part actuators_2
            :> actuators {
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC {
                perform
                    controlOrientation [1]
                    :>> GNCDesignSpace::actuators::actuatorC::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorC::mass = 9.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorC::failureRate =
                    0.0001;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [2];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA [0];
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB [0];
            attribute mass :>> GNCDesignSpace::actuators::mass = 9.5 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate = 0.0001;
        }
        connection dataConnection_1 :> dataConnection
            connect sensors_1.sensorA.dataOutPort to computers_1.computerA.dataInPort;
        connection dataConnection_2 :> dataConnection
            connect sensors_2.sensorA.dataOutPort to computers_1.computerA.dataInPort;
        connection dataConnection_3 :> dataConnection
            connect sensors_2.sensorA.dataOutPort to computers_2.computerB.dataInPort;
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers_1.computerA.actuationSignalOutPort
            to actuators_2.actuatorC.actuationSignalInPort;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers_1.computerA.actuationSignalOutPort
            to actuators_1.actuatorC.actuationSignalInPort;
        connection actuatorSignalConnection_3 :> actuatorSignalConnection
            connect computers_2.computerB.actuationSignalOutPort
            to actuators_1.actuatorC.actuationSignalInPort;
        connection actuatorSignalConnection_4 :> actuatorSignalConnection
            connect computers_2.computerB.actuationSignalOutPort
            to actuators_2.actuatorC.actuationSignalInPort;
        architecturalChoices :>> GNCDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 2;
            computersInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::computersInstantiationChoice = 2;
            sensorsInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::sensorsInstantiationChoice = 2;
            controlOrientationFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators_1.actuatorC;
            controlOrientationFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2
                ::> actuators_2.actuatorC;
            controlOrientationFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys3
                [0];
            sendActuatorSignalFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys1
                ::> computers_1.computerA;
            sendActuatorSignalFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys2
                ::> computers_2.computerB;
            sendActuatorSignalFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys3
                [0];
            provideSensorDataFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1
                ::> sensors_1.sensorA;
            provideSensorDataFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2
                ::> sensors_2.sensorA;
            provideSensorDataFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3
                [0];
            actuatorSignalConnectionConnectionChoice
                :>> GNCDesignSpace::architecturalChoices::actuatorSignalConnectionConnectionChoice
                ::> actuatorSignalConnection_1;
            dataConnectionConnectionChoice
                :>> GNCDesignSpace::architecturalChoices::dataConnectionConnectionChoice
                ::> dataConnection_1;
        }
        formalDesignProblem :>> GNCDesignSpace::formalDesignProblem {
            actuatorsInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::actuatorsInstantiationDesVar = 2;
            controlOrientationFulfillmentChoiceSys1DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys1DesVar = 2;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys2DesVar = 2;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys3DesVar = null;
            computersInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::computersInstantiationDesVar = 2;
            sendActuatorSignalFulfillmentChoiceSys1DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys1DesVar = 0;
            sendActuatorSignalFulfillmentChoiceSys2DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys2DesVar = 1;
            sendActuatorSignalFulfillmentChoiceSys3DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys3DesVar = null;
            sensorsInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 2;
            provideSensorDataFulfillmentChoiceSys1DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys1DesVar = 0;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys2DesVar = 0;
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
                1;
            actuatorSignalConnectionConnectionDesVar4
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar4 =
                1;
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
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar2 = 0;
            dataConnectionConnectionDesVar3
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar3 = 1;
            dataConnectionConnectionDesVar4
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar4 = 1;
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
