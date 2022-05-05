import ballerina/lang.'object as obj;

public type FilterQuery distinct object {
    *obj:RawTemplate;
    public (string[] & readonly) strings;
    public Value[] insertions;
};

public type Value string|int|boolean|float|decimal;

public type Filter record {|
    never modelType?;
    never fq?;
    anydata...;
|};
