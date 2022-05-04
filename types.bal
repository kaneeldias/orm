import ballerina/lang.'object as obj;

public type FilterQuery distinct object {
    *obj:RawTemplate;
    public (string[] & readonly) strings;
    public Value[] insertions;
};

public type Value string|int|boolean|float|decimal;

public type Filter record {|
    [Filter...] or?;
    FilterCriteria...;
|};

public type FilterCriteria Value|Comparator;

public type Comparator [ComparisonOperator, Value];

enum ComparisonOperator {
    GT,
    LT,
    GTE,
    LTE,
    LIKE
}

public type OrFilter record {|
    Filter...;
|};
