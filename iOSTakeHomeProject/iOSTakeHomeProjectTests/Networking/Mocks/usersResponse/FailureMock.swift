import Foundation
@testable import iOSTakeHomeProject

class NetworkManagerResponseFailureMock: NetworkingManagerimplementation {
    
    func request<T>(session: URLSession, _ endpoint: iOSTakeHomeProject.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
        throw NetworkingManager.NetworkingError.invalidUrl
    }
    
    func request(session: URLSession, _ endpoint: iOSTakeHomeProject.Endpoint) async throws {}
    
    
}
