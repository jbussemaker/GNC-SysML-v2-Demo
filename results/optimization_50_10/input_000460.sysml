package 'Architecture Package 174020' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #ArchitectureInstanceDefs::architecture part <archId174020> 'Architecture #460' :> gncDesignSpace {
        action provideSensorData :>> gncDesignSpace::provideSensorData;
        action sendActuatorSignal :>> gncDesignSpace::sendActuatorSignal;
        action controlOrientation :>> gncDesignSpace::controlOrientation;
        connection dataConnection :>> gncDesignSpace::dataConnection
            connect sensors.sensorC.dataOutPort.data to computers.computerA.dataInPort.data;
        connection actuatorSignalConnection :>> gncDesignSpace::actuatorSignalConnection [3] = (
            actuatorSignalConnection_1, actuatorSignalConnection_2, actuatorSignalConnection_3,
        );
        attribute mass :>> gncDesignSpace::mass;
        attribute failureRate :>> gncDesignSpace::failureRate;
        attribute logFailureRate :>> gncDesignSpace::logFailureRate;
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part sensors :>> gncDesignSpace::sensors {
            part sensorC :>> gncDesignSpace::sensors::sensorC {
                perform provideSensorData [1] :>> gncDesignSpace::sensors::sensorC::provideSensorDataPerformance;
                attribute mass :>> gncDesignSpace::sensors::sensorC::mass = 9 [SI::kg];
                attribute failureRate :>> gncDesignSpace::sensors::sensorC::failureRate = 5e-05;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorA :>> gncDesignSpace::sensors::sensorA [0];
            part sensorB :>> gncDesignSpace::sensors::sensorB [0];
            attribute mass :>> gncDesignSpace::sensors::mass;
            attribute failureRate :>> gncDesignSpace::sensors::failureRate;
        }
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part computers
            :>> gncDesignSpace::computers {
            part computerA :>> gncDesignSpace::computers::computerA {
                perform sendActuatorSignal [1] :>> gncDesignSpace::computers::computerA::sendActuatorSignalPerformance;
                attribute mass :>> gncDesignSpace::computers::computerA::mass = 3 [SI::kg];
                attribute failureRate :>> gncDesignSpace::computers::computerA::failureRate = 0.0001;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [3];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [1]; }
                #ArchitectureChoiceModelingDefs::needsAction ::> provideSensorData;
            }
            part computerB :>> gncDesignSpace::computers::computerB [0];
            part computerC :>> gncDesignSpace::computers::computerC [0];
            attribute mass :>> gncDesignSpace::computers::mass;
            attribute failureRate :>> gncDesignSpace::computers::failureRate;
        }
        part actuators :>> gncDesignSpace::actuators [3] = (actuators_1, actuators_2, actuators_3,);
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part actuators_1 :> actuators {
            part actuatorA :>> gncDesignSpace::actuators::actuatorA {
                perform controlOrientation [1] :>> gncDesignSpace::actuators::actuatorA::controlOrientationPerformance;
                attribute mass :>> gncDesignSpace::actuators::actuatorA::mass = 3.5 [SI::kg];
                attribute failureRate :>> gncDesignSpace::actuators::actuatorA::failureRate = 8e-05;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #ArchitectureChoiceModelingDefs::needsAction ::> sendActuatorSignal;
            }
            part actuatorB :>> gncDesignSpace::actuators::actuatorB [0];
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
        #ArchitectureDesignProblemDefs::ArchitectureDesignSpaceDef::subsystem part actuators_3 :> actuators {
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
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers.computerA.actuationSignalOutPort.actuationSignal
            to actuators_1.actuatorA.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers.computerA.actuationSignalOutPort.actuationSignal
            to actuators_3.actuatorC.actuationSignalInPort.actuationSignal;
        connection actuatorSignalConnection_3 :> actuatorSignalConnection
            connect computers.computerA.actuationSignalOutPort.actuationSignal
            to actuators_2.actuatorC.actuationSignalInPort.actuationSignal;
        architecturalChoices :>> gncDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice :>> gncDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 3;
            computersInstantiationChoice :>> gncDesignSpace::architecturalChoices::computersInstantiationChoice = 1;
            sensorsInstantiationChoice :>> gncDesignSpace::architecturalChoices::sensorsInstantiationChoice = 1;
            controlOrientationFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators_1.actuatorA;
            controlOrientationFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2
                ::> actuators_2.actuatorC;
            controlOrientationFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys3
                ::> actuators_3.actuatorC;
            sendActuatorSignalFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys1
                ::> computers.computerA;
            sendActuatorSignalFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys2 [0];
            sendActuatorSignalFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys3 [0];
            provideSensorDataFulfillmentChoiceSys1
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1 ::> sensors.sensorC;
            provideSensorDataFulfillmentChoiceSys2
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2 [0];
            provideSensorDataFulfillmentChoiceSys3
                :>> gncDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3 [0];
            actuatorSignalConnectionConnectionChoice
                :>> gncDesignSpace::architecturalChoices::actuatorSignalConnectionConnectionChoice
                ::> actuatorSignalConnection_1;
            dataConnectionConnectionChoice
                :>> gncDesignSpace::architecturalChoices::dataConnectionConnectionChoice ::> dataConnection;
        }
        formalDesignProblem :>> gncDesignSpace::formalDesignProblem {
            actuatorsInstantiationDesVar :>> gncDesignSpace::formalDesignProblem::actuatorsInstantiationDesVar = 3;
            controlOrientationFulfillmentChoiceSys1DesVar
                :>> gncDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys1DesVar = 0;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>> gncDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys2DesVar = 2;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>> gncDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys3DesVar = 2;
            computersInstantiationDesVar :>> gncDesignSpace::formalDesignProblem::computersInstantiationDesVar = 1;
            sendActuatorSignalFulfillmentChoiceSys1DesVar
                :>> gncDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys1DesVar = 0;
            sendActuatorSignalFulfillmentChoiceSys2DesVar
                :>> gncDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys2DesVar = null;
            sendActuatorSignalFulfillmentChoiceSys3DesVar
                :>> gncDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys3DesVar = null;
            sensorsInstantiationDesVar :>> gncDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 1;
            provideSensorDataFulfillmentChoiceSys1DesVar
                :>> gncDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys1DesVar = 2;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>> gncDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys2DesVar = null;
            provideSensorDataFulfillmentChoiceSys3DesVar
                :>> gncDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys3DesVar = null;
            actuatorSignalConnectionConnectionDesVar
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar = 1;
            actuatorSignalConnectionConnectionDesVar2
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar2 = 1;
            actuatorSignalConnectionConnectionDesVar3
                :>> gncDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar3 = 1;
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
            dataConnectionConnectionDesVar :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar = 1;
            dataConnectionConnectionDesVar2 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar2 =
                null;
            dataConnectionConnectionDesVar3 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar3 =
                null;
            dataConnectionConnectionDesVar4 :>> gncDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar4 =
                null;
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
