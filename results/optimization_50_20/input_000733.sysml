package 'Architecture Package 284362' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #ArchitectureInstanceDefs::architecture part <archId284362> 'Architecture #733' :> gncDesignSpace {
        action provideSensorData :>> gncDesignSpace::provideSensorData;
        action sendActuatorSignal :>> gncDesignSpace::sendActuatorSignal;
        action controlOrientation :>> gncDesignSpace::controlOrientation;
        connection dataConnection :>> gncDesignSpace::dataConnection [6] = (
            dataConnection_1, dataConnection_2, dataConnection_3, dataConnection_4, dataConnection_5, dataConnection_6,
        );
        connection actuatorSignalConnection :>> gncDesignSpace::actuatorSignalConnection [4] = (
            actuatorSignalConnection_1, actuatorSignalConnection_2, actuatorSignalConnection_3,
            actuatorSignalConnection_4,
        );
        attribute mass :>> gncDesignSpace::mass;
        attribute failureRate :>> gncDesignSpace::failureRate;
        attribute logFailureRate :>> gncDesignSpace::logFailureRate;
        part sensors :>> gncDesignSpace::sensors [3] = (sensors_1, sensors_2, sensors_3,);
        part computers :>> gncDesignSpace::computers [3] = (computers_1, computers_2, computers_3,);
        part actuators :>> gncDesignSpace::actuators [2] = (actuators_1, actuators_2,);
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part sensors_1 :> sensors {
            part sensorB :>> gncDesignSpace::sensors::sensorB {
                perform provideSensorData [1] :>> gncDesignSpace::sensors::sensorB::provideSensorDataPerformance;
                attribute mass :>> gncDesignSpace::sensors::sensorB::mass = 6 [SI::kg];
                attribute failureRate :>> gncDesignSpace::sensors::sensorB::failureRate = 0.0001;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [3]; }
            }
            part sensorA :>> gncDesignSpace::sensors::sensorA [0];
            part sensorC :>> gncDesignSpace::sensors::sensorC [0];
            attribute mass :>> gncDesignSpace::sensors::mass;
            attribute failureRate :>> gncDesignSpace::sensors::failureRate;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part sensors_2 :> sensors {
            part sensorB :>> gncDesignSpace::sensors::sensorB {
                perform provideSensorData [1] :>> gncDesignSpace::sensors::sensorB::provideSensorDataPerformance;
                attribute mass :>> gncDesignSpace::sensors::sensorB::mass = 6 [SI::kg];
                attribute failureRate :>> gncDesignSpace::sensors::sensorB::failureRate = 0.0001;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorA :>> gncDesignSpace::sensors::sensorA [0];
            part sensorC :>> gncDesignSpace::sensors::sensorC [0];
            attribute mass :>> gncDesignSpace::sensors::mass;
            attribute failureRate :>> gncDesignSpace::sensors::failureRate;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part sensors_3 :> sensors {
            part sensorB :>> gncDesignSpace::sensors::sensorB {
                perform provideSensorData [1] :>> gncDesignSpace::sensors::sensorB::provideSensorDataPerformance;
                attribute mass :>> gncDesignSpace::sensors::sensorB::mass = 6 [SI::kg];
                attribute failureRate :>> gncDesignSpace::sensors::sensorB::failureRate = 0.0001;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [2]; }
            }
            part sensorA :>> gncDesignSpace::sensors::sensorA [0];
            part sensorC :>> gncDesignSpace::sensors::sensorC [0];
            attribute mass :>> gncDesignSpace::sensors::mass;
            attribute failureRate :>> gncDesignSpace::sensors::failureRate;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part computers_1 :> computers {
            part computerC :>> gncDesignSpace::computers::computerC {
                perform sendActuatorSignal [1] :>> gncDesignSpace::computers::computerC::sendActuatorSignalPerformance;
                attribute mass :>> gncDesignSpace::computers::computerC::mass = 10 [SI::kg];
                attribute failureRate :>> gncDesignSpace::computers::computerC::failureRate = 2e-05;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [2];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [2]; }
                #ArchitectureChoiceModelingDefs::needsAction ::> provideSensorData;
            }
            part computerA :>> gncDesignSpace::computers::computerA [0];
            part computerB :>> gncDesignSpace::computers::computerB [0];
            attribute mass :>> gncDesignSpace::computers::mass;
            attribute failureRate :>> gncDesignSpace::computers::failureRate;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part computers_2 :> computers {
            part computerC :>> gncDesignSpace::computers::computerC {
                perform sendActuatorSignal [1] :>> gncDesignSpace::computers::computerC::sendActuatorSignalPerformance;
                attribute mass :>> gncDesignSpace::computers::computerC::mass = 10 [SI::kg];
                attribute failureRate :>> gncDesignSpace::computers::computerC::failureRate = 2e-05;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [2]; }
                #ArchitectureChoiceModelingDefs::needsAction ::> provideSensorData;
            }
            part computerA :>> gncDesignSpace::computers::computerA [0];
            part computerB :>> gncDesignSpace::computers::computerB [0];
            attribute mass :>> gncDesignSpace::computers::mass;
            attribute failureRate :>> gncDesignSpace::computers::failureRate;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part computers_3 :> computers {
            part computerC :>> gncDesignSpace::computers::computerC {
                perform sendActuatorSignal [1] :>> gncDesignSpace::computers::computerC::sendActuatorSignalPerformance;
                attribute mass :>> gncDesignSpace::computers::computerC::mass = 10 [SI::kg];
                attribute failureRate :>> gncDesignSpace::computers::computerC::failureRate = 2e-05;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [2]; }
                #ArchitectureChoiceModelingDefs::needsAction ::> provideSensorData;
            }
            part computerA :>> gncDesignSpace::computers::computerA [0];
            part computerB :>> gncDesignSpace::computers::computerB [0];
            attribute mass :>> gncDesignSpace::computers::mass;
            attribute failureRate :>> gncDesignSpace::computers::failureRate;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part actuators_1 :> actuators {
            part actuatorB :>> gncDesignSpace::actuators::actuatorB {
                perform controlOrientation [1] :>> gncDesignSpace::actuators::actuatorB::controlOrientationPerformance;
                attribute mass :>> gncDesignSpace::actuators::actuatorB::mass = 5.5 [SI::kg];
                attribute failureRate :>> gncDesignSpace::actuators::actuatorB::failureRate = 0.0002;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [3];
                }
                #ArchitectureChoiceModelingDefs::needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> gncDesignSpace::actuators::actuatorA [0];
            part actuatorC :>> gncDesignSpace::actuators::actuatorC [0];
            attribute mass :>> gncDesignSpace::actuators::mass;
            attribute failureRate :>> gncDesignSpace::actuators::failureRate;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part actuators_2 :> actuators {
            part actuatorC :>> gncDesignSpace::actuators::actuatorC {
                perform controlOrientation [1] :>> gncDesignSpace::actuators::actuatorC::controlOrientationPerformance;
                attribute mass :>> gncDesignSpace::actuators::actuatorC::mass = 9.5 [SI::kg];
                attribute failureRate :>> gncDesignSpace::actuators::actuatorC::failureRate = 0.0001;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #ArchitectureChoiceModelingDefs::needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> gncDesignSpace::actuators::actuatorA [0];
            part actuatorB :>> gncDesignSpace::actuators::actuatorB [0];
            attribute mass :>> gncDesignSpace::actuators::mass;
            attribute failureRate :>> gncDesignSpace::actuators::failureRate;
        }
        connection dataConnection_1 :> dataConnection
            connect sensors_1.sensorB.dataOutPort.data to computers_1.computerC.dataInPort.data;
        connection dataConnection_2 :> dataConnection
            connect sensors_1.sensorB.dataOutPort.data to computers_2.computerC.dataInPort.data;
        connection dataConnection_3 :> dataConnection
            connect sensors_1.sensorB.dataOutPort.data to computers_3.computerC.dataInPort.data;
        connection dataConnection_4 :> dataConnection
            connect sensors_2.sensorB.dataOutPort.data to computers_3.computerC.dataInPort.data;
        connection dataConnection_5 :> dataConnection
            connect sensors_3.sensorB.dataOutPort.data to computers_1.computerC.dataInPort.data;
        connection dataConnection_6 :> dataConnection
            connect sensors_3.sensorB.dataOutPort.data to computers_2.computerC.dataInPort.data;
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers_1.computerC.actuationSignalOutPort.actuationSignal
            to actuators_1.actuatorB.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers_1.computerC.actuationSignalOutPort.actuationSignal
            to actuators_2.actuatorC.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_3 :> actuatorSignalConnection
            connect computers_2.computerC.actuationSignalOutPort.actuationSignal
            to actuators_1.actuatorB.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_4 :> actuatorSignalConnection
            connect computers_3.computerC.actuationSignalOutPort.actuationSignal
            to actuators_1.actuatorB.actuationSignalInPort.actuationSignal;
        architecturalChoices :>> gncDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice :>> gncDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 2;
            computersInstantiationChoice :>> gncDesignSpace::architecturalChoices::computersInstantiationChoice = 3;
            sensorsInstantiationChoice :>> gncDesignSpace::architecturalChoices::sensorsInstantiationChoice = 3;
            controlOrientationFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators_1.actuatorB;
            controlOrientationFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2
                ::> actuators_2.actuatorC;
            controlOrientationFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys3 [0];
            sendActuatorSignalFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys1
                ::> computers_1.computerC;
            sendActuatorSignalFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys2
                ::> computers_2.computerC;
            sendActuatorSignalFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys3
                ::> computers_3.computerC;
            provideSensorDataFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1 ::> sensors_1.sensorB;
            provideSensorDataFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2 ::> sensors_2.sensorB;
            provideSensorDataFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3 ::> sensors_3.sensorB;
            actuatorSignalConnectionConnectionChoice
                :>> gncDesignSpace::architecturalChoices::actuatorSignalConnectionConnectionChoice
                ::> actuatorSignalConnection_1;
            dataConnectionConnectionChoice
                :>> gncDesignSpace::architecturalChoices::dataConnectionConnectionChoice ::> dataConnection_1;
        }
        formalDesignProblem :>> gncDesignSpace::formalDesignProblem {
            actuatorsInstantiationDesVar :>> gncDesignSpace::formalDesignProblem::actuatorsInstantiationDesVar = 2;
            controlOrientationFulfillmentChoiceSys1DesVar
                :>> gncDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys1DesVar = 1;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>> gncDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys2DesVar = 2;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>> gncDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys3DesVar = null;
            computersInstantiationDesVar :>> gncDesignSpace::formalDesignProblem::computersInstantiationDesVar = 3;
            sendActuatorSignalFulfillmentChoiceSys1DesVar
                :>> gncDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys1DesVar = 2;
            sendActuatorSignalFulfillmentChoiceSys2DesVar
                :>> gncDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys2DesVar = 2;
            sendActuatorSignalFulfillmentChoiceSys3DesVar
                :>> gncDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys3DesVar = 2;
            sensorsInstantiationDesVar :>> gncDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 3;
            provideSensorDataFulfillmentChoiceSys1DesVar
                :>> gncDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys1DesVar = 1;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>> gncDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys2DesVar = 1;
            provideSensorDataFulfillmentChoiceSys3DesVar
                :>> gncDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys3DesVar = 1;
            actuatorSignalConnectionConnectionDesVar
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar = 1;
            actuatorSignalConnectionConnectionDesVar2
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar2 = 1;
            actuatorSignalConnectionConnectionDesVar3
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar3 = 1;
            actuatorSignalConnectionConnectionDesVar4
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar4 = 0;
            actuatorSignalConnectionConnectionDesVar5
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar5 = 1;
            actuatorSignalConnectionConnectionDesVar6
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar6 = 0;
            actuatorSignalConnectionConnectionDesVar7
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar7 = null;
            actuatorSignalConnectionConnectionDesVar8
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar8 = null;
            actuatorSignalConnectionConnectionDesVar9
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar9 = null;
            dataConnectionConnectionDesVar :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar = 1;
            dataConnectionConnectionDesVar2 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar2 =
                1;
            dataConnectionConnectionDesVar3 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar3 =
                1;
            dataConnectionConnectionDesVar4 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar4 =
                1;
            dataConnectionConnectionDesVar5 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar5 =
                1;
            dataConnectionConnectionDesVar6 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar6 =
                0;
            dataConnectionConnectionDesVar7 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar7 =
                0;
            dataConnectionConnectionDesVar8 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar8 =
                0;
            dataConnectionConnectionDesVar9 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar9 =
                1;
        }
    }
}
