//
//  NetworkingManagerCreateFailureMock.swift
//  iOSTakeHomeProjectTests
//
//  Created by Tunde Adegoroye on 25/08/2022.
//

#if DEBUG
import Foundation

class NetworkingManagerCreateFailureMock: NetworkingManagerimplementation {
    
    func request<T>(session: URLSession, _ endpoint: Endpoint, type: T.Type) async throws -> T where T : Decodable {
        return Data() as! T
    }
    
    func request(session: URLSession, _ endpoint: Endpoint) async throws {
        throw NetworkingManager.NetworkingError.invalidUrl
    }
}
#endif
