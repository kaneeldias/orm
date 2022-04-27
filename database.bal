import ballerina/jballerina.java;

// This method would be responsible for both insert and update operations
isolated function persist(record {} 'object) returns error? {
}

isolated function retrieveById(int id, typedesc<record {}> modelType = <>) returns record {}|error {}

isolated function retrieve(typedesc<record {}> modelType = <>, *Filters filters) returns stream<record {}|error?> {}

isolated function retrieveOne(typedesc<record {}> modelType = <>, *Filters filters) returns record {}|error {}

isolated function delete(record {} 'object) returns error? {
}

public type Filters record {|
    int|string|Comparator...;
|};

public type Comparator [ComparisonOperator, anydata];

enum ComparisonOperator {
    GT,
    LT,
    GTE,
    LTE,
    LIKE,
    IN
}