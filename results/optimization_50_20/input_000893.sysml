package 'Architecture Package 342617' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #architecture part def <archId342617> 'Architecture #893' :> GNCDesignSpace {
        action provideSensorData :>> GNCDesignSpace::provideSensorData;
        action sendActuatorSignal :>> GNCDesignSpace::sendActuatorSignal;
        action controlOrientation :>> GNCDesignSpace::controlOrientation;
        connection dataConnection :>> GNCDesignSpace::dataConnection [3] = (
            dataConnection_1, dataConnection_2, dataConnection_3,
        );
        connection actuatorSignalConnection :>> GNCDesignSpace::actuatorSignalConnection
            connect computers.computerC.actuationSignalOutPort
            to actuators.actuatorA.actuationSignalInPort;
        attribute mass :>> GNCDesignSpace::mass;
        attribute failureRate :>> GNCDesignSpace::failureRate;
        attribute logFailureRate :>> GNCDesignSpace::logFailureRate;
        part sensors :>> GNCDesignSpace::sensors [3] = (sensors_1, sensors_2, sensors_3,);
        #subsystem part computers
            :>> GNCDesignSpace::computers {
            part computerC :>> GNCDesignSpace::computers::computerC {
                perform sendActuatorSignal [1] :>> GNCDesignSpace::computers::computerC::sendActuatorSignalPerformance;
                attribute mass :>> GNCDesignSpace::computers::computerC::mass = 10 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::computers::computerC::failureRate = 2e-05;
                port actuationSignalOutPort :>> Computer::actuationSignalOutPort {
                    out actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [3]; }
                #needsAction ::> provideSensorData;
            }
            part computerA :>> GNCDesignSpace::computers::computerA [0];
            part computerB :>> GNCDesignSpace::computers::computerB [0];
            attribute mass :>> GNCDesignSpace::computers::mass;
            attribute failureRate :>> GNCDesignSpace::computers::failureRate;
        }
        #subsystem part actuators
            :>> GNCDesignSpace::actuators {
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA {
                perform controlOrientation [1] :>> GNCDesignSpace::actuators::actuatorA::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorA::mass = 3.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorA::failureRate = 8e-05;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB [0];
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC [0];
            attribute mass :>> GNCDesignSpace::actuators::mass;
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate;
        }
        #subsystem part sensors_1 :> sensors {
            part sensorB :>> GNCDesignSpace::sensors::sensorB {
                perform provideSensorData [1] :>> GNCDesignSpace::sensors::sensorB::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorB::mass = 6 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorB::failureRate = 0.0001;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorC :>> GNCDesignSpace::sensors::sensorC [0];
            attribute mass :>> GNCDesignSpace::sensors::mass;
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate;
        }
        #subsystem part sensors_2 :> sensors {
            part sensorB :>> GNCDesignSpace::sensors::sensorB {
                perform provideSensorData [1] :>> GNCDesignSpace::sensors::sensorB::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorB::mass = 6 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorB::failureRate = 0.0001;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorC :>> GNCDesignSpace::sensors::sensorC [0];
            attribute mass :>> GNCDesignSpace::sensors::mass;
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate;
        }
        #subsystem part sensors_3 :> sensors {
            part sensorC :>> GNCDesignSpace::sensors::sensorC {
                perform provideSensorData [1] :>> GNCDesignSpace::sensors::sensorC::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorC::mass = 9 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorC::failureRate = 5e-05;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorB :>> GNCDesignSpace::sensors::sensorB [0];
            attribute mass :>> GNCDesignSpace::sensors::mass;
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate;
        }
        connection dataConnection_1 :> dataConnection
            connect sensors_1.sensorB.dataOutPort to computers.computerC.dataInPort;
        connection dataConnection_2 :> dataConnection
            connect sensors_2.sensorB.dataOutPort to computers.computerC.dataInPort;
        connection dataConnection_3 :> dataConnection
            connect sensors_3.sensorC.dataOutPort to computers.computerC.dataInPort;
        architecturalChoices :>> GNCDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice :>> GNCDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 1;
            computersInstantiationChoice :>> GNCDesignSpace::architecturalChoices::computersInstantiationChoice = 1;
            sensorsInstantiationChoice :>> GNCDesignSpace::architecturalChoices::sensorsInstantiationChoice = 3;
            controlOrientationFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators.actuatorA;
            controlOrientationFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2 [0];
            controlOrientationFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys3 [0];
            sendActuatorSignalFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys1
                ::> computers.computerC;
            sendActuatorSignalFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys2 [0];
            sendActuatorSignalFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys3 [0];
            provideSensorDataFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1 ::> sensors_1.sensorB;
            provideSensorDataFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2 ::> sensors_2.sensorB;
            provideSensorDataFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3 ::> sensors_3.sensorC;
            actuatorSignalConnectionConnectionChoice
                :>> GNCDesignSpace::architecturalChoices::actuatorSignalConnectionConnectionChoice
                ::> actuatorSignalConnection;
            dataConnectionConnectionChoice
                :>> GNCDesignSpace::architecturalChoices::dataConnectionConnectionChoice ::> dataConnection_1;
        }
        formalDesignProblem :>> GNCDesignSpace::formalDesignProblem {
            actuatorsInstantiationDesVar :>> GNCDesignSpace::formalDesignProblem::actuatorsInstantiationDesVar = 1;
            controlOrientationFulfillmentChoiceSys1DesVar
                :>> GNCDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys1DesVar = 0;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>> GNCDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys2DesVar = null;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>> GNCDesignSpace::formalDesignProblem::controlOrientationFulfillmentChoiceSys3DesVar = null;
            computersInstantiationDesVar :>> GNCDesignSpace::formalDesignProblem::computersInstantiationDesVar = 1;
            sendActuatorSignalFulfillmentChoiceSys1DesVar
                :>> GNCDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys1DesVar = 2;
            sendActuatorSignalFulfillmentChoiceSys2DesVar
                :>> GNCDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys2DesVar = null;
            sendActuatorSignalFulfillmentChoiceSys3DesVar
                :>> GNCDesignSpace::formalDesignProblem::sendActuatorSignalFulfillmentChoiceSys3DesVar = null;
            sensorsInstantiationDesVar :>> GNCDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 3;
            provideSensorDataFulfillmentChoiceSys1DesVar
                :>> GNCDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys1DesVar = 1;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>> GNCDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys2DesVar = 1;
            provideSensorDataFulfillmentChoiceSys3DesVar
                :>> GNCDesignSpace::formalDesignProblem::provideSensorDataFulfillmentChoiceSys3DesVar = 2;
            actuatorSignalConnectionConnectionDesVar
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar = 1;
            actuatorSignalConnectionConnectionDesVar2
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar2 = null;
            actuatorSignalConnectionConnectionDesVar3
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar3 = null;
            actuatorSignalConnectionConnectionDesVar4
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar4 = null;
            actuatorSignalConnectionConnectionDesVar5
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar5 = null;
            actuatorSignalConnectionConnectionDesVar6
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar6 = null;
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
                1;
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
