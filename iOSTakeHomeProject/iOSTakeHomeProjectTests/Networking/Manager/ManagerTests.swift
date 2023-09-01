import XCTest
@testable import iOSTakeHomeProject

final class ManagerTests: XCTestCase {

    private var session: URLSession!
    private var url: URL!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        url = URL(string: "https:reqres.in/users")
        
        let configuration = URLSessionConfiguration.ephemeral
        configuration.protocolClasses = [MockURLSessionsProtocol.self]
        session = URLSession(configuration: configuration)
    }
    
    override func tearDownWithError() throws {
        session = nil
        url = nil
    }
    
    func test_withSuccessfulResponseIsValid() async throws{
        guard let path = Bundle.main.path(forResource: "UsersStaticData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get the static users file")
            return
        }

        MockURLSessionsProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            
            return (response!, data)
        }
        
        let result = try await NetworkingManager.shared.request(session: session,
                                                       .people(page: 1),
                                                       type: UsersResponse.self)
        
        let staticJson = try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self)
        
        XCTAssertEqual(result, staticJson, "The returned response should be decoded properly")
    }
    
    func test_withSucessFulResponseWithVoidIsValid() async throws {
        MockURLSessionsProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            
            return (response!, nil)
        }
        
        _ = try await NetworkingManager.shared.request(session: session,
                                                       .people(page: 1))
    }
    
    func test_WithUnsuccessfulResponseCodeIsInvalidRangeisInvalid() async {
        
        MockURLSessionsProtocol.loadingHandler = {
            let response = HTTPURLResponse(
                url: self.url,
                statusCode: 400,
                httpVersion: nil,
                headerFields: nil)
            
            return (response!,nil)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session, .people(page: 1), type: UsersResponse.self)
        } catch {
            if let error = error as? NetworkingManager.NetworkingError {
                XCTAssertEqual(error, NetworkingManager.NetworkingError.invalidStatusCode(statusCode: 400))
            } else {
                XCTFail("Got the wrong type of error expecting Networking Manager NetworkingError")
            }
        }

    }
    
    func test_withUncesscfulResponseWithInvalidJsonIsInvalid() async {
        guard let path = Bundle.main.path(forResource: "UsersStaticData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to get static user file")
            return
        }
        
        MockURLSessionsProtocol.loadingHandler = {
            let response = HTTPURLResponse(url: self.url,
                                           statusCode: 200,
                                           httpVersion: nil,
                                           headerFields: nil)
            
            return (response!, data)
        }
        
        do {
            _ = try await NetworkingManager.shared.request(session: session, .people(page: 1), type: UsersResponse.self)
        } catch {
            if error  is NetworkingManager.NetworkingError {
                XCTFail("This should be a system decoding error")
            } else {
                
            }
        }
        
    }
}
