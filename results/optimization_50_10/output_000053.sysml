package 'Architecture Package 20005' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #ArchitectureInstanceDefs::architecture part <archId20005> 'Architecture #53'
        :> gncDesignSpace {
        action provideSensorData :>> gncDesignSpace::provideSensorData;
        action sendActuatorSignal :>> gncDesignSpace::sendActuatorSignal;
        action controlOrientation :>> gncDesignSpace::controlOrientation;
        connection dataConnection :>> gncDesignSpace::dataConnection [3] = (
            dataConnection_1, dataConnection_2, dataConnection_3,
        );
        connection actuatorSignalConnection :>> gncDesignSpace::actuatorSignalConnection [3] = (
            actuatorSignalConnection_1, actuatorSignalConnection_2, actuatorSignalConnection_3,
        );
        attribute mass :>> gncDesignSpace::mass = 34.5 [SI::kilogram];
        attribute failureRate :>> gncDesignSpace::failureRate = 4.0000004324827006e-05;
        attribute logFailureRate :>> gncDesignSpace::logFailureRate = -4.397939961715828;
        part sensors :>> gncDesignSpace::sensors [3] = (sensors_1, sensors_2, sensors_3,);
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part computers
            :>> gncDesignSpace::computers {
            part computerB :>> gncDesignSpace::computers::computerB {
                perform
                    sendActuatorSignal [1]
                    :>> gncDesignSpace::computers::computerB::sendActuatorSignalPerformance;
                attribute mass :>> gncDesignSpace::computers::computerB::mass = 5 [SI::kg];
                attribute failureRate :>> gncDesignSpace::computers::computerB::failureRate = 4e-05;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [3];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [3]; }
                #ArchitectureChoiceModelingDefs::needsAction ::> provideSensorData;
            }
            part computerA :>> gncDesignSpace::computers::computerA [0];
            part computerC :>> gncDesignSpace::computers::computerC [0];
            attribute mass :>> gncDesignSpace::computers::mass = 5 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::computers::failureRate = 4e-05;
        }
        part actuators :>> gncDesignSpace::actuators [3] = (actuators_1, actuators_2, actuators_3,);
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part sensors_1
            :> sensors {
            part sensorA :>> gncDesignSpace::sensors::sensorA {
                perform
                    provideSensorData [1]
                    :>> gncDesignSpace::sensors::sensorA::provideSensorDataPerformance;
                attribute mass :>> gncDesignSpace::sensors::sensorA::mass = 3 [SI::kg];
                attribute failureRate :>> gncDesignSpace::sensors::sensorA::failureRate = 0.00015;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorB :>> gncDesignSpace::sensors::sensorB [0];
            part sensorC :>> gncDesignSpace::sensors::sensorC [0];
            attribute mass :>> gncDesignSpace::sensors::mass = 3 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::sensors::failureRate = 0.00015;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part sensors_2
            :> sensors {
            part sensorA :>> gncDesignSpace::sensors::sensorA {
                perform
                    provideSensorData [1]
                    :>> gncDesignSpace::sensors::sensorA::provideSensorDataPerformance;
                attribute mass :>> gncDesignSpace::sensors::sensorA::mass = 3 [SI::kg];
                attribute failureRate :>> gncDesignSpace::sensors::sensorA::failureRate = 0.00015;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorB :>> gncDesignSpace::sensors::sensorB [0];
            part sensorC :>> gncDesignSpace::sensors::sensorC [0];
            attribute mass :>> gncDesignSpace::sensors::mass = 3 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::sensors::failureRate = 0.00015;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part sensors_3
            :> sensors {
            part sensorC :>> gncDesignSpace::sensors::sensorC {
                perform
                    provideSensorData [1]
                    :>> gncDesignSpace::sensors::sensorC::provideSensorDataPerformance;
                attribute mass :>> gncDesignSpace::sensors::sensorC::mass = 9 [SI::kg];
                attribute failureRate :>> gncDesignSpace::sensors::sensorC::failureRate = 5e-05;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorA :>> gncDesignSpace::sensors::sensorA [0];
            part sensorB :>> gncDesignSpace::sensors::sensorB [0];
            attribute mass :>> gncDesignSpace::sensors::mass = 9 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::sensors::failureRate = 5e-05;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part actuators_1
            :> actuators {
            part actuatorA :>> gncDesignSpace::actuators::actuatorA {
                perform
                    controlOrientation [1]
                    :>> gncDesignSpace::actuators::actuatorA::controlOrientationPerformance;
                attribute mass :>> gncDesignSpace::actuators::actuatorA::mass = 3.5 [SI::kg];
                attribute failureRate :>> gncDesignSpace::actuators::actuatorA::failureRate = 8e-05;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #ArchitectureChoiceModelingDefs::needsAction ::> sendActuatorSignal;
            }
            part actuatorB :>> gncDesignSpace::actuators::actuatorB [0];
            part actuatorC :>> gncDesignSpace::actuators::actuatorC [0];
            attribute mass :>> gncDesignSpace::actuators::mass = 3.5 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::actuators::failureRate = 8e-05;
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
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #ArchitectureChoiceModelingDefs::needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> gncDesignSpace::actuators::actuatorA [0];
            part actuatorC :>> gncDesignSpace::actuators::actuatorC [0];
            attribute mass :>> gncDesignSpace::actuators::mass = 5.5 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::actuators::failureRate = 0.0002;
        }
        connection dataConnection_1 :> dataConnection
            connect sensors_1.sensorA.dataOutPort.data to computers.computerB.dataInPort.data;
        connection dataConnection_2 :> dataConnection
            connect sensors_2.sensorA.dataOutPort.data to computers.computerB.dataInPort.data;
        connection dataConnection_3 :> dataConnection
            connect sensors_3.sensorC.dataOutPort.data to computers.computerB.dataInPort.data;
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers.computerB.actuationSignalOutPort.actuationSignal
            to actuators_1.actuatorA.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers.computerB.actuationSignalOutPort.actuationSignal
            to actuators_2.actuatorB.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_3 :> actuatorSignalConnection
            connect computers.computerB.actuationSignalOutPort.actuationSignal
            to actuators_3.actuatorB.actuationSignalInPort.actuationSignal;
        architecturalChoices :>> gncDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice
                :>> gncDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 3;
            computersInstantiationChoice
                :>> gncDesignSpace::architecturalChoices::computersInstantiationChoice = 1;
            sensorsInstantiationChoice
                :>> gncDesignSpace::architecturalChoices::sensorsInstantiationChoice = 3;
            controlOrientationFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators_1.actuatorA;
            controlOrientationFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2
                ::> actuators_2.actuatorB;
            controlOrientationFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys3
                ::> actuators_3.actuatorB;
            sendActuatorSignalFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys1
                ::> computers.computerB;
            sendActuatorSignalFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys2
                [0];
            sendActuatorSignalFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys3
                [0];
            provideSensorDataFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1
                ::> sensors_1.sensorA;
            provideSensorDataFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2
                ::> sensors_2.sensorA;
            provideSensorDataFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3
                ::> sensors_3.sensorC;
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
                        ::controlOrientationFulfillmentChoiceSys1DesVar = 0;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys2DesVar = 1;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys3DesVar = 1;
            computersInstantiationDesVar
                :>> gncDesignSpace::formalDesignProblem::computersInstantiationDesVar = 1;
            sendActuatorSignalFulfillmentChoiceSys1DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys1DesVar = 1;
            sendActuatorSignalFulfillmentChoiceSys2DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys2DesVar = null;
            sendActuatorSignalFulfillmentChoiceSys3DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys3DesVar = null;
            sensorsInstantiationDesVar
                :>> gncDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 3;
            provideSensorDataFulfillmentChoiceSys1DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys1DesVar = 0;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys2DesVar = 0;
            provideSensorDataFulfillmentChoiceSys3DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys3DesVar = 2;
            actuatorSignalConnectionConnectionDesVar
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar =
                1;
            actuatorSignalConnectionConnectionDesVar2
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar2 =
                1;
            actuatorSignalConnectionConnectionDesVar3
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar3 =
                1;
            actuatorSignalConnectionConnectionDesVar4
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar4 =
                null;
            actuatorSignalConnectionConnectionDesVar5
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar5 =
                null;
            actuatorSignalConnectionConnectionDesVar6
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar6 =
                null;
            actuatorSignalConnectionConnectionDesVar7
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar7 =
                null;
            actuatorSignalConnectionConnectionDesVar8
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar8 =
                null;
            actuatorSignalConnectionConnectionDesVar9
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar9 =
                null;
            dataConnectionConnectionDesVar
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar = 1;
            dataConnectionConnectionDesVar2
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar2 = 1;
            dataConnectionConnectionDesVar3
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar3 = 1;
            dataConnectionConnectionDesVar4
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar4 = null;
            dataConnectionConnectionDesVar5
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar5 = null;
            dataConnectionConnectionDesVar6
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar6 = null;
            dataConnectionConnectionDesVar7
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar7 = null;
            dataConnectionConnectionDesVar8
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar8 = null;
            dataConnectionConnectionDesVar9
                :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar9 = null;
        }
    }
}
