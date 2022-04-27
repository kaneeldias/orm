public type Employee record {|
    *Model;
    string name;
    Address address;
    decimal salary;
|};

public type Address record {|
    string line1;
    string line2;
    string city;
    string country;
    int zip_code;
|};

public function main() returns error? {

    Employee emp = {
        name: "Kaneel Dias",
        address: {
            line1: "dsgdfgf",
            line2: "dfgfdgf",
            city: "dfgfdg",
            country: "dfgdf",
            zip_code: 11111
        },
        salary: 354.45
    };

    check persist(emp);

    int id = emp.id;

    // Option 1
    record {} emp_retrieved1 = check retrieveById(id);

    // Option 2
    record {} emp_retrieved2 = check retrieveOne(Employee, {"name": "Kaneel Dias"});

    // Option 3
    record {} emp_retrieved3 = check retrieveOne(Employee, {
        "name": "Kaneel Dias",
        "salary": [GT, 300]
    });

    // Option 4
    stream<Employee|error?> empStream = retrieve(Employee, {"name": "Kaneel Dias"});
}
