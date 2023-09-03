import Foundation
@testable import iOSTakeHomeProject

class NetworkingManagerUserResponseSuccessMock: NetworkingManagerimplementation{
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        return try StaticJSONMapper.decode(file: "UsersStaticData", type: UsersResponse.self) as! T
    }
    
    func request(session: URLSession, _ endpoint: iOSTakeHomeProject.Endpoint) async throws {
        
    }
    
    
}
