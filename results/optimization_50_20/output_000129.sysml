package 'Architecture Package 41621' {
    private import 'Guidance, Navigation & Control'::*;
    private import ArchitectureDesign::*;
    #architecture part def <archId41621> 'Architecture #129'
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
        attribute mass :>> GNCDesignSpace::mass = 61.5 [SI::kilogram];
        attribute failureRate :>> GNCDesignSpace::failureRate = 0.00010000000028096509;
        attribute logFailureRate :>> GNCDesignSpace::logFailureRate = -3.999999998779784;
        part sensors :>> GNCDesignSpace::sensors [3] = (sensors_1, sensors_2, sensors_3,);
        part computers :>> GNCDesignSpace::computers [3] = (computers_1, computers_2, computers_3,);
        #subsystem part actuators
            :>> GNCDesignSpace::actuators {
            part actuatorC :>> GNCDesignSpace::actuators::actuatorC {
                perform
                    controlOrientation [1]
                    :>> GNCDesignSpace::actuators::actuatorC::controlOrientationPerformance;
                attribute mass :>> GNCDesignSpace::actuators::actuatorC::mass = 9.5 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::actuators::actuatorC::failureRate =
                    0.0001;
                port actuationSignalInPort :>> Actuator::actuationSignalInPort {
                    in actuationSignal :>> ActuationSignalOutPort::actuationSignal [3];
                }
                #needsAction ::> sendActuatorSignal;
            }
            part actuatorA :>> GNCDesignSpace::actuators::actuatorA [0];
            part actuatorB :>> GNCDesignSpace::actuators::actuatorB [0];
            attribute mass :>> GNCDesignSpace::actuators::mass = 9.5 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::actuators::failureRate = 0.0001;
        }
        #subsystem part sensors_1
            :> sensors {
            part sensorC :>> GNCDesignSpace::sensors::sensorC {
                perform
                    provideSensorData [1]
                    :>> GNCDesignSpace::sensors::sensorC::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorC::mass = 9 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorC::failureRate = 5e-05;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [2]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorB :>> GNCDesignSpace::sensors::sensorB [0];
            attribute mass :>> GNCDesignSpace::sensors::mass = 9 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate = 5e-05;
        }
        #subsystem part sensors_2
            :> sensors {
            part sensorC :>> GNCDesignSpace::sensors::sensorC {
                perform
                    provideSensorData [1]
                    :>> GNCDesignSpace::sensors::sensorC::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorC::mass = 9 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorC::failureRate = 5e-05;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [1]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorB :>> GNCDesignSpace::sensors::sensorB [0];
            attribute mass :>> GNCDesignSpace::sensors::mass = 9 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate = 5e-05;
        }
        #subsystem part sensors_3
            :> sensors {
            part sensorC :>> GNCDesignSpace::sensors::sensorC {
                perform
                    provideSensorData [1]
                    :>> GNCDesignSpace::sensors::sensorC::provideSensorDataPerformance;
                attribute mass :>> GNCDesignSpace::sensors::sensorC::mass = 9 [SI::kg];
                attribute failureRate :>> GNCDesignSpace::sensors::sensorC::failureRate = 5e-05;
                port dataOutPort :>> Sensor::dataOutPort { out data :>> DataOutPort::data [2]; }
            }
            part sensorA :>> GNCDesignSpace::sensors::sensorA [0];
            part sensorB :>> GNCDesignSpace::sensors::sensorB [0];
            attribute mass :>> GNCDesignSpace::sensors::mass = 9 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::sensors::failureRate = 5e-05;
        }
        #subsystem part computers_1
            :> computers {
            part computerB :>> GNCDesignSpace::computers::computerB {
                perform
                    sendActuatorSignal [1]
                    :>> GNCDesignSpace::computers::computerB::sendActuatorSignalPerformance;
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
            attribute mass :>> GNCDesignSpace::computers::mass = 5 [SI::kilogram];
            attribute failureRate :>> GNCDesignSpace::computers::failureRate = 4e-05;
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
                port dataInPort :>> Computer::dataInPort { in data :>> DataOutPort::data [2]; }
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
        connection dataConnection_1 :> dataConnection
            connect sensors_1.sensorC.dataOutPort to computers_1.computerB.dataInPort;
        connection dataConnection_2 :> dataConnection
            connect sensors_1.sensorC.dataOutPort to computers_2.computerC.dataInPort;
        connection dataConnection_3 :> dataConnection
            connect sensors_2.sensorC.dataOutPort to computers_1.computerB.dataInPort;
        connection dataConnection_4 :> dataConnection
            connect sensors_3.sensorC.dataOutPort to computers_2.computerC.dataInPort;
        connection dataConnection_5 :> dataConnection
            connect sensors_3.sensorC.dataOutPort to computers_3.computerC.dataInPort;
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers_1.computerB.actuationSignalOutPort
            to actuators.actuatorC.actuationSignalInPort;
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers_2.computerC.actuationSignalOutPort
            to actuators.actuatorC.actuationSignalInPort;
        connection actuatorSignalConnection_3 :> actuatorSignalConnection
            connect computers_3.computerC.actuationSignalOutPort
            to actuators.actuatorC.actuationSignalInPort;
        architecturalChoices :>> GNCDesignSpace::architecturalChoices {
            actuatorsInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::actuatorsInstantiationChoice = 1;
            computersInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::computersInstantiationChoice = 3;
            sensorsInstantiationChoice
                :>> GNCDesignSpace::architecturalChoices::sensorsInstantiationChoice = 3;
            controlOrientationFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys1
                ::> actuators.actuatorC;
            controlOrientationFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys2
                [0];
            controlOrientationFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::controlOrientationFulfillmentChoiceSys3
                [0];
            sendActuatorSignalFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys1
                ::> computers_1.computerB;
            sendActuatorSignalFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys2
                ::> computers_2.computerC;
            sendActuatorSignalFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::sendActuatorSignalFulfillmentChoiceSys3
                ::> computers_3.computerC;
            provideSensorDataFulfillmentChoiceSys1
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys1
                ::> sensors_1.sensorC;
            provideSensorDataFulfillmentChoiceSys2
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys2
                ::> sensors_2.sensorC;
            provideSensorDataFulfillmentChoiceSys3
                :>> GNCDesignSpace::architecturalChoices::provideSensorDataFulfillmentChoiceSys3
                ::> sensors_3.sensorC;
            actuatorSignalConnectionConnectionChoice
                :>> GNCDesignSpace::architecturalChoices::actuatorSignalConnectionConnectionChoice
                ::> actuatorSignalConnection_1;
            dataConnectionConnectionChoice
                :>> GNCDesignSpace::architecturalChoices::dataConnectionConnectionChoice
                ::> dataConnection_1;
        }
        formalDesignProblem :>> GNCDesignSpace::formalDesignProblem {
            actuatorsInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::actuatorsInstantiationDesVar = 1;
            controlOrientationFulfillmentChoiceSys1DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys1DesVar = 2;
            controlOrientationFulfillmentChoiceSys2DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys2DesVar = null;
            controlOrientationFulfillmentChoiceSys3DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::controlOrientationFulfillmentChoiceSys3DesVar = null;
            computersInstantiationDesVar
                :>> GNCDesignSpace::formalDesignProblem::computersInstantiationDesVar = 3;
            sendActuatorSignalFulfillmentChoiceSys1DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::sendActuatorSignalFulfillmentChoiceSys1DesVar = 1;
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
                        ::provideSensorDataFulfillmentChoiceSys1DesVar = 2;
            provideSensorDataFulfillmentChoiceSys2DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys2DesVar = 2;
            provideSensorDataFulfillmentChoiceSys3DesVar
                :>>
                    GNCDesignSpace::formalDesignProblem
                        ::provideSensorDataFulfillmentChoiceSys3DesVar = 2;
            actuatorSignalConnectionConnectionDesVar
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar =
                1;
            actuatorSignalConnectionConnectionDesVar2
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar2 =
                1;
            actuatorSignalConnectionConnectionDesVar3
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar3 =
                1;
            actuatorSignalConnectionConnectionDesVar4
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar4 =
                null;
            actuatorSignalConnectionConnectionDesVar5
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar5 =
                null;
            actuatorSignalConnectionConnectionDesVar6
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar6 =
                null;
            actuatorSignalConnectionConnectionDesVar7
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar7 =
                null;
            actuatorSignalConnectionConnectionDesVar8
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar8 =
                null;
            actuatorSignalConnectionConnectionDesVar9
                :>> GNCDesignSpace::formalDesignProblem::actuatorSignalConnectionConnectionDesVar9 =
                null;
            dataConnectionConnectionDesVar
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar = 1;
            dataConnectionConnectionDesVar2
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar2 = 1;
            dataConnectionConnectionDesVar3
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar3 = 0;
            dataConnectionConnectionDesVar4
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar4 = 1;
            dataConnectionConnectionDesVar5
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar5 = 0;
            dataConnectionConnectionDesVar6
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar6 = 0;
            dataConnectionConnectionDesVar7
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar7 = 0;
            dataConnectionConnectionDesVar8
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar8 = 1;
            dataConnectionConnectionDesVar9
                :>> GNCDesignSpace::formalDesignProblem::dataConnectionConnectionDesVar9 = 1;
        }
    }
}
