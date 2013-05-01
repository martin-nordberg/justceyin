
import ceylon.time {
    Date, 
    today
}
import org.justceyin.expectations.constraints { 
    AdjectivalConstraint, 
    Constraint 
}

"Concrete object with constraints on dates."
by "Martin E. Nordberg III"
shared object aDate
    extends ComparableConstraints<Date>()
{
        
    "Returns a constraint that checks that a date is in the future."
    shared Constraint<Date> afterToday =>
        AdjectivalConstraint<Date>( (Date actualValue) => actualValue > today(), "after today" );

    "Returns a constraint that checks that a date is in the past."
    shared Constraint<Date> beforeToday =>
        AdjectivalConstraint<Date>( (Date actualValue) => actualValue < today(), "before today" );

    "Returns a constraint that checks that a date is today or in the future."
    shared Constraint<Date> onOrAfterToday =>
        AdjectivalConstraint<Date>( (Date actualValue) => actualValue >= today(), "on or after today" );

    "Returns a constraint that checks that a date is today or in the past."
    shared Constraint<Date> onOrBeforeToday =>
        AdjectivalConstraint<Date>( (Date actualValue) => actualValue <= today(), "on or before today" );

}
