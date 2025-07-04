import ballerina/io;
import ballerina/log;

public function main() returns error? {
    do {
        log:printInfo("Starting JSON to record conversion");
        
        // Read JSON from file
        json jsonData = check io:fileReadJson("data.json");
         log:printInfo("json"+jsonData.toJsonString());
        
        // Convert JSON to record
        HealthEvent recordData = check jsonData.cloneWithType();
        
        log:printInfo("Successfully converted JSON to record");
        log:printInfo(string `Record data: ${recordData.toString()}`);
        
        // You can now work with the strongly typed record
        string recordName = recordData.last_updated_on;
        string recordAge = recordData.version;
        log:printInfo(string `Name: ${recordName}`);
        log:printInfo(string `Age: ${recordAge}`);
        
    } on fail error e {
        log:printError("Error occurred while processing JSON file", 'error = e);
        return e;
    }
}