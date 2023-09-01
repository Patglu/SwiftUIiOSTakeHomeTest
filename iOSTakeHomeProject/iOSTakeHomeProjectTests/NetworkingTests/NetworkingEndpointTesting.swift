

import XCTest
@testable import iOSTakeHomeProject

final class NetworkingEndpointTesting: XCTestCase {


    func test_WithPeopleEndPointRequestIsValid(){
        let endpoint = Endpoint.people(page: 1)
        
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users")
        XCTAssertEqual(endpoint.methodType, .GET, "The method Type should be GET")
        XCTAssertEqual(endpoint.queryItems, ["page":"1"], "The query items should be page: 1")
        
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?page=1&delay=2", "The genereated URL doesn't match the endpoint")
    }
    
    func test_WithDetailEndpointRequestIsValid(){
        let userID = 1
        let endpoint = Endpoint.detail(id: userID)
        
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users/\(userID)", "The path should be /api/users")
        XCTAssertEqual(endpoint.methodType, .GET, "The method Type should be GET")
        XCTAssertNil(endpoint.queryItems, "The query items should be nil")
        
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users/\(userID)?delay=2", "The genereated URL doesn't match the endpoint")
    }
    
    func test_WithCreateEndpointRequestIsValid(){
        let endpoint = Endpoint.create(submissionData: nil)
        
        XCTAssertEqual(endpoint.host, "reqres.in", "The host should be reqres.in")
        XCTAssertEqual(endpoint.path, "/api/users", "The path should be /api/users")
        XCTAssertEqual(endpoint.methodType, .POST(data: nil), "The method Type should be POST")
        XCTAssertNil(endpoint.queryItems, "The query items should be nil")
        
        XCTAssertEqual(endpoint.url?.absoluteString, "https://reqres.in/api/users?delay=2", "The genereated URL doesn't match the endpoint")
        
    }
    
}
