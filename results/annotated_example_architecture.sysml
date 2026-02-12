package 'Example Architecture Instance Package' {
    doc /* Annotated example architecture instance,
    showing in details how an architecture instance is defined from the architecture design space. */

    // Import the the library and the design space model
    private import ArchitectureDesign::*;
    private import 'Guidance, Navigation & Control'::*;
    
    // The architecture instance subsets the design space
    #architecture part <archId481> 'Architecture Example' :> gncDesignSpace {

        // Local redefinition of the top-level functions
        action :>> provideSensorData;
        action :>> sendActuatorSignal;
        action :>> controlOrientation;
        
        // Redefinition of the top-level attributes, with values assigned after evaluation
        attribute mass :>> gncDesignSpace::mass = 37 [SI::kg];
        attribute failureRate :>> gncDesignSpace::failureRate = 0.00015001679672012197;
        attribute logFailureRate :>> gncDesignSpace::logFailureRate = -3.8238601121811935;

        // Redefinition of the sensors subsystem: only 1 instance
        #subsystem part :>> sensors {
            // Sensor type A has been selected
            part :>> sensorA {
                // Redefinition of the action performance link
                perform provideSensorData [1] :>> provideSensorDataPerformance;

                // Part-level attributes (static)
                attribute :>> mass = 3 [SI::kg];
                attribute :>> failureRate = 0.00015;
                
                // Data output port, declaring that there are 2 outgoing connections
                port :>> dataOutPort { out :>> data [2]; }
            }

            // Deselection of the other sensor types
            part :>> sensorB [0];
            part :>> sensorC [0];
            
            // System-level attributes (from the selected part)
            attribute :>> mass = 3 [SI::kg];
            attribute :>> failureRate = 0.00015;
        }

        // Redefinition of the computers, with 2 instances
        part :>> computers [2] = (computers_1, computers_2);

        #subsystem part computers_1 :> computers {

            part :>> computerB {
                // Redefinition of the performance and needsAction links
                perform sendActuatorSignal [1] :>> sendActuatorSignalPerformance;
                #needsAction ::> provideSensorData;
                
                attribute :>> mass = 5 [SI::kg];
                attribute :>> failureRate = 4e-05;

                port :>> dataInPort { in :>> data [1]; }
                port :>> actuationSignalOutPort { out :>> actuationSignal [1]; }
            }

            part :>> computerA [0];
            part :>> computerC [0];

            attribute :>> mass = 5 [SI::kg];
            attribute :>> failureRate = 4e-05;
        }

        #subsystem part computers_2 :> computers {

            part :>> computerC {
                perform sendActuatorSignal [1] :>> sendActuatorSignalPerformance;
                #needsAction ::> provideSensorData;

                attribute :>> mass = 10 [SI::kg];
                attribute :>> failureRate = 2e-05;

                port :>> dataInPort { in :>> data [1]; }
                port :>> actuationSignalOutPort { out :>> actuationSignal [1]; }
            }

            part :>> computerA [0];
            part :>> computerB [0];

            attribute :>> mass = 10 [SI::kg];
            attribute :>> failureRate = 2e-05;
        }

        // Redefinition of the actuators, with 2 instances
        part actuators :>> actuators [2] = (actuators_1, actuators_2);

        #subsystem part actuators_1 :> actuators {
            
            part :>> actuatorC {
                perform controlOrientation [1] :>> controlOrientationPerformance;
                #needsAction ::> sendActuatorSignal;

                attribute :>> mass = 9.5 [SI::kg];
                attribute :>> failureRate = 0.0001;

                port :>> actuationSignalInPort { in :>> actuationSignal [1]; }
            }
            
            part :>> actuatorA [0];
            part :>> actuatorB [0];
            
            attribute :>> mass = 9.5 [SI::kg];
            attribute :>> failureRate = 0.0001;
        }

        #subsystem part actuators_2 :> actuators {

            part :>> actuatorC {
                perform controlOrientation [1] :>> controlOrientationPerformance;
                #needsAction ::> sendActuatorSignal;

                attribute :>> mass = 9.5 [SI::kg];
                attribute :>> failureRate = 0.0001;
                
                port :>> actuationSignalInPort { in :>> actuationSignal [1]; }
            }
            part :>> actuatorA [0];
            part :>> actuatorB [0];

            attribute :>> mass = 9.5 [SI::kg];
            attribute :>> failureRate = 0.0001;
        }

        // Redefinition and subsetting of established data connections (sensors to computers)
        connection :>> dataConnection [2] = (dataConnection_1, dataConnection_2);
        
        connection dataConnection_1 :> dataConnection
            connect sensors.sensorA.dataOutPort to computers_1.computerB.dataInPort;
        connection dataConnection_2 :> dataConnection
            connect sensors.sensorA.dataOutPort to computers_2.computerC.dataInPort;
        
        // Redefinition and subsetting of established actuation signal connections (computers to actuators)
        connection :>> actuatorSignalConnection [2] = (
            actuatorSignalConnection_1, actuatorSignalConnection_2);
        
        connection actuatorSignalConnection_1 :> actuatorSignalConnection
            connect computers_1.computerB.actuationSignalOutPort
            to actuators_2.actuatorC.actuationSignalInPort; // Computer 1 to actuator 2
        connection actuatorSignalConnection_2 :> actuatorSignalConnection
            connect computers_2.computerC.actuationSignalOutPort
            to actuators_1.actuatorC.actuationSignalInPort; // Computer 2 to actuator 1

        // Redefinition of the architectural choices, showing how this architecture instance was generated
        :>> architecturalChoices {
            :>> actuatorsInstantiationChoice = 2; // 2 actuators
            :>> computersInstantiationChoice = 2; // 2 computers
            :>> sensorsInstantiationChoice = 1; // 1 sensor
            :>> controlOrientationFulfillmentChoiceSys1 references actuators_1.actuatorC;
            :>> controlOrientationFulfillmentChoiceSys2 ::> actuators_2.actuatorC;
            :>> controlOrientationFulfillmentChoiceSys3[0]; // Inactive choice
            :>> sendActuatorSignalFulfillmentChoiceSys1 ::> computers_1.computerB;
            :>> sendActuatorSignalFulfillmentChoiceSys2 ::> computers_2.computerC;
            :>> sendActuatorSignalFulfillmentChoiceSys3[0];
            :>> provideSensorDataFulfillmentChoiceSys1 ::> sensors.sensorA;
            :>> provideSensorDataFulfillmentChoiceSys2[0];
            :>> provideSensorDataFulfillmentChoiceSys3[0];
            :>> actuatorSignalConnectionConnectionChoice ::> actuatorSignalConnection;
            :>> dataConnectionConnectionChoice ::> dataConnection;
        }

        // Redefinition of the design problem, showing the equivalent but with design variable values
        :>> formalDesignProblem {
            :>> actuatorsInstantiationDesVar = 2;
            :>> controlOrientationFulfillmentChoiceSys1DesVar = 2;
            :>> controlOrientationFulfillmentChoiceSys2DesVar = 2;
            :>> controlOrientationFulfillmentChoiceSys3DesVar = null; // Inactive design variable
            :>> computersInstantiationDesVar = 2;
            :>> sendActuatorSignalFulfillmentChoiceSys1DesVar = 1;
            :>> sendActuatorSignalFulfillmentChoiceSys2DesVar = 2;
            :>> sendActuatorSignalFulfillmentChoiceSys3DesVar = null;
            :>> sensorsInstantiationDesVar = 1;
            :>> provideSensorDataFulfillmentChoiceSys1DesVar = 0;
            :>> provideSensorDataFulfillmentChoiceSys2DesVar = null;
            :>> provideSensorDataFulfillmentChoiceSys3DesVar = null;
            :>> actuatorSignalConnectionConnectionDesVar = 0;
            :>> actuatorSignalConnectionConnectionDesVar2  = 1;
            :>> actuatorSignalConnectionConnectionDesVar3 = 1;
            :>> actuatorSignalConnectionConnectionDesVar4 = 0;
            :>> actuatorSignalConnectionConnectionDesVar5 = null;
            :>> actuatorSignalConnectionConnectionDesVar6 = null;
            :>> actuatorSignalConnectionConnectionDesVar7 = null;
            :>> actuatorSignalConnectionConnectionDesVar8 = null;
            :>> actuatorSignalConnectionConnectionDesVar9 = null;
            :>> dataConnectionConnectionDesVar = 1;
            :>> dataConnectionConnectionDesVar2 = 1;
            :>> dataConnectionConnectionDesVar3 = null;
            :>> dataConnectionConnectionDesVar4 = null;
            :>> dataConnectionConnectionDesVar5 = null;
            :>> dataConnectionConnectionDesVar6 = null;
            :>> dataConnectionConnectionDesVar7 = null;
            :>> dataConnectionConnectionDesVar8 = null;
            :>> dataConnectionConnectionDesVar9 = null;
        }
    }
}
