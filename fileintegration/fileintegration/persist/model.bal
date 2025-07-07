import ballerina/persist as _;

public type Employee record {|
    readonly string employeeId;
    string firstName;
    string lastName;
    string email;
    string phone;
    string jobTitle;
    Department department; // 1-n relationship
|};

public type Department record {|
   readonly string departmentId;
   string name;
   string description;
   Employee[] employees;
|};
