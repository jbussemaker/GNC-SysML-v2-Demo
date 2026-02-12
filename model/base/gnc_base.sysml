package GuidanceNavigationControlSAO {
    doc /*
    The Guidance, Navigation and Control (GNC) problem implemented in SysML v2.
    The GNC problem is a System Architecture Optimization (SAO) problem, that features the
    selection of the number of objects, object types, and object connections for
    connecting sensors to computers to actuators.
    Based on the implementation in SBArchOpt: https://sbarchopt.readthedocs.io/
    */

    private import ScalarValues::*;
    private import SI::kg;

    private import ArchitectureDesign::*;

    // Definitions related to the connections between objects
    item def Data;

    port def DataOutPort {
        doc /* Port outputting data. */
        out item data[1..*] ordered : Data {
            doc /* The outputted data item.
            It should establish at least 1 connection, but more can be
            established for redundancy (to reduce the system-level failure rate).
            We set it to ordered to declare that it matters in which
            order connections are established from a part that uses the port. */
        }
    }

    item def ActuationSignal;

    port def ActuationSignalOutPort {
        out item actuationSignal[1..*] ordered : ActuationSignal;
    }

    // Unfortunately, we cannot use interfaces to define the connections, because
    // interfaces do not support higher-multiplicity subsetting:
    // The definition would have just 2 connection ends, however in the design space
    // there would be 6 (because there would be 3 port usages for each connector end).
    // This is not possible, because the interface would be declared as "binary" by
    // initially only defining two ends.
    
    // Object part definitions
    
    part def Object {
        doc /* Base part def for anything with a mass and a failure rate. */
        #evalOut attribute mass : ISQ::MassValue;
        attribute failureRate : Real;
    }

    part def Sensor :> Object {
        doc /* Sensor: senses data and sends it to the computer. */

        port dataOutPort ordered : DataOutPort;
    }
    part def Computer :> Object {
        doc /* Computer: takes data and computes desired actuation signals. */

        port dataInPort ordered : ~DataOutPort;
        port actuationSignalOutPort ordered : ActuationSignalOutPort;
    }
    part def Actuator :> Object {
        doc /* Actuator: applies the actuation signal. */

        port actuationSignalInPort ordered : ~ActuationSignalOutPort;
    }

    // Database of available sensors, computers, and actuators, with different mass and failure rate trade-offs
    
    part def SensorA :> Sensor { :>> mass default 3.0[kg]; :>> failureRate default .00015; }
    part def SensorB :> Sensor { :>> mass default 6.0[kg]; :>> failureRate default .00010; }
    part def SensorC :> Sensor { :>> mass default 9.0[kg]; :>> failureRate default .00005; }

    part def ComputerA :> Computer { :>> mass default 3.0[kg];  :>> failureRate default .00010; }
    part def ComputerB :> Computer { :>> mass default 5.0[kg];  :>> failureRate default .00004; }
    part def ComputerC :> Computer { :>> mass default 10.0[kg]; :>> failureRate default .00002; }

    part def ActuatorA :> Actuator { :>> mass default 3.5[kg]; :>> failureRate default .00008; }
    part def ActuatorB :> Actuator { :>> mass default 5.5[kg]; :>> failureRate default .00020; }
    part def ActuatorC :> Actuator { :>> mass default 9.5[kg]; :>> failureRate default .00010; }

    #architectureDesignSpace part gncDesignSpace : Object {

        // Set metric roles
        #minObj attribute :>> mass default QuantityCalculations::sum((sensors.mass, computers.mass, actuators.mass));
        #evalOut attribute :>> failureRate;
        #minObj attribute logFailureRate : Real;

        // Sensors
        
        action provideSensorData;

        #subsystem part sensors[1..3] : Object {

            attribute :>> mass default QuantityCalculations::sum((sensorA.mass, sensorB.mass, sensorC.mass));

            part sensorA[0..1] : SensorA {
                perform provideSensorData;
            }
            part sensorB[0..1] : SensorB {
                perform provideSensorData;
            }
            part sensorC[0..1] : SensorC {
                perform provideSensorData;
            }

        }

        // Sensor-to-computer connection
        connection dataConnection {
            doc /* Data connection from sensors to computers. */

            end references sensors.sensorA.dataOutPort;
            end references sensors.sensorB.dataOutPort;
            end references sensors.sensorC.dataOutPort;

            end references computers.computerA.dataInPort;
            end references computers.computerB.dataInPort;
            end references computers.computerC.dataInPort;
        }

        // Computers

        action sendActuatorSignal;

        #subsystem part computers[1..3] : Object {

            attribute :>> mass default QuantityCalculations::sum((computerA.mass, computerB.mass, computerC.mass));

            part computerA[0..1] : ComputerA {
                perform sendActuatorSignal;
                ref #needsAction action references provideSensorData;
            }
            part computerB[0..1] : ComputerB {
                perform sendActuatorSignal;
                ref #needsAction action references provideSensorData;
            }
            part computerC[0..1] : ComputerC {
                perform sendActuatorSignal;
                ref #needsAction action references provideSensorData;
            }

        }

        // Computer-to-actuator connection
        connection actuatorSignalConnection {
            end references computers.computerA.actuationSignalOutPort;
            end references computers.computerB.actuationSignalOutPort;
            end references computers.computerC.actuationSignalOutPort;

            end references actuators.actuatorA.actuationSignalInPort;
            end references actuators.actuatorB.actuationSignalInPort;
            end references actuators.actuatorC.actuationSignalInPort;
        }

        // Actuators

        action controlOrientation;

        #subsystem part actuators[1..3] : Object {

            attribute :>> mass default QuantityCalculations::sum((actuatorA.mass, actuatorB.mass, actuatorC.mass));

            part actuatorA[0..1] : ActuatorA {
                perform controlOrientation;
                ref #needsAction action references sendActuatorSignal;
            }
            part actuatorB[0..1] : ActuatorB {
                perform controlOrientation;
                ref #needsAction action references sendActuatorSignal;
            }
            part actuatorC[0..1] : ActuatorC {
                perform controlOrientation;
                ref #needsAction action references sendActuatorSignal;
            }

        }

    }

}
