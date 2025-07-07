// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

public type Employee record {|
    readonly string employeeId;
    string firstName;
    string lastName;
    string email;
    string phone;
    string jobTitle;
    string departmentDepartmentId;
|};

public type EmployeeOptionalized record {|
    string employeeId?;
    string firstName?;
    string lastName?;
    string email?;
    string phone?;
    string jobTitle?;
    string departmentDepartmentId?;
|};

public type EmployeeWithRelations record {|
    *EmployeeOptionalized;
    DepartmentOptionalized department?;
|};

public type EmployeeTargetType typedesc<EmployeeWithRelations>;

public type EmployeeInsert Employee;

public type EmployeeUpdate record {|
    string firstName?;
    string lastName?;
    string email?;
    string phone?;
    string jobTitle?;
    string departmentDepartmentId?;
|};

public type Department record {|
    readonly string departmentId;
    string name;
    string description;

|};

public type DepartmentOptionalized record {|
    string departmentId?;
    string name?;
    string description?;
|};

public type DepartmentWithRelations record {|
    *DepartmentOptionalized;
    EmployeeOptionalized[] employees?;
|};

public type DepartmentTargetType typedesc<DepartmentWithRelations>;

public type DepartmentInsert Department;

public type DepartmentUpdate record {|
    string name?;
    string description?;
|};

