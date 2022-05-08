import Combine
import Foundation

public enum NetworkClientError: Error {
    case failedToGenerateURL(String)
    case unrecognizedError
    case externalError(CommonError)
    case invalidStatusCode(Int)
    case noInternetConnection
}

public protocol NetworkClient {
    func get<Response: Decodable>(
        _ responseType: Response.Type,
        path: String,
        queryItems: [URLQueryItem]
    ) -> AnyPublisher<Response, Error>
}
