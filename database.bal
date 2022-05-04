import ballerina/jballerina.java;

// This method would be responsible for both insert and update operations
isolated function persist(record {} 'object) returns error? {
}

isolated function retrieveById(int id, typedesc<record {}> modelType = <>) returns modelType|error = @java:Method {
    'class: "",
    name: ""
} external;

isolated function retrieve(Filter|FilterQuery? filter = (), typedesc<record {}> modelType = <>) returns stream<modelType|error?>  = @java:Method {
    'class: "",
    name: ""
} external;

isolated function retrieveOne(Filter|FilterQuery? filter = (), typedesc<record {}> modelType = <>) returns modelType|error  = @java:Method {
    'class: "",
    name: ""
} external;

isolated function delete(record {} 'object) returns error? {
}
