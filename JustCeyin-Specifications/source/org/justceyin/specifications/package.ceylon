
"Package contains classes for defining behavior-driven development style specifications.
 
 Two styles of specification are supported by this package: imperative and declarative.
 
 Imperative Specifications
   * Inherit from `ImperativeSpecification.
   * Implement a number of test methods, each taking a callable outcomes parameter.
   * Each test method should call outcomes with one or more expectations, generally started by `expect(..)...`
   * Define an actual `tests` member that collects the test methods into a sequence. 
     (Subject to change when Ceylon implements annotations)
 
 Declarative Specifications"
by "Martin E. Nordberg III"
shared package org.justceyin.specifications;
