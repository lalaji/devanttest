import ballerina/io;
import fileintegration.store;

final store:Client sClient = check new();


public function main() returns error? {
store:EmployeeInsert employee1 = {
      firstName: "John",
      lastName: "Doe",
      email: "john.doe@example.com",
      employeeId: "E001",
      jobTitle: "Software Engineer",
      phone: "123-456-7890",
      departmentDepartmentId: "D001"
};


   string[] employeeIds = check sClient->/employees.post([employee1]);
   io:println("Inserted employee id: " + employeeIds[0]);
}