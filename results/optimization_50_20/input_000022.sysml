package 'Architecture Package 2492' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #architecture part def <archId2492> 'Architecture #22' :> GNCDesignSpace {
        action provideSensorData :>> GNCDesignSpace::provideSensorData;
        action sendActuatorSignal :>> GNCDesignSpace::sendActuatorSignal;
        action controlOrientation :>> GNCDesignSpace::controlOrientation;
        connection dataConnection :>> GNCDesignSpace::dataConnection [2] = (dataConnection_1, dataConnection_2);
        connection actuatorSignalConnection :>> GNCDesignSpace::actuatorSignalConnection [4] = (
            actuatorSignalConnection_1, actuatorSignalConnection_2, actuatorSignalConnection_3,
            actuatorSignalConnection_4
        );
        attribute mass :>> GNCDesignSpace::mass;
        attribute failureRate :>> GNCDesignSpace::failureRate;
        attribute logFailureRate :>> GNCDesignSpace::logFailureRate;
        #subsystem part sensors :>> GNCDesignSpace::sensors {
            part sensorA :>> GNCDesignSpace::sensors::sensorA {
                perform provideSensorData [1] :>> GNCDesignSpace::sensors::sensorA::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorA::mass = 3 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorA::failureRate = 0.00015;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [2]; }
            }
            part sensorB :>> GNCDesignSpace::sensors::sensorB [0];
            part sensorC :>> GNCDesignSpace::sensors::sensorC [0];
            attribute mass :>> GNCDesignSpace::sensors::mass;
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate;
        }
        part computers :>> GNCDesignSpace::computers [2] = (computers_1, computers_2);
        part actuators :>> GNCDesignSpace::actuators [3] = (actuators_1, actuators_2, actuators_3);
        #subsystem part computers_1 :> computers {
            part computerC :>> GNCDesignSpace::computers::computerC {
                perform sendActuatorSignal [1] :>> GNCDesignSpace::computers::computerC::sendActuatorSignalPerformance;
                attribute mass :>> GNCDesignSpace::computers::computerC::mass = 10 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::computers::computerC::failureRate = 2e-05;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [3];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [1]; }
                #needsAction ::> provideSensorData;
            }
            part computerA :>> GNCDesignSpace::computers::computerA [0];
            part computerB :>> GNCDesignSpace::computers::computerB [0];
            attribute mass :>> GNCDesignSpace::computers::mass;
            attribute failureRate :>> GNCDesignSpace::computers::failureRate;
        }
        #subsystem part computers_2 :> computers {
            part computerC :>> GNCDesignSpace::computers::computerC {
                perform sendActuatorSignal [1] :>> GNCDesignSpace::computers::computerC::sendActuatorSignalPerformance;
                attribute mass :>> GNCDesignSpace::computers::computerC::mass = 10 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::computers::computerC::failureRate = 2e-05;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [1]; }
                #needsAction ::> provideSensorData;
            }
            part computerA :>> GNCDesignSpace::computers::computerA [0];
            part computerB :>> GNCDesignSpace::computers::computerB [0];
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
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [2];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA [0];
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB [0];
            attribute mass :>> GNCDesignSpace::actuators::mass;
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate;
        }
        connection dataConnection_1 :> dataConnection
            connect sensors.sensorA.dataOutPort to computers_2.computerC.dataInPort;
        connection dataConnection_2 :> dataConnection
            connect sensors.sensorA.dataOutPort to computers_1.computerC.dataInPort;
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers_1.computerC.actuationSignalOutPort
            to actuators_3.actuatorC.actuationSignalInPort;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers_1.computerC.actuationSignalOutPort
            to actuators_1.actuatorC.actuationSignalInPort;
        connection actuatorSignalConnection_3 :> actuatorSignalConnection
            connect computers_1.computerC.actuationSignalOutPort
            to actuators_2.actuatorC.actuationSignalInPort;
        connection actuatorSignalConnection_4 :> actuatorSignalConnection
            connect computers_2.computerC.actuationSignalOutPort
            to actuators_3.actuatorC.actuationSignalInPort;
        architecturalChoices :>> GNCDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice :>> GNCDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 3;
            computersInstantiationChoice :>> GNCDesignSpace::architecturalChoices::computersInstantiationChoice = 2;
            sensorsInstantiationChoice :>> GNCDesignSpace::architecturalChoices::sensorsInstantiationChoice = 1;
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
                ::> computers_1.computerC;
            sendActuatorSignalFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys2
                ::> computers_2.computerC;
            sendActuatorSignalFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys3 [0];
            provideSensorDataFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1 ::> sensors.sensorA;
            provideSensorDataFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2 [0];
            provideSensorDataFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3 [0];
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
            computersInstantiationDesVar :>> GNCDesignSpace::formalDesignProblem::computersInstantiationDesVar = 2;
            sendActuatorSignalFulfillmentChoiceSys1DesVar
                :>> GNCDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys1DesVar = 2;
            sendActuatorSignalFulfillmentChoiceSys2DesVar
                :>> GNCDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys2DesVar = 2;
            sendActuatorSignalFulfillmentChoiceSys3DesVar
                :>> GNCDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys3DesVar = null;
            sensorsInstantiationDesVar :>> GNCDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 1;
            provideSensorDataFulfillmentChoiceSys1DesVar
                :>> GNCDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys1DesVar = 0;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>> GNCDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys2DesVar = null;
            provideSensorDataFulfillmentChoiceSys3DesVar
                :>> GNCDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys3DesVar = null;
            actuatorSignalConnectionConnectionDesVar
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar = 1;
            actuatorSignalConnectionConnectionDesVar2
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar2 = 1;
            actuatorSignalConnectionConnectionDesVar3
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar3 = 1;
            actuatorSignalConnectionConnectionDesVar4
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar4 = 0;
            actuatorSignalConnectionConnectionDesVar5
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar5 = 0;
            actuatorSignalConnectionConnectionDesVar6
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar6 = 1;
            actuatorSignalConnectionConnectionDesVar7
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar7 = null;
            actuatorSignalConnectionConnectionDesVar8
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar8 = null;
            actuatorSignalConnectionConnectionDesVar9
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar9 = null;
            dataConnectionConnectionDesVar :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar = 1;
            dataConnectionConnectionDesVar2 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar2 =
                1;
            dataConnectionConnectionDesVar3 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar3 =
                null;
            dataConnectionConnectionDesVar4 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar4 =
                null;
            dataConnectionConnectionDesVar5 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar5 =
                null;
            dataConnectionConnectionDesVar6 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar6 =
                null;
            dataConnectionConnectionDesVar7 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar7 =
                null;
            dataConnectionConnectionDesVar8 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar8 =
                null;
            dataConnectionConnectionDesVar9 :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar9 =
                null;
        }
    }
}
