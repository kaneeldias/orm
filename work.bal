import ballerina/time;

type Workplace record {|
    *Table;
    string name;
    string address;
    string phone;

    // Has many
    // Foreign key annotation not necessary here?
    Worker[] workers?;
|};

type Worker record {|
    *Table;
    string name;
    time:Date dob;
    int workplace_id = -1; // Ideally, this should not be necessary

    // Belongs to
    // Issues: is this annotation necessary? Can't we infer?
    @ForeignKey {
        key: "workplace_id",
        reference: "id",
        onDelete: "DELETE"
    }
    Workplace workplace?;

    @ForeignKey {
        key: "worker_id",
        reference: "recipe_id",
        many2many: "worker_recipe"
    }
    Recipe[] recipes?;
|};

function insertWorker() returns error? {
    Client db = check new();

    Worker john = {
        name: "John",
        dob: {
            year: 1996,
            month: 12,
            day: 15
        },
        workplace: {
            name: "WSO2",
            address: "Colombo",
            phone: "011-271-9938"
        }
    };

    // Note: the workplace record needs to be persisted as well (nested)
    _ = check db->insert(john);

    // Issues: it is possible to create a worker without a workplace. Shouldn't this be blocked?
}


function insertWorkplace() returns error? {
    Client db = check new();

    Worker tom = {
        name: "Tom", 
        dob: {
            year: 1993,
            month: 1,
            day: 3
        }
    };

    Workplace wso2 = {
        name: "WSO2",
        address: "Colombo",
        phone: "011-273-2222",
        workers: [tom]
    };

    Workplace wso3 = {
        name: "WSO2",
        address: "Colombo",
        phone: "011-273-2222",
        workers: [tom]
    };

    // Note: the worker record needs to be persisted as well (nested)
    // Issues: how do we determine whether tom is already in the database or not? From the id/primary key field?
    _ = check db->insert(wso2);
    _ = check db->insert(wso3);

    // Issues: it is possible to create a workplace without any workers. Shouldn't this be blocked?

    // Note: Have insert as two APIs (with and without associations) 
}
function getAll() returns error? {
    Client db = check new();
    stream<Workplace, Error?> _ = db->get(Workplace);
    stream<Worker, Error?> _ = db->get(Worker);
}

function deleteAll() returns error? {
    Client db = check new();

    // Note: this should delete the child workers as well
    _ = check db->delete(Workplace);
}

function getWorker() returns Worker|error {
    Client db = check new();

    // Note: this would not fetch the workplace details
    // Issues: can we check whether the `worker` record contains the fields mentioned in the filter at compile time?
    Worker john = check db->getRecord(name = "john", age = 324);
    return john;
}

function getWorkerWithAssociation() returns Worker|error {
    Client db = check new();

    // New: API to fetch a single record with association
    // Issues: how should we handle chaining and cycles? - only one level down
    // Issues: should be able to specify which fields to eagerly load?
    // Suggestion:
    //      john.workplace = check db->getRecord(Workplace, {"id", "workplace_id"});
    Worker john = check db->getRecordWithAssociation(Worker, {"name": "john"});
    return john;
}

function deleteWorker() returns error? {
    Client db = check new();
    Worker john = check getWorker();

    // Issue: it should be possible to do `db->delete(john)`
    _ = check db->delete(Worker, name = "john", age = 34);
    _ = check db->delete(Worker, john); // Must be a typed record

    // Note: in this case, we should not delete the parent workplace
}
