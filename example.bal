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

    check persist(emp); // This should run an `INSERT` query and would auto-generate and populate the values for id, created, last_modified fields

    int id = emp.id; // This should give the auto-generated ID value

    // Option 1 - by ID
    // `SELECT * FROM Employees WHERE id = 3`
    Employee _ = check retrieveById(id);

    // Option 2 -  search by field
    // `SELECT * FROM Employees WHERE name = 'Kaneel Dias' LIMIT 1`
    Employee _ = check retrieveOne({"name": "Kaneel Dias"});

    // Option 3 - search by multiple fields
    // `SELECT * FROM Employees WHERE name = 'Kaneel Dias' AND salary > 300 LIMIT 1`
    Employee _ = check retrieveOne({
        "name": "Kaneel Dias",
        "salary": [GT, 300]
    });

    // Option 4 - as stream
    // `SELECT * FROM Employees WHERE name = 'Kaneel Dias'`
    stream<Employee|error?> _ = retrieve({"name": "Kaneel Dias"});

    // Option 5 - retrieve all
    // `SELECT * FROM Employees`
    stream<Employee|error?> _ = retrieve();

    // Option 6 - select OR
    // `SELECT * FROM Employees WHERE name = 'Kaneel Dias' OR salary > 300`
    stream<Employee|error?> _ = retrieve({
        or: [
            { "name": "Kaneel Dias" },
            { "salary": [GT, 300] }
        ]
    });

    // Option 7 - Advanced query
    // `SELECT * FROM Employees WHERE (name = 'Kaneel Dias' AND salary > 300) OR (name = 'Kaneel Dias2' AND salary > 400)`
    stream<Employee|error?> _ = retrieve({
        or: [
            { "name": "Kaneel Dias", "salary": [GT, 300] },
            { "name": "Kaneel Dias2", "salary": [GT, 400] }
        ]
    });

    // Option 8 - Advanced query 2
    // `SELECT * FROM Employees WHERE (salary < 300 OR  salary > 400) AND name = 'Kaneel Dias2'`
    stream<Employee|error?> _ = retrieve({
        or: [
            { "salary": [LT, 300] },
            { "salary": [GT, 400] }
        ],
        "name": "Kaneel Dias"
    });

    emp.name = "Kaneel Dias 2";
    check persist(emp); // This should run an `UPDATE` query
}
