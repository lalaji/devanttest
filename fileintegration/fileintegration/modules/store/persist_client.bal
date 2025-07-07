// AUTO-GENERATED FILE. DO NOT MODIFY.

// This file is an auto-generated file by Ballerina persistence layer for model.
// It should not be modified by hand.

import ballerina/jballerina.java;
import ballerina/persist;
import ballerinax/persist.inmemory;

const EMPLOYEE = "employees";
const DEPARTMENT = "departments";
final isolated table<Employee> key(employeeId) employeesTable = table [];
final isolated table<Department> key(departmentId) departmentsTable = table [];

public isolated client class Client {
    *persist:AbstractPersistClient;

    private final map<inmemory:InMemoryClient> persistClients;

    public isolated function init() returns persist:Error? {
        final map<inmemory:TableMetadata> metadata = {
            [EMPLOYEE]: {
                keyFields: ["employeeId"],
                query: queryEmployees,
                queryOne: queryOneEmployees
            },
            [DEPARTMENT]: {
                keyFields: ["departmentId"],
                query: queryDepartments,
                queryOne: queryOneDepartments,
                associationsMethods: {"employees": queryDepartmentEmployees}
            }
        };
        self.persistClients = {
            [EMPLOYEE]: check new (metadata.get(EMPLOYEE).cloneReadOnly()),
            [DEPARTMENT]: check new (metadata.get(DEPARTMENT).cloneReadOnly())
        };
    }

    isolated resource function get employees(EmployeeTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get employees/[string employeeId](EmployeeTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post employees(EmployeeInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach EmployeeInsert value in data {
            lock {
                if employeesTable.hasKey(value.employeeId) {
                    return persist:getAlreadyExistsError("Employee", value.employeeId);
                }
                employeesTable.put(value.clone());
            }
            keys.push(value.employeeId);
        }
        return keys;
    }

    isolated resource function put employees/[string employeeId](EmployeeUpdate value) returns Employee|persist:Error {
        lock {
            if !employeesTable.hasKey(employeeId) {
                return persist:getNotFoundError("Employee", employeeId);
            }
            Employee employee = employeesTable.get(employeeId);
            foreach var [k, v] in value.clone().entries() {
                employee[k] = v;
            }
            employeesTable.put(employee);
            return employee.clone();
        }
    }

    isolated resource function delete employees/[string employeeId]() returns Employee|persist:Error {
        lock {
            if !employeesTable.hasKey(employeeId) {
                return persist:getNotFoundError("Employee", employeeId);
            }
            return employeesTable.remove(employeeId).clone();
        }
    }

    isolated resource function get departments(DepartmentTargetType targetType = <>) returns stream<targetType, persist:Error?> = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "query"
    } external;

    isolated resource function get departments/[string departmentId](DepartmentTargetType targetType = <>) returns targetType|persist:Error = @java:Method {
        'class: "io.ballerina.stdlib.persist.inmemory.datastore.InMemoryProcessor",
        name: "queryOne"
    } external;

    isolated resource function post departments(DepartmentInsert[] data) returns string[]|persist:Error {
        string[] keys = [];
        foreach DepartmentInsert value in data {
            lock {
                if departmentsTable.hasKey(value.departmentId) {
                    return persist:getAlreadyExistsError("Department", value.departmentId);
                }
                departmentsTable.put(value.clone());
            }
            keys.push(value.departmentId);
        }
        return keys;
    }

    isolated resource function put departments/[string departmentId](DepartmentUpdate value) returns Department|persist:Error {
        lock {
            if !departmentsTable.hasKey(departmentId) {
                return persist:getNotFoundError("Department", departmentId);
            }
            Department department = departmentsTable.get(departmentId);
            foreach var [k, v] in value.clone().entries() {
                department[k] = v;
            }
            departmentsTable.put(department);
            return department.clone();
        }
    }

    isolated resource function delete departments/[string departmentId]() returns Department|persist:Error {
        lock {
            if !departmentsTable.hasKey(departmentId) {
                return persist:getNotFoundError("Department", departmentId);
            }
            return departmentsTable.remove(departmentId).clone();
        }
    }

    public isolated function close() returns persist:Error? {
        return ();
    }
}

isolated function queryEmployees(string[] fields) returns stream<record {}, persist:Error?> {
    table<Employee> key(employeeId) employeesClonedTable;
    lock {
        employeesClonedTable = employeesTable.clone();
    }
    table<Department> key(departmentId) departmentsClonedTable;
    lock {
        departmentsClonedTable = departmentsTable.clone();
    }
    return from record {} 'object in employeesClonedTable
        outer join var department in departmentsClonedTable on ['object.departmentDepartmentId] equals [department?.departmentId]
        select persist:filterRecord({
                                        ...'object,
                                        "department": department
                                    }, fields);
}

isolated function queryOneEmployees(anydata key) returns record {}|persist:NotFoundError {
    table<Employee> key(employeeId) employeesClonedTable;
    lock {
        employeesClonedTable = employeesTable.clone();
    }
    table<Department> key(departmentId) departmentsClonedTable;
    lock {
        departmentsClonedTable = departmentsTable.clone();
    }
    from record {} 'object in employeesClonedTable
    where persist:getKey('object, ["employeeId"]) == key
    outer join var department in departmentsClonedTable on ['object.departmentDepartmentId] equals [department?.departmentId]
    do {
        return {
            ...'object,
            "department": department
        };
    };
    return persist:getNotFoundError("Employee", key);
}

isolated function queryDepartments(string[] fields) returns stream<record {}, persist:Error?> {
    table<Department> key(departmentId) departmentsClonedTable;
    lock {
        departmentsClonedTable = departmentsTable.clone();
    }
    return from record {} 'object in departmentsClonedTable
        select persist:filterRecord({
                                        ...'object
                                    }, fields);
}

isolated function queryOneDepartments(anydata key) returns record {}|persist:NotFoundError {
    table<Department> key(departmentId) departmentsClonedTable;
    lock {
        departmentsClonedTable = departmentsTable.clone();
    }
    from record {} 'object in departmentsClonedTable
    where persist:getKey('object, ["departmentId"]) == key
    do {
        return {
            ...'object
        };
    };
    return persist:getNotFoundError("Department", key);
}

isolated function queryDepartmentEmployees(record {} value, string[] fields) returns record {}[] {
    table<Employee> key(employeeId) employeesClonedTable;
    lock {
        employeesClonedTable = employeesTable.clone();
    }
    return from record {} 'object in employeesClonedTable
        where 'object.departmentDepartmentId == value["departmentId"]
        select persist:filterRecord({
                                        ...'object
                                    }, fields);
}

