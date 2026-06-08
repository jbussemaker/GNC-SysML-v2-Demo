# Architecture Design Library

This library adds concepts for modeling architecture design problems to enable the automatic generation, evaluation and optimization of system architectures.

Following concepts are added:
- Architectural choices: function allocation, element instantiation, port connections
- Architectural constraints: incompatibility constraints, choice constraints
- Design variables: continuous, discrete (integer, ordinal, categorical)
- Performance metrics: generic outputs, objectives (minimization/maximization), constraint functions
- Complexity management elements: concepts, decompositions, non/multi-fulfillments, subsystems
- Architecture design space: modular build-up of the design space containing all architecture instances
- Architecture instances: specific architectures as generated from the design space definition

This library has originally been developed as part of the [ODE4HERA project](https://www.ode4hera.eu/).

## Example

An architecture design space might look like this:

```sysml
private import ArchitectureDesign::*;

#architectureDesignSpace part def PropulsionSystemDesignSpace {
    
    // System-level objective
    #minObj attribute mass :> ISQ::mass 
        = turboprop.mass + fuelSystem.fuelTank.mass;
    
    action generateThrust :> boundaryFunctions {
        // Static input
        attribute seaLevelthrust :> ISQ::force = 150e3[SI::N]; }

    // Part instantiation choice: between 2 and 4 times
    part turboprop[2..4] {
        // Function performance: this part can be used to fulfill the function
        perform generateThrust;

        // Function induction: if this part is selected,
        // the following functions also are selected and need to be fulfilled
        #needsAction ::> provideFuel;

        // Design variables
        #intX attribute nrStages { :>> lowerBound = 1; :>> upperBound = 3; }
        #catX attribute bladeManufacturer { :>> values = ("MT", "Sensenich"); }
        #contX attribute pressureRatio { :>> lowerBound = 10; :>> upperBound = 30; }

        // Objective, constraint and output metric
        #minObj attribute tsfc;
        #con attribute turbineTemp {
            assert constraint { that <= 1500[SI::'°C_abs'] }
        }
        attribute mass :> ISQ::mass;
    }
    
    action provideFuel;
    
    // Subsystem instantiation choice: 1 or 2 times
    #subsystem part fuelSystem[1..2] {
        // Independent part instantiation choice
        part fuelTank[1..2] {
            perform provideFuel;
            attribute mass :> ISQ::mass; }
    }
}
```

An architecture instance generated from this design space might then look like this:

```sysml
#architecture part def SimpleArchitecture :> PropulsionSystemDesignSpace {

    // Output parameters have no value initially:
    // the values should be assigned by the architecture evaluation
    attribute :>> mass;

    action :>> generateThrust[1];

    part :>> turboprop[2] = (turboprop_1, turboprop_2);

    part turboprop_1 :> turboprop {
        perform generateThrust;
        #needsAction ::> provideFuel;

        attribute :>> nrStages = 2;
        attribute :>> bladeManufacturer = "MT";
        attribute :>> pressureRatio = 25;

        attribute :>> tsfc;
        attribute :>> turbineTemp;
        attribute :>> mass;
    }

    part turboprop_2 :> turboprop {
        perform generateThrust;
        #needsAction ::> provideFuel;

        attribute :>> nrStages = 3;
        attribute :>> bladeManufacturer = "MT";
        attribute :>> pressureRatio = 15;

        attribute :>> tsfc;
        attribute :>> turbineTemp;
        attribute :>> mass;
    }

    action :>> provideFuel[1];

    #subsystem part :>> fuelSystem[1] {
        part :>> fuelTank[1] {
            perform provideFuel;
            attribute :>> mass;
        }
    }
}
```

For more examples, have a look at the models in the `examples` folder.

A more complete example, including optimization results, can be found here:
[https://github.com/jbussemaker/GNC-SysML-v2-Demo](https://github.com/jbussemaker/GNC-SysML-v2-Demo)

## More Information and Citation

If you use this library and/or if you want to know more about the background, please refer to and cite:

Bussemaker, J.H. et al., 2026, April.
System Architecture Optimization Using SysML v2: Language Extension and Implementation.
IEEE SysCon 2026, Halifax, Canada.
doi: [10.1109/SysCon66367.2026.11503593](https://dx.doi.org/10.1109/SysCon66367.2026.11503593)
