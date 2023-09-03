import Foundation
@testable import iOSTakeHomeProject

final class NetworkCreateSuccessMock {

    class NetworkingManagerCreateSuccessMock: NetworkingManagerimplementation {
        func request<T>(session: URLSession, _ endpoint: iOSTakeHomeProject.Endpoint, type: T.Type) async throws -> T where T : Decodable, T : Encodable {
            return Data() as! T
        }
        
        func request(session: URLSession, _ endpoint: iOSTakeHomeProject.Endpoint) async throws {}
    }

}
