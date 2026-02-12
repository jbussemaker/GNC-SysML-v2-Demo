package 'Architecture Package 1931' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #ArchitectureInstanceDefs::architecture part <archId1931> 'Architecture #17' :> gncDesignSpace {
        action provideSensorData :>> gncDesignSpace::provideSensorData;
        action sendActuatorSignal :>> gncDesignSpace::sendActuatorSignal;
        action controlOrientation :>> gncDesignSpace::controlOrientation;
        connection dataConnection :>> gncDesignSpace::dataConnection [2] = (dataConnection_1, dataConnection_2);
        connection actuatorSignalConnection :>> gncDesignSpace::actuatorSignalConnection [2] = (
            actuatorSignalConnection_1, actuatorSignalConnection_2
        );
        attribute mass :>> gncDesignSpace::mass;
        attribute failureRate :>> gncDesignSpace::failureRate;
        attribute logFailureRate :>> gncDesignSpace::logFailureRate;
        part sensors :>> gncDesignSpace::sensors [2] = (sensors_1, sensors_2);
        part computers :>> gncDesignSpace::computers [2] = (computers_1, computers_2);
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part actuators
            :>> gncDesignSpace::actuators {
            part actuatorA :>> gncDesignSpace::actuators::actuatorA {
                perform controlOrientation [1] :>> gncDesignSpace::actuators::actuatorA::controlOrientationPerformance;
                attribute mass :>> gncDesignSpace::actuators::actuatorA::mass = 3.5 [SI::kg];
                attribute failureRate :>> gncDesignSpace::actuators::actuatorA::failureRate = 8e-05;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [2];
                }
                #ArchitectureChoiceModelingDefs::needsAction ::> sendActuatorSignal;
            }
            part actuatorB :>> gncDesignSpace::actuators::actuatorB [0];
            part actuatorC :>> gncDesignSpace::actuators::actuatorC [0];
            attribute mass :>> gncDesignSpace::actuators::mass;
            attribute failureRate :>> gncDesignSpace::actuators::failureRate;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part sensors_1 :> sensors {
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
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part computers_1 :> computers {
            part computerA :>> gncDesignSpace::computers::computerA {
                perform sendActuatorSignal [1] :>> gncDesignSpace::computers::computerA::sendActuatorSignalPerformance;
                attribute mass :>> gncDesignSpace::computers::computerA::mass = 3 [SI::kg];
                attribute failureRate :>> gncDesignSpace::computers::computerA::failureRate = 0.0001;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [1]; }
                #ArchitectureChoiceModelingDefs::needsAction ::> provideSensorData;
            }
            part computerB :>> gncDesignSpace::computers::computerB [0];
            part computerC :>> gncDesignSpace::computers::computerC [0];
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
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [1]; }
                #ArchitectureChoiceModelingDefs::needsAction ::> provideSensorData;
            }
            part computerA :>> gncDesignSpace::computers::computerA [0];
            part computerB :>> gncDesignSpace::computers::computerB [0];
            attribute mass :>> gncDesignSpace::computers::mass;
            attribute failureRate :>> gncDesignSpace::computers::failureRate;
        }
        connection dataConnection_1 :> dataConnection
            connect sensors_1.sensorB.dataOutPort.data to computers_2.computerC.dataInPort.data;
        connection dataConnection_2 :> dataConnection
            connect sensors_2.sensorB.dataOutPort.data to computers_1.computerA.dataInPort.data;
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers_1.computerA.actuationSignalOutPort.actuationSignal
            to actuators.actuatorA.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers_2.computerC.actuationSignalOutPort.actuationSignal
            to actuators.actuatorA.actuationSignalInPort.actuationSignal;
        architecturalChoices :>> gncDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice :>> gncDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 1;
            computersInstantiationChoice :>> gncDesignSpace::architecturalChoices::computersInstantiationChoice = 2;
            sensorsInstantiationChoice :>> gncDesignSpace::architecturalChoices::sensorsInstantiationChoice = 2;
            controlOrientationFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators.actuatorA;
            controlOrientationFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2 [0];
            controlOrientationFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys3 [0];
            sendActuatorSignalFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys1
                ::> computers_1.computerA;
            sendActuatorSignalFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys2
                ::> computers_2.computerC;
            sendActuatorSignalFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys3 [0];
            provideSensorDataFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1 ::> sensors_1.sensorB;
            provideSensorDataFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2 ::> sensors_2.sensorB;
            provideSensorDataFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3 [0];
            actuatorSignalConnectionConnectionChoice
                :>> gncDesignSpace::architecturalChoices::actuatorSignalConnectionConnectionChoice
                ::> actuatorSignalConnection_1;
            dataConnectionConnectionChoice
                :>> gncDesignSpace::architecturalChoices::dataConnectionConnectionChoice ::> dataConnection_1;
        }
        formalDesignProblem :>> gncDesignSpace::formalDesignProblem {
            actuatorsInstantiationDesVar :>> gncDesignSpace::formalDesignProblem::actuatorsInstantiationDesVar = 1;
            controlOrientationFulfillmentChoiceSys1DesVar
                :>> gncDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys1DesVar = 0;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>> gncDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys2DesVar = null;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>> gncDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys3DesVar = null;
            computersInstantiationDesVar :>> gncDesignSpace::formalDesignProblem::computersInstantiationDesVar = 2;
            sendActuatorSignalFulfillmentChoiceSys1DesVar
                :>> gncDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys1DesVar = 0;
            sendActuatorSignalFulfillmentChoiceSys2DesVar
                :>> gncDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys2DesVar = 2;
            sendActuatorSignalFulfillmentChoiceSys3DesVar
                :>> gncDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys3DesVar = null;
            sensorsInstantiationDesVar :>> gncDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 2;
            provideSensorDataFulfillmentChoiceSys1DesVar
                :>> gncDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys1DesVar = 1;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>> gncDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys2DesVar = 1;
            provideSensorDataFulfillmentChoiceSys3DesVar
                :>> gncDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys3DesVar = null;
            actuatorSignalConnectionConnectionDesVar
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar = 1;
            actuatorSignalConnectionConnectionDesVar2
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar2 = 1;
            actuatorSignalConnectionConnectionDesVar3
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar3 = null;
            actuatorSignalConnectionConnectionDesVar4
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar4 = null;
            actuatorSignalConnectionConnectionDesVar5
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar5 = null;
            actuatorSignalConnectionConnectionDesVar6
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar6 = null;
            actuatorSignalConnectionConnectionDesVar7
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar7 = null;
            actuatorSignalConnectionConnectionDesVar8
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar8 = null;
            actuatorSignalConnectionConnectionDesVar9
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar9 = null;
            dataConnectionConnectionDesVar :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar = 0;
            dataConnectionConnectionDesVar2 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar2 =
                1;
            dataConnectionConnectionDesVar3 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar3 =
                1;
            dataConnectionConnectionDesVar4 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar4 =
                0;
            dataConnectionConnectionDesVar5 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar5 =
                null;
            dataConnectionConnectionDesVar6 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar6 =
                null;
            dataConnectionConnectionDesVar7 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar7 =
                null;
            dataConnectionConnectionDesVar8 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar8 =
                null;
            dataConnectionConnectionDesVar9 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar9 =
                null;
        }
    }
}
