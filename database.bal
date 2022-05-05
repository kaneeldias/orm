import ballerina/jballerina.java;

// This method would be responsible for both insert and update operations
isolated function persist(record {} 'object) returns error? {
}

isolated function retrieveById(int id, typedesc<record {}> modelType = <>) returns modelType|error = @java:Method {
    'class: "",
    name: ""
} external;

isolated function retrieve(typedesc<record {}> modelType = <>, FilterQuery? fq = (), *Filter filter) returns stream<modelType|error?>  = @java:Method {
    'class: "",
    name: ""
} external;

isolated function retrieveOne(typedesc<record {}> modelType = <>, FilterQuery? fq = (), *Filter filter) returns modelType|error  = @java:Method {
    'class: "",
    name: ""
} external;

isolated function delete(record {} 'object) returns error? {
}
