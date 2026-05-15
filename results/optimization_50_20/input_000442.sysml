package 'Architecture Package 171259' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #architecture part def <archId171259> 'Architecture #442' :> GNCDesignSpace {
        action provideSensorData :>> GNCDesignSpace::provideSensorData;
        action sendActuatorSignal :>> GNCDesignSpace::sendActuatorSignal;
        action controlOrientation :>> GNCDesignSpace::controlOrientation;
        connection dataConnection :>> GNCDesignSpace::dataConnection [6] = (
            dataConnection_1, dataConnection_2, dataConnection_3, dataConnection_4, dataConnection_5, dataConnection_6,
        );
        connection actuatorSignalConnection :>> GNCDesignSpace::actuatorSignalConnection [5] = (
            actuatorSignalConnection_1, actuatorSignalConnection_2, actuatorSignalConnection_3,
            actuatorSignalConnection_4, actuatorSignalConnection_5,
        );
        attribute mass :>> GNCDesignSpace::mass;
        attribute failureRate :>> GNCDesignSpace::failureRate;
        attribute logFailureRate :>> GNCDesignSpace::logFailureRate;
        part sensors :>> GNCDesignSpace::sensors [3] = (sensors_1, sensors_2, sensors_3,);
        part computers :>> GNCDesignSpace::computers [3] = (computers_1, computers_2, computers_3,);
        part actuators :>> GNCDesignSpace::actuators [3] = (actuators_1, actuators_2, actuators_3,);
        #subsystem part sensors_1 :> sensors {
            part sensorB :>> GNCDesignSpace::sensors::sensorB {
                perform provideSensorData [1] :>> GNCDesignSpace::sensors::sensorB::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorB::mass = 6 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorB::failureRate = 0.0001;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [2]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorC :>> GNCDesignSpace::sensors::sensorC [0];
            attribute mass :>> GNCDesignSpace::sensors::mass;
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate;
        }
        #subsystem part sensors_2 :> sensors {
            part sensorC :>> GNCDesignSpace::sensors::sensorC {
                perform provideSensorData [1] :>> GNCDesignSpace::sensors::sensorC::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorC::mass = 9 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorC::failureRate = 5e-05;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [2]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorB :>> GNCDesignSpace::sensors::sensorB [0];
            attribute mass :>> GNCDesignSpace::sensors::mass;
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate;
        }
        #subsystem part sensors_3 :> sensors {
            part sensorC :>> GNCDesignSpace::sensors::sensorC {
                perform provideSensorData [1] :>> GNCDesignSpace::sensors::sensorC::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorC::mass = 9 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorC::failureRate = 5e-05;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [2]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorB :>> GNCDesignSpace::sensors::sensorB [0];
            attribute mass :>> GNCDesignSpace::sensors::mass;
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate;
        }
        #subsystem part computers_1 :> computers {
            part computerB :>> GNCDesignSpace::computers::computerB {
                perform sendActuatorSignal [1] :>> GNCDesignSpace::computers::computerB::sendActuatorSignalPerformance;
                attribute mass :>> GNCDesignSpace::computers::computerB::mass = 5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::computers::computerB::failureRate = 4e-05;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [2]; }
                #needsAction ::> provideSensorData;
            }
            part computerA :>> GNCDesignSpace::computers::computerA [0];
            part computerC :>> GNCDesignSpace::computers::computerC [0];
            attribute mass :>> GNCDesignSpace::computers::mass;
            attribute failureRate :>> GNCDesignSpace::computers::failureRate;
        }
        #subsystem part computers_2 :> computers {
            part computerB :>> GNCDesignSpace::computers::computerB {
                perform sendActuatorSignal [1] :>> GNCDesignSpace::computers::computerB::sendActuatorSignalPerformance;
                attribute mass :>> GNCDesignSpace::computers::computerB::mass = 5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::computers::computerB::failureRate = 4e-05;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [2];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [3]; }
                #needsAction ::> provideSensorData;
            }
            part computerA :>> GNCDesignSpace::computers::computerA [0];
            part computerC :>> GNCDesignSpace::computers::computerC [0];
            attribute mass :>> GNCDesignSpace::computers::mass;
            attribute failureRate :>> GNCDesignSpace::computers::failureRate;
        }
        #subsystem part computers_3 :> computers {
            part computerB :>> GNCDesignSpace::computers::computerB {
                perform sendActuatorSignal [1] :>> GNCDesignSpace::computers::computerB::sendActuatorSignalPerformance;
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
            attribute mass :>> GNCDesignSpace::computers::mass;
            attribute failureRate :>> GNCDesignSpace::computers::failureRate;
        }
        #subsystem part actuators_1 :> actuators {
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC {
                perform controlOrientation [1] :>> GNCDesignSpace::actuators::actuatorC::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorC::mass = 9.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorC::failureRate = 0.0001;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA [0];
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB [0];
            attribute mass :>> GNCDesignSpace::actuators::mass;
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate;
        }
        #subsystem part actuators_2 :> actuators {
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC {
                perform controlOrientation [1] :>> GNCDesignSpace::actuators::actuatorC::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorC::mass = 9.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorC::failureRate = 0.0001;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA [0];
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB [0];
            attribute mass :>> GNCDesignSpace::actuators::mass;
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate;
        }
        #subsystem part actuators_3 :> actuators {
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC {
                perform controlOrientation [1] :>> GNCDesignSpace::actuators::actuatorC::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorC::mass = 9.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorC::failureRate = 0.0001;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [3];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA [0];
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB [0];
            attribute mass :>> GNCDesignSpace::actuators::mass;
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate;
        }
        connection dataConnection_1 :> dataConnection
            connect sensors_1.sensorB.dataOutPort to computers_3.computerB.dataInPort;
        connection dataConnection_2 :> dataConnection
            connect sensors_1.sensorB.dataOutPort to computers_2.computerB.dataInPort;
        connection dataConnection_3 :> dataConnection
            connect sensors_2.sensorC.dataOutPort to computers_2.computerB.dataInPort;
        connection dataConnection_4 :> dataConnection
            connect sensors_2.sensorC.dataOutPort to computers_1.computerB.dataInPort;
        connection dataConnection_5 :> dataConnection
            connect sensors_3.sensorC.dataOutPort to computers_2.computerB.dataInPort;
        connection dataConnection_6 :> dataConnection
            connect sensors_3.sensorC.dataOutPort to computers_1.computerB.dataInPort;
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers_1.computerB.actuationSignalOutPort
            to actuators_3.actuatorC.actuationSignalInPort;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers_2.computerB.actuationSignalOutPort
            to actuators_3.actuatorC.actuationSignalInPort;
        connection actuatorSignalConnection_3 :> actuatorSignalConnection
            connect computers_2.computerB.actuationSignalOutPort
            to actuators_1.actuatorC.actuationSignalInPort;
        connection actuatorSignalConnection_4 :> actuatorSignalConnection
            connect computers_3.computerB.actuationSignalOutPort
            to actuators_3.actuatorC.actuationSignalInPort;
        connection actuatorSignalConnection_5 :> actuatorSignalConnection
            connect computers_3.computerB.actuationSignalOutPort
            to actuators_2.actuatorC.actuationSignalInPort;
        architecturalChoices :>> GNCDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice :>> GNCDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 3;
            computersInstantiationChoice :>> GNCDesignSpace::architecturalChoices::computersInstantiationChoice = 3;
            sensorsInstantiationChoice :>> GNCDesignSpace::architecturalChoices::sensorsInstantiationChoice = 3;
            controlOrientationFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators_1.actuatorC;
            controlOrientationFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2
                ::> actuators_2.actuatorC;
            controlOrientationFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys3
                ::> actuators_3.actuatorC;
            sendActuatorSignalFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys1
                ::> computers_1.computerB;
            sendActuatorSignalFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys2
                ::> computers_2.computerB;
            sendActuatorSignalFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys3
                ::> computers_3.computerB;
            provideSensorDataFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1 ::> sensors_1.sensorB;
            provideSensorDataFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2 ::> sensors_2.sensorC;
            provideSensorDataFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3 ::> sensors_3.sensorC;
            actuatorSignalConnectionConnectionChoice
                :>> GNCDesignSpace::architecturalChoices::actuatorSignalConnectionConnectionChoice
                ::> actuatorSignalConnection_1;
            dataConnectionConnectionChoice
                :>> GNCDesignSpace::architecturalChoices::dataConnectionConnectionChoice ::> dataConnection_1;
        }
        formalDesignProblem :>> GNCDesignSpace::formalDesignProblem {
            actuatorsInstantiationDesVar :>> GNCDesignSpace::formalDesignProblem::actuatorsInstantiationDesVar = 3;
            controlOrientationFulfillmentChoiceSys1DesVar
                :>> GNCDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys1DesVar = 2;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>> GNCDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys2DesVar = 2;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>> GNCDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys3DesVar = 2;
            computersInstantiationDesVar :>> GNCDesignSpace::formalDesignProblem::computersInstantiationDesVar = 3;
            sendActuatorSignalFulfillmentChoiceSys1DesVar
                :>> GNCDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys1DesVar = 1;
            sendActuatorSignalFulfillmentChoiceSys2DesVar
                :>> GNCDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys2DesVar = 1;
            sendActuatorSignalFulfillmentChoiceSys3DesVar
                :>> GNCDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys3DesVar = 1;
            sensorsInstantiationDesVar :>> GNCDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 3;
            provideSensorDataFulfillmentChoiceSys1DesVar
                :>> GNCDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys1DesVar = 1;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>> GNCDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys2DesVar = 2;
            provideSensorDataFulfillmentChoiceSys3DesVar
                :>> GNCDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys3DesVar = 2;
            actuatorSignalConnectionConnectionDesVar
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar = 0;
            actuatorSignalConnectionConnectionDesVar2
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar2 = 0;
            actuatorSignalConnectionConnectionDesVar3
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar3 = 1;
            actuatorSignalConnectionConnectionDesVar4
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar4 = 0;
            actuatorSignalConnectionConnectionDesVar5
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar5 = 1;
            actuatorSignalConnectionConnectionDesVar6
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar6 = 1;
            actuatorSignalConnectionConnectionDesVar7
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar7 = 1;
            actuatorSignalConnectionConnectionDesVar8
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar8 = 0;
            actuatorSignalConnectionConnectionDesVar9
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar9 = 1;
            dataConnectionConnectionDesVar :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar = 0;
            dataConnectionConnectionDesVar2 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar2 =
                1;
            dataConnectionConnectionDesVar3 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar3 =
                1;
            dataConnectionConnectionDesVar4 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar4 =
                1;
            dataConnectionConnectionDesVar5 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar5 =
                0;
            dataConnectionConnectionDesVar6 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar6 =
                1;
            dataConnectionConnectionDesVar7 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar7 =
                1;
            dataConnectionConnectionDesVar8 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar8 =
                0;
            dataConnectionConnectionDesVar9 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar9 =
                1;
        }
    }
}
