package 'Architecture Package 134049' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #architecture part def <archId134049> 'Architecture #349'
        :> GNCDesignSpace {
        action provideSensorData :>> GNCDesignSpace::provideSensorData;
        action sendActuatorSignal :>> GNCDesignSpace::sendActuatorSignal;
        action controlOrientation :>> GNCDesignSpace::controlOrientation;
        connection dataConnection :>> GNCDesignSpace::dataConnection [5] = (
            dataConnection_1, dataConnection_2, dataConnection_3, dataConnection_4, dataConnection_5,
        );
        connection actuatorSignalConnection :>> GNCDesignSpace::actuatorSignalConnection [3] = (
            actuatorSignalConnection_1, actuatorSignalConnection_2, actuatorSignalConnection_3,
        );
        attribute mass :>> GNCDesignSpace::mass = 64.5 [SI::kilogram];
        attribute failureRate :>> GNCDesignSpace::failureRate = 2.201124613447264e-08;
        attribute logFailureRate :>> GNCDesignSpace::logFailureRate = -7.657355369804418;
        part sensors :>> GNCDesignSpace::sensors [3] = (sensors_1, sensors_2, sensors_3,);
        part computers :>> GNCDesignSpace::computers [3] = (computers_1, computers_2, computers_3,);
        part actuators :>> GNCDesignSpace::actuators [3] = (actuators_1, actuators_2, actuators_3,);
        #subsystem part sensors_1
            :> sensors {
            part sensorB :>> GNCDesignSpace::sensors::sensorB {
                perform
                    provideSensorData [1]
                    :>> GNCDesignSpace::sensors::sensorB::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorB::mass = 6 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorB::failureRate = 0.0001;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [3]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorC :>> GNCDesignSpace::sensors::sensorC [0];
            attribute mass :>> GNCDesignSpace::sensors::mass = 6 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate = 0.0001;
        }
        #subsystem part sensors_2
            :> sensors {
            part sensorB :>> GNCDesignSpace::sensors::sensorB {
                perform
                    provideSensorData [1]
                    :>> GNCDesignSpace::sensors::sensorB::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorB::mass = 6 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorB::failureRate = 0.0001;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorC :>> GNCDesignSpace::sensors::sensorC [0];
            attribute mass :>> GNCDesignSpace::sensors::mass = 6 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate = 0.0001;
        }
        #subsystem part sensors_3
            :> sensors {
            part sensorB :>> GNCDesignSpace::sensors::sensorB {
                perform
                    provideSensorData [1]
                    :>> GNCDesignSpace::sensors::sensorB::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorB::mass = 6 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorB::failureRate = 0.0001;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorC :>> GNCDesignSpace::sensors::sensorC [0];
            attribute mass :>> GNCDesignSpace::sensors::mass = 6 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate = 0.0001;
        }
        #subsystem part computers_1
            :> computers {
            part computerC :>> GNCDesignSpace::computers::computerC {
                perform
                    sendActuatorSignal [1]
                    :>> GNCDesignSpace::computers::computerC::sendActuatorSignalPerformance;
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
            attribute mass :>> GNCDesignSpace::computers::mass = 10 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::computers::failureRate = 2e-05;
        }
        #subsystem part computers_2
            :> computers {
            part computerC :>> GNCDesignSpace::computers::computerC {
                perform
                    sendActuatorSignal [1]
                    :>> GNCDesignSpace::computers::computerC::sendActuatorSignalPerformance;
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
            attribute mass :>> GNCDesignSpace::computers::mass = 10 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::computers::failureRate = 2e-05;
        }
        #subsystem part computers_3
            :> computers {
            part computerC :>> GNCDesignSpace::computers::computerC {
                perform
                    sendActuatorSignal [1]
                    :>> GNCDesignSpace::computers::computerC::sendActuatorSignalPerformance;
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
            attribute mass :>> GNCDesignSpace::computers::mass = 10 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::computers::failureRate = 2e-05;
        }
        #subsystem part actuators_1
            :> actuators {
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB {
                perform
                    controlOrientation [1]
                    :>> GNCDesignSpace::actuators::actuatorB::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorB::mass = 5.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorB::failureRate =
                    0.0002;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA [0];
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC [0];
            attribute mass :>> GNCDesignSpace::actuators::mass = 5.5 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate = 0.0002;
        }
        #subsystem part actuators_2
            :> actuators {
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB {
                perform
                    controlOrientation [1]
                    :>> GNCDesignSpace::actuators::actuatorB::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorB::mass = 5.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorB::failureRate =
                    0.0002;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA [0];
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC [0];
            attribute mass :>> GNCDesignSpace::actuators::mass = 5.5 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate = 0.0002;
        }
        #subsystem part actuators_3
            :> actuators {
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB {
                perform
                    controlOrientation [1]
                    :>> GNCDesignSpace::actuators::actuatorB::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorB::mass = 5.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorB::failureRate =
                    0.0002;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [1];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA [0];
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC [0];
            attribute mass :>> GNCDesignSpace::actuators::mass = 5.5 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate = 0.0002;
        }
        connection dataConnection_1 :> dataConnection
            connect sensors_1.sensorB.dataOutPort to computers_1.computerC.dataInPort;
        connection dataConnection_2 :> dataConnection
            connect sensors_1.sensorB.dataOutPort to computers_2.computerC.dataInPort;
        connection dataConnection_3 :> dataConnection
            connect sensors_1.sensorB.dataOutPort to computers_3.computerC.dataInPort;
        connection dataConnection_4 :> dataConnection
            connect sensors_2.sensorB.dataOutPort to computers_1.computerC.dataInPort;
        connection dataConnection_5 :> dataConnection
            connect sensors_3.sensorB.dataOutPort to computers_1.computerC.dataInPort;
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers_1.computerC.actuationSignalOutPort
            to actuators_2.actuatorB.actuationSignalInPort;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers_2.computerC.actuationSignalOutPort
            to actuators_1.actuatorB.actuationSignalInPort;
        connection actuatorSignalConnection_3 :> actuatorSignalConnection
            connect computers_3.computerC.actuationSignalOutPort
            to actuators_3.actuatorB.actuationSignalInPort;
        architecturalChoices :>> GNCDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 3;
            computersInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::computersInstantiationChoice = 3;
            sensorsInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::sensorsInstantiationChoice = 3;
            controlOrientationFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators_1.actuatorB;
            controlOrientationFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2
                ::> actuators_2.actuatorB;
            controlOrientationFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys3
                ::> actuators_3.actuatorB;
            sendActuatorSignalFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys1
                ::> computers_1.computerC;
            sendActuatorSignalFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys2
                ::> computers_2.computerC;
            sendActuatorSignalFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys3
                ::> computers_3.computerC;
            provideSensorDataFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1
                ::> sensors_1.sensorB;
            provideSensorDataFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2
                ::> sensors_2.sensorB;
            provideSensorDataFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3
                ::> sensors_3.sensorB;
            actuatorSignalConnectionConnectionChoice
                :>> GNCDesignSpace::architecturalChoices::actuatorSignalConnectionConnectionChoice
                ::> actuatorSignalConnection_1;
            dataConnectionConnectionChoice
                :>> GNCDesignSpace::architecturalChoices::dataConnectionConnectionChoice
                ::> dataConnection_1;
        }
        formalDesignProblem :>> GNCDesignSpace::formalDesignProblem {
            actuatorsInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::actuatorsInstantiationDesVar = 3;
            controlOrientationFulfillmentChoiceSys1DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys1DesVar = 1;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys2DesVar = 1;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys3DesVar = 1;
            computersInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::computersInstantiationDesVar = 3;
            sendActuatorSignalFulfillmentChoiceSys1DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys1DesVar = 2;
            sendActuatorSignalFulfillmentChoiceSys2DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys2DesVar = 2;
            sendActuatorSignalFulfillmentChoiceSys3DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys3DesVar = 2;
            sensorsInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::sensorsInstantiationDesVar = 3;
            provideSensorDataFulfillmentChoiceSys1DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys1DesVar = 1;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys2DesVar = 1;
            provideSensorDataFulfillmentChoiceSys3DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys3DesVar = 1;
            actuatorSignalConnectionConnectionDesVar
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar =
                0;
            actuatorSignalConnectionConnectionDesVar2
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar2 =
                1;
            actuatorSignalConnectionConnectionDesVar3
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar3 =
                0;
            actuatorSignalConnectionConnectionDesVar4
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar4 =
                1;
            actuatorSignalConnectionConnectionDesVar5
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar5 =
                0;
            actuatorSignalConnectionConnectionDesVar6
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar6 =
                0;
            actuatorSignalConnectionConnectionDesVar7
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar7 =
                0;
            actuatorSignalConnectionConnectionDesVar8
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar8 =
                0;
            actuatorSignalConnectionConnectionDesVar9
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar9 =
                1;
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
