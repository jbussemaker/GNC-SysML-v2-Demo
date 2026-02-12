//
// Architecture Design library
//
// Library for modeling architecture design space exploration and optimization concepts:
// Architecture design space and architecture instance definition.
//
// This library has been developed as part of the ODE4HERA project: https://www.ode4hera.eu/
//
// Version: v1.0
// License: MIT
// Maintainer: DLR Institute of System Architectures in Aeronautics
// Contact: jasper.bussemaker@dlr.de, francesco.torrigiani@dlr.de, luca.boggero@dlr.de
// Topics: MBSE, System Architecture Optimization (SAO)
//
// MIT License
//
// Copyright (c) 2025 Deutsches Zentrum für Luft- und Raumfahrt eV (DLR), Siemens Industry Software NV, Siemens AG, Siemens Industry Software SAS, IRT Saint Exupéry, EnginSoft SpA, Airbus Defence and Space SA, Airbus Defence and Space GmbH, Leonardo SpA
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.

library package ArchitectureDesign {
	doc
    /*
     * Library for modeling system architecture design space exploration and optimization
     * concepts:
     * - Modeling the architecture design space
     *   - Function-component allocation (action -> part) and induction (part -> action)
     *   - Port connection choices
     *   - Design variables, objectives, design constraints
     * - Modeling architecture instances
     *
     * Version v1.0.0
     *
     * Copyright 2025 Deutsches Zentrum für Luft- und Raumfahrt eV (DLR), Siemens Industry Software NV, Siemens AG, Siemens Industry Software SAS, IRT Saint Exupéry, EnginSoft SpA, Airbus Defence and Space SA, Airbus Defence and Space GmbH, Leonardo SpA
	 */

    public import DesignProblemDefs::*;
    public import ArchitectureDesignProblemDefs::*;
    public import ArchitectureChoiceModelingDefs::*;
    public import ArchitectureInstanceDefs::*;

    package ArchitectureDesignProblemDefs {
        doc /* Package containing definition of the architecture design space and design problem. */

	    private import ControlFunctions::*;
        public import ArchitectureDesignSpaceDef::*;
        public import ArchitectureChoiceVariables::*;

        // Architecture design space definition
        package ArchitectureDesignSpaceDef {

            part def ArchitectureDesignSpacePart {
                doc /* Reusable architecture design space definition,
                which can be recursively combined into a larger architecture design space.
                It specifies architecture-level and architecture-specific design choices,
                yielding a set of possible architecture instances. */

                action boundaryFunctions[*] ordered {
                    doc /* Functions (actions) to be fulfilled in order to provide
                    the top-level functionalities to the end user. */
                }

                ref part systemContext[0..1] : ArchitectureDesignSpacePart {
                    doc /* Reference to a part that contains elements outside of the system boundary.
                    Can also be the owning architecture design space part. */
                }
            }

            part def Subsystem :> ArchitectureDesignSpacePart {
                doc /* Part of the architecture design space that can be
                (recursively) instantiated multiple times. */
            }
            metadata def subsystem :> Metaobjects::SemanticMetadata {
                doc /* #subsystem is a part of the architecture design space
                that can be (recursively) instantiated multiple times.

                Should be used as a part:

                #subsystem part theSubSystem[1..2];
                */
                :>> baseType = Subsystem meta SysML::PartDefinition;
            }

            part def ArchitectureDesignSpace :> ArchitectureDesignSpacePart {
                doc /* An architecture design space, specifying architecture-level and 
                architecture-specific design choices, yielding a set of possible architecture instances 
                by modeling architectural choices. */

                item architecturalChoices[0..1] {
                    doc /* The design problem in terms of architectural choices,
                    not yet encoded as actual design variables. */
            
                    choices[1..*] : Base::Anything {
                        doc /* Architectural choices determine what choices can
                        be taken when defining an architecture instance from the design space,
                        at a less abstract level than actual design variables.
                        Architectural choices are encoded into design variables in the formalDesignProblem:
                        one architectural choices can be encoded as multiple design variables. */
                    }

                    occurrence choiceConstraints[0..*] : ChoiceConstraint;
                }
                
                item formalDesignProblem[0..1] : FormalDesignProblem {
                    doc /* The design problem as formalized from this architecture
                    design space, encoded as actual design variables.
                    Use allocations to trace from architectural choices in the
                    architecturalDesignProblem to design variables here. */
                }

                allocate architecturalChoices to formalDesignProblem;
            }
            metadata def architectureDesignSpace :> Metaobjects::SemanticMetadata {
                :> annotatedElement : SysML::PartUsage;
                :>> baseType = ArchitectureDesignSpace meta SysML::PartDefinition;
            }
        }

        // Architecture choice variables
        package ArchitectureChoiceVariables {

            occurrence def FunctionFulfillmentChoice :> Occurrences::Occurrence {
                doc /* An architectural choice regarding the selection of one or more parts to perform an action,
                also known as function fulfillment or function assignment choice.
                The values of the design variable are simply the names of the alternative parts. */
                ref action actionToPerform[1];
                ref occurrence performingAlternatives[2..*];
            }

            attribute InstantiationChoice :> OrdinalDesignVariable : ScalarValues::Positive {
                doc /* An architectural choice regarding the number of instantiations of some element. */
                ref instantiatingElement[1];
                :>> values[2..*] : ScalarValues::Natural;
            }

            abstract connection def PortConnectionChoice {
                doc /* An architectural choice about the connection of ports (using the #connectable mechanism).
                This actually is not a design variable by itself,
                because a given connection choice can be encoded as 1 or more design variables,
                with or without a way to directly map selected values to established connections. */
                ref port sourcePorts[1..*];
                ref port targetPorts[1..*];
                ref associatedConnection[1] : Connections::Connection;
            }

        }

    }

    package ArchitectureInstanceDefs {
        doc /* Package containing the definition of architecture instances. */

        // Architecture instance definition
        part def Architecture :> ArchitectureDesignSpace {
            doc /* An architecture instance, derived from an ArchitectureDesignSpace.
            An architecture instance represents a specific system architecture, obtained by 
            allocating architectural choices and by assigning values to architecture-specific design 
            variables. */
        }
        part architectures[*] : Architecture;

        metadata def architecture :> Metaobjects::SemanticMetadata {
            :> annotatedElement : SysML::PartUsage;
            :>> baseType = architectures meta SysML::PartUsage;
        }

    }

    package ArchitectureChoiceModelingDefs {
        doc /* Package containing elements needed for modeling architectural choices. */

        // Needs action dependencies
        action def NeededAction;
        action neededActions[*] : NeededAction;

        metadata def needsAction :> Metaobjects::SemanticMetadata {
            doc /* #needsAction declares that some part needs the inclusion of another action in 
            order to perform its actions.
            For example, in order to generateThrust, a turbofan needs the action provideFuel to be 
            performed by another part (e.g. fuelSystem).

            Should be used as a referential feature:

            action def ActionDef;
            part def PartDef {
                #needsAction : ActionDef;
            }

            action actionUsage : ActionDef;
            part partUsage : PartDef {
                #needsAction references actionUsage redefines action;
            }
            */
            :> annotatedElement : SysML::ActionUsage;
            :>> baseType = neededActions meta SysML::ActionUsage;
        }

        abstract occurrence def NonFulfillment {
            action nonFulfilledActions[*];
        }
        metadata def nonFulfillment :> Metaobjects::SemanticMetadata {
            doc /* #nonFulfillment declares that an action might also
            explicitly be not fulfilled.
            For example, an action for improving something about the
            system might also be not included, for example to save costs.

            Should be used as an abstract occurrence:

            action notFulfilledAction;
            abstract #nonFulfillment occurrence nonFulfillmentName {
                :>> nonFulfilledActions[1] = notFulfilledAction;
                // :>> nonFulfilledActions[2] = (notFulfilledAction, action2);
            }
            */
            :>> baseType = NonFulfillment meta SysML::OccurrenceDefinition;
        }

        abstract occurrence def MultiFulfillment {
            action fulfilledActions[*];
            part fulfillingParts[*];
        }
        metadata def multiFulfillment :> Metaobjects::SemanticMetadata {
            doc /* #multiFulfillment declares that an action might also
            explicitly be fulfilled by more than one part at a time.
            For example, generating torque might be fulfilled by a
            combusion engine and an electric motor.

            Should be used as an abstract occurrence:

            action multiFulfilledAction;
            part part1;
            part part2;
            abstract #multiFulfillment occurrence multiFulfillmentName {
                :>> fulfilledActions[1] = multiFulfilledAction;
                :>> fulfillingParts[2] = (part1, part2);
            }
            */
            :>> baseType = MultiFulfillment meta SysML::OccurrenceDefinition;
        }

        abstract connection def Decomposition;
        metadata def decomposition :> Metaobjects::SemanticMetadata {
            doc /* #decomposition declares that an action is decomposed
            into multiple lower-level actions.

            Should be used as an abstract connection:

            action highLevelFunction;
            action lowLevelFunction1;
            action lowLevelFunction2;
            abstract #decomposition connection decomp connect (
                highLevelFunction,
                lowLevelFunction1, lowLevelFunction2
            );
            
            Note that the first function in the list of connected elements is the higher-level function!
            */
            :>> baseType = Decomposition meta SysML::ConnectionDefinition;
        }

        abstract allocation def Concept;
        metadata def concept :> Metaobjects::SemanticMetadata {
            doc /* #concept maps a neutral function to a (relatively)
            specific function.
            For example, "transport passengers" might be mapped to
            "transport passengers by air".

            Should be used as an abstract allocation:

            action neutralFunction;
            action specificFunction;
            abstract #concept allocation conceptName
                allocate neutralFunction to specificFunction;
            */
            :>> baseType = Concept meta SysML::AllocationDefinition;
        }

        abstract connection def Incompatibility :> Connections::BinaryConnection;
        metadata def incompatibility :> Metaobjects::SemanticMetadata {
            doc /* #incompatibility declares that two elements are mutually
            incompatible with each other: they cannot exist together in an architecture instance.

            Should be used as a connection (note that the order of the connection does not matter):

            part part1;
            part part2;
            #incompatibility connection connect part1 to part2;
            */
            :>> baseType = Incompatibility meta SysML::ConnectionDefinition;
        }

        occurrence def ChoiceConstraint :> Occurrences::Occurrence {
            ref choices[1..*] : Base::Anything;
            attribute constraintType : ChoiceConstraintType;
        }
        enum def ChoiceConstraintType {
            Linked;
            Permutations;
            UnorderedCombinations;
            UnorderedNonreplacingCombinations;
        }
        metadata def choiceConstraint :> Metaobjects::SemanticMetadata {
            doc /* #choiceConstraint defines a constraint over two or more choices,
            constraining the mutual values they can take.

            For example, consider two choices with three options (A, B, C) each:

            | Constraint                           | Description                                           | Possible Combinations      |
            |--------------------------------------|-------------------------------------------------------|----------------------------|
            | Linked                               | All choices get the same value                        | AA, BB, CC (3)             |
            | Permutations                         | All combinations without repeating values             | AB, BA, AC, CA, BC, CB (6) |
            | Unordered Combinations               | All combinations when selection order is not relevant | AA, AB, AC, BB, BC, CC (6) |
            | Unordered Non-replacing Combinations | Unordered, without repeating values                   | AB, AC, BC (3)             |

            Should be used as an occurrence:

            occurrence choice1 : FunctionFulfillmentChoice {
                ref :>> actionToPerform[1] = ...;
                ref :>> performingPartAlternatives[3] = (..., ..., ...);
            }
            occurrence choice2 : FunctionFulfillmentChoice { ... }
            occurrence choice3 : FunctionFulfillmentChoice { ... }

            #choiceConstraint occurrence {
                ref :>> choices[3] = (choice1, choice2, choice3);
                :>> constraintType = ChoiceConstraintType::Linked;
            }
            */
            :>> baseType = ChoiceConstraint meta SysML::OccurrenceDefinition;
        }
    }

    // Design variable and output parameter types
    package DesignProblemDefs {
        doc /* Package containing definitions for design problems in terms of design variables and output metrics. */

        private import RealFunctions::*;
	    private import ControlFunctions::*;
        private import SequenceFunctions::*;
        private import MeasurementReferences::*;

        public import DesignVariableDefs::*;
        public import OutputDefs::*;

        // Formalized design problem definition
        item def FormalDesignProblem {
            doc /* A design problem in the form that a numerical optimization algorithm would see it:
            design variables, objectives and constraints. */
            
            attribute designVariables[1..*] :> DesignVariable {
                doc /* Design variables are the variables that can be changed by the optimization algorithm
                in order to change/improve the design. */
            }

            attribute objectives[1..*] :> ObjectiveOutput {
                doc /* Objects are outputs to be minimized or maximized in order to improve the design. */
            }

            attribute constraints[*] :> ConstraintOutput {
                doc /* Constraints are outputs which need to be satisfied in order to have a feasible design.
                Note that for optimization, usually inequality constraints (i.e. >= or <= operators) are used.
                Equality constraints (==) are usually part of the evaluation model. */
            }
        }

        package DesignVariableDefs {

            // Design variable
            attribute DesignVariable : Base::Anything;

            // Continuous design variables
            attribute ContinuousDesignVariable :> DesignVariable : ScalarValues::Real {
                doc /* A continuous design variable:
                an attribute that can take any real value between the bounds (inclusive). */

                attribute lowerBound : ScalarValues::Real;
                attribute upperBound : ScalarValues::Real;

                // Check that lower bound is lower than upper bound
                assert constraint { lowerBound < upperBound }

                // Check that the value is between the bounds (inclusive)
                assert constraint { (lowerBound <= that) & (that <= upperBound) }
            }

            // Discrete design variables
            attribute DiscreteDesignVariable :> DesignVariable : Base::Anything {
                doc /* A discrete variable:
                an attribute that can take any value from the provided list.
                Do not use this type directly: use any of the derived types to give more
                information to the optimizer. */
                attribute values[2..*] : Base::Anything;
                attribute isOrdered : ScalarValues::Boolean default true {
                    doc /* Determines whether ordering of the values is important/relevant or not. */
                }

                // Check that the selected value is part of the values array
                assert constraint { includes(values, that) }
            }

            attribute ContinuousStepDesignVariable :> DiscreteDesignVariable, ContinuousDesignVariable {
                doc /* A continuous design variable with a fixed step size:
                an attribute that can take any value between the bounds (inclusive),
                where the value is the sum of the lower bound and an integer multiple of the step.
                For example: bounds (0, 1), step 0.25 --> allowed values: 0.0, 0.25, 0.5, 0.75, 1.0 */

                :>> lowerBound;
                :>> upperBound;
                attribute step : ScalarValues::Real;
                
                :>> isOrdered = true;

                // Check that the step is smaller than the range
                assert constraint { step <= (upperBound - lowerBound) }

                // Set the allowed values, as determined from the lower bound and the step
                attribute nSteps : ScalarValues::Integer = floor((upperBound - lowerBound) / step);
                :>> values ordered : ScalarValues::Real = (0..nSteps)->collect { in n : ScalarValues::Integer; lowerBound + n*step };
            }

            attribute IntegerDesignVariable :> ContinuousStepDesignVariable : ScalarValues::Integer {
                doc /* An integer discrete design variable:
                an attribute that can take any value between two integer bounds (inclusive). */
                
                :>> lowerBound : ScalarValues::Integer;
                :>> upperBound : ScalarValues::Integer;
                
                :>> step = 1;
                :>> values ordered : ScalarValues::Integer;
            }

            attribute OrdinalDesignVariable :> DiscreteDesignVariable {
                doc /* An ordinal discrete design variable:
                an attribute that can take any value of a list of values,
                and the ordering of the values matters. */
                :>> values ordered;
                :>> isOrdered = true;
            }

            attribute NumericalOrdinalDesignVariable :> OrdinalDesignVariable : ScalarValues::Real {
                doc /* A numerical ordinal discrete design variable:
                an attribute that can take any numerical value in a list of ordered values,
                where the values are not necessarily uniformly spaced. */
                :>> values[2..*] : ScalarValues::Real;

                // Check that the values are ordered
                assert constraint { (1..values->size()-1)->forAll { in i; values#(i) < values#(i+1) } }
            }

            attribute CategoricalDesignVariable :> DiscreteDesignVariable {
                doc /* A categorical discrete design variable:
                an attribute that can take any value of a list of values,
                and the ordering of the values is not applicable or not important. */
                :>> isOrdered = false;
            }

            metadata def <contX> continuousDesignVariable :> Metaobjects::SemanticMetadata {
                :> annotatedElement : SysML::AttributeUsage;
                :>> baseType = ContinuousDesignVariable meta SysML::AttributeUsage;
            }

            metadata def <contStepX> continuousStepDesignVariable :> Metaobjects::SemanticMetadata {
                :> annotatedElement : SysML::AttributeUsage;
                :>> baseType = ContinuousStepDesignVariable meta SysML::AttributeUsage;
            }

            metadata def <intX> integerDesignVariable :> Metaobjects::SemanticMetadata {
                :> annotatedElement : SysML::AttributeUsage;
                :>> baseType = IntegerDesignVariable meta SysML::AttributeUsage;
            }

            metadata def <ordX> ordinalDesignVariable :> Metaobjects::SemanticMetadata {
                :> annotatedElement : SysML::AttributeUsage;
                :>> baseType = OrdinalDesignVariable meta SysML::AttributeUsage;
            }

            metadata def <numOrdX> numericalOrdinalDesignVariable :> Metaobjects::SemanticMetadata {
                :> annotatedElement : SysML::AttributeUsage;
                :>> baseType = NumericalOrdinalDesignVariable meta SysML::AttributeUsage;
            }

            metadata def <catX> categoricalDesignVariable :> Metaobjects::SemanticMetadata {
                :> annotatedElement : SysML::AttributeUsage;
                :>> baseType = CategoricalDesignVariable meta SysML::AttributeUsage;
            }

        }

        package OutputDefs {

            // Output attribute role definition
            attribute EvaluationOutput : ScalarValues::Real {
                doc /* An attribute that represents an output of the evaluation of a system. */
                attribute role : OutputRole default OutputRole::Metric;
                attribute units[0..1] : MeasurementUnit;
            }

            attribute ObjectiveOutput :> EvaluationOutput {
                doc /* An output attribute with the role of minimization (default) or maximization objective. */
                
                attribute minimize : ScalarValues::Boolean default true;

                :>> role = if minimize ? OutputRole::MinimizationObjective else OutputRole::MaximizationObjective;
            }
            alias MinimizationObjectiveOutput for ObjectiveOutput;
            attribute MaximizationObjectiveOutput :> ObjectiveOutput {
                doc /* Helper type to define a maximiation objective. */
                :>> minimize = false;
            }

            attribute ConstraintOutput :> EvaluationOutput {
                doc /* An output attribute with the role of constraint.
                Should also have an actual constraint defined, for example:
                
                attribute myConstraint :> ConstraintOutput {
                    asssert constraint { that >= 1000 }
                }

                */
                :>> role = OutputRole::Constraint;
            }

            enum def OutputRole {
                doc /* Different roles that an output attribute can play in the context of a design problem */
                Metric {
                    doc /* Simply a metric that is recorded but does not drive the design */
                }
                MinimizationObjective {
                    doc /* An minimization objective */
                }
                MaximizationObjective {
                    doc /* An maximization objective */
                }
                Constraint {
                    doc /* A constraint applied to an output */
                }
            }

            metadata def <evalOut> evaluationOutput :> Metaobjects::SemanticMetadata {
                doc /* Define an attribute as an evaluation output */
                :> annotatedElement : SysML::AttributeUsage;
                :>> baseType = EvaluationOutput meta SysML::AttributeUsage;
            }
            metadata def <minObj> minimizationObjective :> Metaobjects::SemanticMetadata {
                doc /* Define an attribute as a minimization objective */
                :> annotatedElement : SysML::AttributeUsage;
                :>> baseType = ObjectiveOutput meta SysML::AttributeUsage;
            }
            metadata def <maxObj> maximizationObjective :> Metaobjects::SemanticMetadata {
                doc /* Define an attribute as an evaluation output */
                :> annotatedElement : SysML::AttributeUsage;
                :>> baseType = MaximizationObjectiveOutput meta SysML::AttributeUsage;
            }
            metadata def <con> constraintOutput :> Metaobjects::SemanticMetadata {
                doc /* Define an attribute as a constraint */
                :> annotatedElement : SysML::AttributeUsage;
                :>> baseType = ConstraintOutput meta SysML::AttributeUsage;
            }

        }

    }

}
