import ballerina/time;

type Model record {|
    @Unique
    @AutoIncrement
    int id = -1; // This value will be updated to the correct value once persisted

    time:Utc created_at?;
    time:Utc modified_at?;

    //This is used for soft delete functionality. To preserve data in order to recover if needed
    time:Utc deleted_at?;
|};

