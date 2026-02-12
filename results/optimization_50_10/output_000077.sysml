package 'Architecture Package 22353' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #ArchitectureInstanceDefs::architecture part <archId22353> 'Architecture #77'
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
        attribute mass :>> gncDesignSpace::mass = 26.5 [SI::kilogram];
        attribute failureRate :>> gncDesignSpace::failureRate = 0.00019999000039992002;
        attribute logFailureRate :>> gncDesignSpace::logFailureRate = -3.6989917187345416;
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part sensors
            :>> gncDesignSpace::sensors {
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
        part computers :>> gncDesignSpace::computers [3] = (computers_1, computers_2, computers_3,);
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part actuators
            :>> gncDesignSpace::actuators {
            part actuatorC :>> gncDesignSpace::actuators::actuatorC {
                perform
                    controlOrientation [1]
                    :>> gncDesignSpace::actuators::actuatorC::controlOrientationPerformance;
                attribute mass :>> gncDesignSpace::actuators::actuatorC::mass = 9.5 [SI::kg];
                attribute failureRate :>> gncDesignSpace::actuators::actuatorC::failureRate =
                    0.0001;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [3];
                }
                #ArchitectureChoiceModelingDefs::needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> gncDesignSpace::actuators::actuatorA [0];
            part actuatorB :>> gncDesignSpace::actuators::actuatorB [0];
            attribute mass :>> gncDesignSpace::actuators::mass = 9.5 [SI::kilogram];
            attribute failureRate :>> gncDesignSpace::actuators::failureRate = 0.0001;
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
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [1]; }
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
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [1]; }
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
        connection dataConnection_1 :> dataConnection
            connect sensors.sensorB.dataOutPort.data to computers_2.computerA.dataInPort.data;
        connection dataConnection_2 :> dataConnection
            connect sensors.sensorB.dataOutPort.data to computers_1.computerA.dataInPort.data;
        connection dataConnection_3 :> dataConnection
            connect sensors.sensorB.dataOutPort.data to computers_3.computerB.dataInPort.data;
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers_1.computerA.actuationSignalOutPort.actuationSignal
            to actuators.actuatorC.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers_2.computerA.actuationSignalOutPort.actuationSignal
            to actuators.actuatorC.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_3 :> actuatorSignalConnection
            connect computers_3.computerB.actuationSignalOutPort.actuationSignal
            to actuators.actuatorC.actuationSignalInPort.actuationSignal;
        architecturalChoices :>> gncDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice
                :>> gncDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 1;
            computersInstantiationChoice
                :>> gncDesignSpace::architecturalChoices::computersInstantiationChoice = 3;
            sensorsInstantiationChoice
                :>> gncDesignSpace::architecturalChoices::sensorsInstantiationChoice = 1;
            controlOrientationFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators.actuatorC;
            controlOrientationFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2
                [0];
            controlOrientationFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys3
                [0];
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
                ::> sensors.sensorB;
            provideSensorDataFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2
                [0];
            provideSensorDataFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3
                [0];
            actuatorSignalConnectionConnectionChoice
                :>> gncDesignSpace::architecturalChoices::actuatorSignalConnectionConnectionChoice
                ::> actuatorSignalConnection_1;
            dataConnectionConnectionChoice
                :>> gncDesignSpace::architecturalChoices::dataConnectionConnectionChoice
                ::> dataConnection_1;
        }
        formalDesignProblem :>> gncDesignSpace::formalDesignProblem {
            actuatorsInstantiationDesVar
                :>> gncDesignSpace::formalDesignProblem::actuatorsInstantiationDesVar = 1;
            controlOrientationFulfillmentChoiceSys1DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys1DesVar = 2;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys2DesVar = null;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys3DesVar = null;
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
                :>> gncDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 1;
            provideSensorDataFulfillmentChoiceSys1DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys1DesVar = 1;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys2DesVar = null;
            provideSensorDataFulfillmentChoiceSys3DesVar
                :>>
                    gncDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys3DesVar = null;
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
