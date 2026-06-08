package ArchitectureDesign_ConnectionChoiceExample {
    doc
    /*
     Package showing an example of architectural connection choice:
     - There are 3 sensors, 3 computers, and 3 actuators
     - Sensors need to be connected to computers, computers to actuators
     - Each sensor needs at least 1 connection to a computer, each computer needs at least 1 connection from a sensor
     - Each computer has 1 or 2 outgoing connections to an actuator
     - Each actuator can accept up to 2 connections from a computer
    
    Copyright: (c) 2026, The Contributors to the ODE4HERA SysML v2 Libraries.
     */
    private import ArchitectureDesign::*;

    // Abstract port definitions to define the top-level output flows
    
    item def OutputState;
    abstract port def ControlOutput {
        out outputState: OutputState;
    }

    // Abstract action definitions

    item def ReferenceState;
    item def ActuationSignal;
    item def SensorSignal;

    abstract action def SenseState {
        in referenceState: ReferenceState;
        out sensorSignal: SensorSignal;
    }

    abstract action def ComputeActuation {
        in sensorSignal: SensorSignal;
        out actuationSignal: ActuationSignal;
    }

    abstract action def ProvideActuation {
        in actuationSignal: ActuationSignal;
        out outputState: OutputState;
    }

    // Part, port, and flow definitions which implement the actions

    port def SensorSignalPort {
        out item sensorSignal[1..*] ordered : SensorSignal;
    }

    interface def SensorSignalInterface {
        end sensorSignalOutPort: SensorSignalPort;
        end sensorSignalInPort: ~SensorSignalPort;

        flow of SensorSignal
            from sensorSignalOutPort.sensorSignal
                to sensorSignalInPort.sensorSignal;
    }

    port def ActuationSignalPort {
        out item actuationSignal[(1, 2)] ordered : ActuationSignal;
    }

    interface def ActuationSignalInterface {
        end actuationSignalOutPort: ActuationSignalPort;
        end actuationSignalInPort: ~ActuationSignalPort;

        flow of ActuationSignal
            from actuationSignalOutPort.actuationSignal
                to actuationSignalInPort.actuationSignal;
    }

    part def Sensor {
        doc /* Sensor part */
        perform action senseState: SenseState;

        port sensorSignalOutPort[1] ordered: SensorSignalPort;
        bind senseState.sensorSignal = sensorSignalOutPort.sensorSignal;
    }

    part def Computer {
        doc /* Computer part */
        perform action computeActuation: ComputeActuation;

        port sensorSignalInPort[1] ordered: ~SensorSignalPort;
        bind computeActuation.sensorSignal = sensorSignalInPort.sensorSignal;

        port actuationSignalOutPort[1] ordered: ActuationSignalPort;
        bind computeActuation.actuationSignal = actuationSignalOutPort.actuationSignal;
    }

    part def Actuator {
        doc /* Actuator part */
        perform action provideActuation: ProvideActuation;

        port actuationSignalInPort ordered: ~ActuationSignalPort {
            in :>> actuationSignal[0..2];
        }
        bind provideActuation.actuationSignal = actuationSignalInPort.actuationSignal;
    }

    // Architecture design space model

    #architectureDesignSpace part def ControlSystem {
        doc /* Control system architecture design space */

        // Define the top-level functions
        action senseState : SenseState :> boundaryFunctions;
        action computeActuation : ComputeActuation :> boundaryFunctions;
        action provideActuation : ProvideActuation :> boundaryFunctions;

        // Define the parts and attach flows

        part sensor[3]: Sensor {
            perform senseState redefines Sensor::senseState;
        }

        part computer[3]: Computer {
            perform computeActuation redefines Computer::computeActuation;
        }

        part actuator[3]: Actuator {
            perform provideActuation redefines Actuator::provideActuation;
        }

        interface sensorSignalInterface : SensorSignalInterface {
            end sensorSignalPort ::> sensor.sensorSignalOutPort;
            end sensorSignalInPort ::> computer.sensorSignalInPort;
        }
        
        interface actuationSignalInterface : ActuationSignalInterface {
            end actuationSignalOutPort ::> computer.actuationSignalOutPort;
            end actuationSignalInPort ::> actuator.actuationSignalInPort;
        }

        // List of architectural choices
        :>> architecturalChoices {
            :>> choices[2] ordered = (sensorComputerConnectionChoice, computerActuatorConnectionChoice);

            derived abstract connection sensorComputerConnectionChoice :> choices : PortConnectionChoice {
                ref :>> sourcePorts = sensor.sensorSignalOutPort;
                ref :>> targetPorts = computer.sensorSignalInPort;
                :>> associatedConnection = sensorSignalInterface;
            }

            derived abstract connection computerActuatorConnectionChoice :> choices : PortConnectionChoice {
                ref :>> sourcePorts = computer.actuationSignalOutPort;
                ref :>> targetPorts = actuator.actuationSignalInPort;
                :>> associatedConnection = actuationSignalInterface;
            }
        }

        // Formalization of the design problem
        :>> formalDesignProblem {
            :>> designVariables[18] ordered = (
                s1c1Connection, s1c2Connection, s1c3Connection,
                s2c1Connection, s2c2Connection, s2c3Connection,
                s3c1Connection, s3c2Connection, s3c3Connection,
                c1a1Connection, c1a2Connection, c1a2Connection,
                c2a1Connection, c2a2Connection, c2a2Connection,
                c3a1Connection, c3a2Connection, c3a2Connection,
            );

            #catX attribute s1c1Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute s1c2Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute s1c3Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute s2c1Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute s2c2Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute s2c3Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute s3c1Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute s3c2Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute s3c3Connection :> designVariables { :>> values = (0, 1); }

            allocation allocate architecturalChoices.sensorComputerConnectionChoice to s1c1Connection;
            allocation allocate architecturalChoices.sensorComputerConnectionChoice to s1c2Connection;
            // And so on ...

            #catX attribute c1a1Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute c1a2Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute c1a3Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute c2a1Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute c2a2Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute c2a3Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute c3a1Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute c3a2Connection :> designVariables { :>> values = (0, 1); }
            #catX attribute c3a3Connection :> designVariables { :>> values = (0, 1); }

            allocation allocate architecturalChoices.computerActuatorConnectionChoice to c1a1Connection;
            // And so on ...
        }

    }

    // Architecture instances
    #architecture part def ControlSystemInstance specializes ControlSystem {
        doc /* Control system architecture instance */
        
        action :>> senseState[1];
        action :>> computeActuation[1];
        action :>> provideActuation[1];

        part redefines sensor[3] = (sensor1, sensor2, sensor3);
        part sensor1 subsets sensor {
            perform action :>> senseState;
            port :>> sensorSignalOutPort {
                out :>> sensorSignal[3];
            }
        }
        part sensor2 subsets sensor {
            perform action :>> senseState;
            port :>> sensorSignalOutPort {
                out :>> sensorSignal[1];
            }
        }
        part sensor3 subsets sensor {
            perform action :>> senseState;
            port :>> sensorSignalOutPort {
                out :>> sensorSignal[1];
            }
        }

        part :>> computer[3] = (computer1, computer2, computer3);
        part computer1 subsets computer {
            perform action :>> computeActuation;
            port :>> sensorSignalInPort {
                in :>> sensorSignal[1];
            }
            port :>> actuationSignalOutPort {
                out :>> actuationSignal[1];
            }
        }
        part computer2 subsets computer {
            perform action :>> computeActuation;
            port :>> sensorSignalInPort {
                in :>> sensorSignal[2];
            }
            port :>> actuationSignalOutPort {
                out :>> actuationSignal[2];
            }
        }
        part computer3 subsets computer {
            perform action :>> computeActuation;
            port :>> sensorSignalInPort {
                in :>> sensorSignal[2];
            }
            port :>> actuationSignalOutPort {
                out :>> actuationSignal[1];
            }
        }

        part :>> actuator[3] = (actuator1, actuator2, actuator3);
        part actuator1 subsets actuator {
            perform action :>> provideActuation;
            port :>> actuationSignalInPort {
                in :>> actuationSignal[3];
            }
        }
        part actuator2 subsets actuator {
            perform action :>> provideActuation;
            port :>> actuationSignalInPort {
                in :>> actuationSignal[1];
            }
        }
        part actuator3 subsets actuator {
            perform action :>> provideActuation;
            port :>> actuationSignalInPort {
                in :>> actuationSignal[0];
            }
        }

        // Sensor signal connections: i connected to i, 1 connected to all
        interface redefines sensorSignalInterface[5]
            = (sscInt1, sscInt2, sscInt3, sscInt4, sscInt5);
        interface sscInt1 subsets sensorSignalInterface
            connect sensorSignalOutPort references sensor1.sensorSignalOutPort
                to sensorSignalInPort references computer1.sensorSignalInPort;
        interface sscInt2 subsets sensorSignalInterface
            connect sensorSignalOutPort references sensor1.sensorSignalOutPort
                to sensorSignalInPort references computer2.sensorSignalInPort;
        interface sscInt3 subsets sensorSignalInterface
            connect sensorSignalOutPort references sensor1.sensorSignalOutPort
                to sensorSignalInPort references computer3.sensorSignalInPort;
        interface sscInt4 subsets sensorSignalInterface
            connect sensorSignalOutPort references sensor2.sensorSignalOutPort
                to sensorSignalInPort references computer2.sensorSignalInPort;
        interface sscInt5 subsets sensorSignalInterface
            connect sensorSignalOutPort references sensor3.sensorSignalOutPort
                to sensorSignalInPort references computer3.sensorSignalInPort;

        // Actuation signal connections: i connected to 1, 2 connected to 2
        interface :>> actuationSignalInterface[4] = (ascInt1, ascInt2, ascInt3, ascInt4);
        interface ascInt1 subsets actuationSignalInterface
            connect actuationSignalOutPort references computer1.actuationSignalOutPort
                to actuationSignalInPort references actuator1.actuationSignalInPort;
        interface ascInt2 subsets actuationSignalInterface
            connect actuationSignalOutPort references computer2.actuationSignalOutPort
                to actuationSignalInPort references actuator1.actuationSignalInPort;
        interface ascInt3 subsets actuationSignalInterface
            connect actuationSignalOutPort references computer3.actuationSignalOutPort
                to actuationSignalInPort references actuator1.actuationSignalInPort;
        interface ascInt4 subsets actuationSignalInterface
            connect actuationSignalOutPort references computer2.actuationSignalOutPort
                to actuationSignalInPort references actuator2.actuationSignalInPort;

        :>> architecturalChoices {
            :>> sensorComputerConnectionChoice references sensorSignalInterface;
            :>> computerActuatorConnectionChoice ::> actuationSignalInterface;
        }
        :>> formalDesignProblem {
            :>> s1c1Connection = 1;
            :>> s1c2Connection = 1;
            :>> s1c3Connection = 1;
            :>> s2c1Connection = 0;
            :>> s2c2Connection = 1;
            :>> s2c3Connection = 0;
            :>> s3c1Connection = 0;
            :>> s3c2Connection = 0;
            :>> s3c3Connection = 1;

            :>> c1a1Connection = 1;
            :>> c1a2Connection = 0;
            :>> c1a3Connection = 0;
            :>> c2a1Connection = 1;
            :>> c2a2Connection = 1;
            :>> c2a3Connection = 0;
            :>> c3a1Connection = 1;
            :>> c3a2Connection = 0;
            :>> c3a3Connection = 0;
        }

    }

}
