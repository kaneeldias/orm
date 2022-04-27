public type AutoIncrementConfig record {|
    int startValue = 1;
    int increment = 1;
|};

public annotation true Unique on record field;
public annotation AutoIncrementConfig AutoIncrement on record field;
