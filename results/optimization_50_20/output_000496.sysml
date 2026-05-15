package 'Architecture Package 190559' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #architecture part def <archId190559> 'Architecture #496'
        :> GNCDesignSpace {
        action provideSensorData :>> GNCDesignSpace::provideSensorData;
        action sendActuatorSignal :>> GNCDesignSpace::sendActuatorSignal;
        action controlOrientation :>> GNCDesignSpace::controlOrientation;
        connection dataConnection :>> GNCDesignSpace::dataConnection [5] = (
            dataConnection_1, dataConnection_2, dataConnection_3, dataConnection_4, dataConnection_5,
        );
        connection actuatorSignalConnection :>> GNCDesignSpace::actuatorSignalConnection [6] = (
            actuatorSignalConnection_1, actuatorSignalConnection_2, actuatorSignalConnection_3,
            actuatorSignalConnection_4, actuatorSignalConnection_5, actuatorSignalConnection_6,
        );
        attribute mass :>> GNCDesignSpace::mass = 35 [SI::kilogram];
        attribute failureRate :>> GNCDesignSpace::failureRate = 2.1401284767491774e-08;
        attribute logFailureRate :>> GNCDesignSpace::logFailureRate = -7.6695601541889475;
        part sensors :>> GNCDesignSpace::sensors [3] = (sensors_1, sensors_2, sensors_3,);
        part computers :>> GNCDesignSpace::computers [3] = (computers_1, computers_2, computers_3,);
        part actuators :>> GNCDesignSpace::actuators [2] = (actuators_1, actuators_2,);
        #subsystem part sensors_1
            :> sensors {
            part sensorA :>> GNCDesignSpace::sensors::sensorA {
                perform
                    provideSensorData [1]
                    :>> GNCDesignSpace::sensors::sensorA::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorA::mass = 3 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorA::failureRate = 0.00015;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [3]; }
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
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorB :>> GNCDesignSpace::sensors::sensorB [0];
            part sensorC :>> GNCDesignSpace::sensors::sensorC [0];
            attribute mass :>> GNCDesignSpace::sensors::mass = 3 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate = 0.00015;
        }
        #subsystem part sensors_3
            :> sensors {
            part sensorC :>> GNCDesignSpace::sensors::sensorC {
                perform
                    provideSensorData [1]
                    :>> GNCDesignSpace::sensors::sensorC::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorC::mass = 9 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorC::failureRate = 5e-05;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorB :>> GNCDesignSpace::sensors::sensorB [0];
            attribute mass :>> GNCDesignSpace::sensors::mass = 9 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate = 5e-05;
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
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [3]; }
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
        #subsystem part computers_3
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
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA {
                perform
                    controlOrientation [1]
                    :>> GNCDesignSpace::actuators::actuatorA::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorA::mass = 3.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorA::failureRate = 8e-05;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [3];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB [0];
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC [0];
            attribute mass :>> GNCDesignSpace::actuators::mass = 3.5 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate = 8e-05;
        }
        #subsystem part actuators_2
            :> actuators {
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA {
                perform
                    controlOrientation [1]
                    :>> GNCDesignSpace::actuators::actuatorA::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorA::mass = 3.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorA::failureRate = 8e-05;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [3];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB [0];
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC [0];
            attribute mass :>> GNCDesignSpace::actuators::mass = 3.5 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate = 8e-05;
        }
        connection dataConnection_1 :> dataConnection
            connect sensors_1.sensorA.dataOutPort to computers_1.computerA.dataInPort;
        connection dataConnection_2 :> dataConnection
            connect sensors_1.sensorA.dataOutPort to computers_2.computerB.dataInPort;
        connection dataConnection_3 :> dataConnection
            connect sensors_1.sensorA.dataOutPort to computers_3.computerB.dataInPort;
        connection dataConnection_4 :> dataConnection
            connect sensors_2.sensorA.dataOutPort to computers_1.computerA.dataInPort;
        connection dataConnection_5 :> dataConnection
            connect sensors_3.sensorC.dataOutPort to computers_1.computerA.dataInPort;
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers_1.computerA.actuationSignalOutPort
            to actuators_2.actuatorA.actuationSignalInPort;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers_1.computerA.actuationSignalOutPort
            to actuators_1.actuatorA.actuationSignalInPort;
        connection actuatorSignalConnection_3 :> actuatorSignalConnection
            connect computers_2.computerB.actuationSignalOutPort
            to actuators_1.actuatorA.actuationSignalInPort;
        connection actuatorSignalConnection_4 :> actuatorSignalConnection
            connect computers_2.computerB.actuationSignalOutPort
            to actuators_2.actuatorA.actuationSignalInPort;
        connection actuatorSignalConnection_5 :> actuatorSignalConnection
            connect computers_3.computerB.actuationSignalOutPort
            to actuators_2.actuatorA.actuationSignalInPort;
        connection actuatorSignalConnection_6 :> actuatorSignalConnection
            connect computers_3.computerB.actuationSignalOutPort
            to actuators_1.actuatorA.actuationSignalInPort;
        architecturalChoices :>> GNCDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 2;
            computersInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::computersInstantiationChoice = 3;
            sensorsInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::sensorsInstantiationChoice = 3;
            controlOrientationFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators_1.actuatorA;
            controlOrientationFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2
                ::> actuators_2.actuatorA;
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
                ::> computers_3.computerB;
            provideSensorDataFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1
                ::> sensors_1.sensorA;
            provideSensorDataFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2
                ::> sensors_2.sensorA;
            provideSensorDataFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3
                ::> sensors_3.sensorC;
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
                        ::controlOrientationFulfillmentChoiceSys1DesVar = 0;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys2DesVar = 0;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys3DesVar = null;
            computersInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::computersInstantiationDesVar = 3;
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
                        ::sendActuatorSignalFulfillmentChoiceSys3DesVar = 1;
            sensorsInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 3;
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
                        ::provideSensorDataFulfillmentChoiceSys3DesVar = 2;
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
                1;
            actuatorSignalConnectionConnectionDesVar6
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar6 =
                1;
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
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar2 = 1;
            dataConnectionConnectionDesVar3
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar3 = 1;
            dataConnectionConnectionDesVar4
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar4 = 1;
            dataConnectionConnectionDesVar5
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar5 = 0;
            dataConnectionConnectionDesVar6
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar6 = 0;
            dataConnectionConnectionDesVar7
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar7 = 1;
            dataConnectionConnectionDesVar8
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar8 = 0;
            dataConnectionConnectionDesVar9
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar9 = 0;
        }
    }
}
