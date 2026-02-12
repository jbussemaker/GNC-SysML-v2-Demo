package 'Architecture Package 58958' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #ArchitectureInstanceDefs::architecture part <archId58958> 'Architecture #159'
        :> gncDesignSpace {
        action provideSensorData :>> gncDesignSpace::provideSensorData;
        action sendActuatorSignal :>> gncDesignSpace::sendActuatorSignal;
        action controlOrientation :>> gncDesignSpace::controlOrientation;
        connection dataConnection :>> gncDesignSpace::dataConnection [5] = (
            dataConnection_1, dataConnection_2, dataConnection_3, dataConnection_4, dataConnection_5,
        );
        connection actuatorSignalConnection :>> gncDesignSpace::actuatorSignalConnection [4] = (
            actuatorSignalConnection_1, actuatorSignalConnection_2, actuatorSignalConnection_3,
            actuatorSignalConnection_4,
        );
        attribute mass :>> gncDesignSpace::mass = 45.5 [SI::kilogram];
        attribute failureRate :>> gncDesignSpace::failureRate = 2.7195559938052398e-11;
        attribute logFailureRate :>> gncDesignSpace::logFailureRate = -10.565501994929232;
        part sensors :>> gncDesignSpace::sensors [3] = (sensors_1, sensors_2, sensors_3,);
        part computers :>> gncDesignSpace::computers [3] = (computers_1, computers_2, computers_3,);
        part actuators :>> gncDesignSpace::actuators [3] = (actuators_1, actuators_2, actuators_3,);
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part sensors_1
            :> sensors {
            part sensorB :>> gncDesignSpace::sensors::sensorB {
                perform
                    provideSensorData [1]
                    :>> gncDesignSpace::sensors::sensorB::provideSensorDataPerformance;
                attribute mass :>> gncDesignSpace::sensors::sensorB::mass = 6 [SI::kg];
                attribute failureRate :>> gncDesignSpace::sensors::sensorB::failureRate = 0.0001;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorA :>> gncDesignSpace::sensors::sensorA [0];
            part sensorC :>> gncDesignSpace::sensors::sensorC [0];
            attribute mass :>> gncDesignSpace::sensors::mass = 6 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::sensors::failureRate = 0.0001;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part sensors_2
            :> sensors {
            part sensorB :>> gncDesignSpace::sensors::sensorB {
                perform
                    provideSensorData [1]
                    :>> gncDesignSpace::sensors::sensorB::provideSensorDataPerformance;
                attribute mass :>> gncDesignSpace::sensors::sensorB::mass = 6 [SI::kg];
                attribute failureRate :>> gncDesignSpace::sensors::sensorB::failureRate = 0.0001;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [3]; }
            }
            part sensorA :>> gncDesignSpace::sensors::sensorA [0];
            part sensorC :>> gncDesignSpace::sensors::sensorC [0];
            attribute mass :>> gncDesignSpace::sensors::mass = 6 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::sensors::failureRate = 0.0001;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part sensors_3
            :> sensors {
            part sensorB :>> gncDesignSpace::sensors::sensorB {
                perform
                    provideSensorData [1]
                    :>> gncDesignSpace::sensors::sensorB::provideSensorDataPerformance;
                attribute mass :>> gncDesignSpace::sensors::sensorB::mass = 6 [SI::kg];
                attribute failureRate :>> gncDesignSpace::sensors::sensorB::failureRate = 0.0001;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorA :>> gncDesignSpace::sensors::sensorA [0];
            part sensorC :>> gncDesignSpace::sensors::sensorC [0];
            attribute mass :>> gncDesignSpace::sensors::mass = 6 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::sensors::failureRate = 0.0001;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part computers_1
            :> computers {
            part computerA :>> gncDesignSpace::computers::computerA {
                perform
                    sendActuatorSignal [1]
                    :>> gncDesignSpace::computers::computerA::sendActuatorSignalPerformance;
                attribute mass :>> gncDesignSpace::computers::computerA::mass = 3 [SI::kg];
                attribute failureRate :>> gncDesignSpace::computers::computerA::failureRate =
                    0.0001;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [2];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [2]; }
                #ArchitectureChoiceModelingDefs::needsAction ::> provideSensorData;
            }
            part computerB :>> gncDesignSpace::computers::computerB [0];
            part computerC :>> gncDesignSpace::computers::computerC [0];
            attribute mass :>> gncDesignSpace::computers::mass = 3 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::computers::failureRate = 0.0001;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part computers_2
            :> computers {
            part computerA :>> gncDesignSpace::computers::computerA {
                perform
                    sendActuatorSignal [1]
                    :>> gncDesignSpace::computers::computerA::sendActuatorSignalPerformance;
                attribute mass :>> gncDesignSpace::computers::computerA::mass = 3 [SI::kg];
                attribute failureRate :>> gncDesignSpace::computers::computerA::failureRate =
                    0.0001;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [2]; }
                #ArchitectureChoiceModelingDefs::needsAction ::> provideSensorData;
            }
            part computerB :>> gncDesignSpace::computers::computerB [0];
            part computerC :>> gncDesignSpace::computers::computerC [0];
            attribute mass :>> gncDesignSpace::computers::mass = 3 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::computers::failureRate = 0.0001;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part computers_3
            :> computers {
            part computerB :>> gncDesignSpace::computers::computerB {
                perform
                    sendActuatorSignal [1]
                    :>> gncDesignSpace::computers::computerB::sendActuatorSignalPerformance;
                attribute mass :>> gncDesignSpace::computers::computerB::mass = 5 [SI::kg];
                attribute failureRate :>> gncDesignSpace::computers::computerB::failureRate = 4e-05;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [1]; }
                #ArchitectureChoiceModelingDefs::needsAction ::> provideSensorData;
            }
            part computerA :>> gncDesignSpace::computers::computerA [0];
            part computerC :>> gncDesignSpace::computers::computerC [0];
            attribute mass :>> gncDesignSpace::computers::mass = 5 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::computers::failureRate = 4e-05;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part actuators_1
            :> actuators {
            part actuatorB :>> gncDesignSpace::actuators::actuatorB {
                perform
                    controlOrientation [1]
                    :>> gncDesignSpace::actuators::actuatorB::controlOrientationPerformance;
                attribute mass :>> gncDesignSpace::actuators::actuatorB::mass = 5.5 [SI::kg];
                attribute failureRate :>> gncDesignSpace::actuators::actuatorB::failureRate =
                    0.0002;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #ArchitectureChoiceModelingDefs::needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> gncDesignSpace::actuators::actuatorA [0];
            part actuatorC :>> gncDesignSpace::actuators::actuatorC [0];
            attribute mass :>> gncDesignSpace::actuators::mass = 5.5 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::actuators::failureRate = 0.0002;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part actuators_2
            :> actuators {
            part actuatorB :>> gncDesignSpace::actuators::actuatorB {
                perform
                    controlOrientation [1]
                    :>> gncDesignSpace::actuators::actuatorB::controlOrientationPerformance;
                attribute mass :>> gncDesignSpace::actuators::actuatorB::mass = 5.5 [SI::kg];
                attribute failureRate :>> gncDesignSpace::actuators::actuatorB::failureRate =
                    0.0002;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #ArchitectureChoiceModelingDefs::needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> gncDesignSpace::actuators::actuatorA [0];
            part actuatorC :>> gncDesignSpace::actuators::actuatorC [0];
            attribute mass :>> gncDesignSpace::actuators::mass = 5.5 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::actuators::failureRate = 0.0002;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part actuators_3
            :> actuators {
            part actuatorB :>> gncDesignSpace::actuators::actuatorB {
                perform
                    controlOrientation [1]
                    :>> gncDesignSpace::actuators::actuatorB::controlOrientationPerformance;
                attribute mass :>> gncDesignSpace::actuators::actuatorB::mass = 5.5 [SI::kg];
                attribute failureRate :>> gncDesignSpace::actuators::actuatorB::failureRate =
                    0.0002;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [2];
                }
                #ArchitectureChoiceModelingDefs::needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> gncDesignSpace::actuators::actuatorA [0];
            part actuatorC :>> gncDesignSpace::actuators::actuatorC [0];
            attribute mass :>> gncDesignSpace::actuators::mass = 5.5 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::actuators::failureRate = 0.0002;
        }
        connection dataConnection_1 :> dataConnection
            connect sensors_1.sensorB.dataOutPort.data to computers_2.computerA.dataInPort.data;
        connection dataConnection_2 :> dataConnection
            connect sensors_2.sensorB.dataOutPort.data to computers_1.computerA.dataInPort.data;
        connection dataConnection_3 :> dataConnection
            connect sensors_2.sensorB.dataOutPort.data to computers_2.computerA.dataInPort.data;
        connection dataConnection_4 :> dataConnection
            connect sensors_2.sensorB.dataOutPort.data to computers_3.computerB.dataInPort.data;
        connection dataConnection_5 :> dataConnection
            connect sensors_3.sensorB.dataOutPort.data to computers_1.computerA.dataInPort.data;
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers_1.computerA.actuationSignalOutPort.actuationSignal
            to actuators_3.actuatorB.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers_1.computerA.actuationSignalOutPort.actuationSignal
            to actuators_1.actuatorB.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_3 :> actuatorSignalConnection
            connect computers_2.computerA.actuationSignalOutPort.actuationSignal
            to actuators_2.actuatorB.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_4 :> actuatorSignalConnection
            connect computers_3.computerB.actuationSignalOutPort.actuationSignal
            to actuators_3.actuatorB.actuationSignalInPort.actuationSignal;
        architecturalChoices :>> gncDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice
                :>> gncDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 3;
            computersInstantiationChoice
                :>> gncDesignSpace::architecturalChoices::computersInstantiationChoice = 3;
            sensorsInstantiationChoice
                :>> gncDesignSpace::architecturalChoices::sensorsInstantiationChoice = 3;
            controlOrientationFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators_1.actuatorB;
            controlOrientationFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2
                ::> actuators_2.actuatorB;
            controlOrientationFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys3
                ::> actuators_3.actuatorB;
            sendActuatorSignalFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys1
                ::> computers_1.computerA;
            sendActuatorSignalFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys2
                ::> computers_2.computerA;
            sendActuatorSignalFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys3
                ::> computers_3.computerB;
            provideSensorDataFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1
                ::> sensors_1.sensorB;
            provideSensorDataFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2
                ::> sensors_2.sensorB;
            provideSensorDataFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3
                ::> sensors_3.sensorB;
            actuatorSignalConnectionConnectionChoice
                :>> gncDesignSpace::architecturalChoices::actuatorSignalConnectionConnectionChoice
                ::> actuatorSignalConnection_1;
            dataConnectionConnectionChoice
                :>> gncDesignSpace::architecturalChoices::dataConnectionConnectionChoice
                ::> dataConnection_1;
        }
        formalDesignProblem :>> gncDesignSpace::formalDesignProblem {
            actuatorsInstantiationDesVar
                :>> gncDesignSpace::formalDesignProblem::actuatorsInstantiationDesVar = 3;
            controlOrientationFulfillmentChoiceSys1DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys1DesVar = 1;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys2DesVar = 1;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys3DesVar = 1;
            computersInstantiationDesVar
                :>> gncDesignSpace::formalDesignProblem::computersInstantiationDesVar = 3;
            sendActuatorSignalFulfillmentChoiceSys1DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys1DesVar = 0;
            sendActuatorSignalFulfillmentChoiceSys2DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys2DesVar = 0;
            sendActuatorSignalFulfillmentChoiceSys3DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys3DesVar = 1;
            sensorsInstantiationDesVar
                :>> gncDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 3;
            provideSensorDataFulfillmentChoiceSys1DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys1DesVar = 1;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys2DesVar = 1;
            provideSensorDataFulfillmentChoiceSys3DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys3DesVar = 1;
            actuatorSignalConnectionConnectionDesVar
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar =
                1;
            actuatorSignalConnectionConnectionDesVar2
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar2 =
                0;
            actuatorSignalConnectionConnectionDesVar3
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar3 =
                1;
            actuatorSignalConnectionConnectionDesVar4
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar4 =
                0;
            actuatorSignalConnectionConnectionDesVar5
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar5 =
                1;
            actuatorSignalConnectionConnectionDesVar6
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar6 =
                0;
            actuatorSignalConnectionConnectionDesVar7
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar7 =
                0;
            actuatorSignalConnectionConnectionDesVar8
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar8 =
                0;
            actuatorSignalConnectionConnectionDesVar9
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar9 =
                1;
            dataConnectionConnectionDesVar
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar = 0;
            dataConnectionConnectionDesVar2
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar2 = 1;
            dataConnectionConnectionDesVar3
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar3 = 0;
            dataConnectionConnectionDesVar4
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar4 = 1;
            dataConnectionConnectionDesVar5
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar5 = 1;
            dataConnectionConnectionDesVar6
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar6 = 1;
            dataConnectionConnectionDesVar7
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar7 = 1;
            dataConnectionConnectionDesVar8
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar8 = 0;
            dataConnectionConnectionDesVar9
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar9 = 0;
        }
    }
}
