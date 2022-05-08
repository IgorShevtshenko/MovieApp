import Combine
import Foundation

public enum HTTPMethod: String {
    case get = "GET"
    case put = "PUT"
    case post = "POST"
    case patch = "PATCH"
    case delete = "DELETE"
}

public struct NetworkClientImpl: NetworkClient {
    private let endpointConfiguration: EndpointConfiguration
    private let requestSerializer: RequestSerializer

    public init(
        endpointConfiguration: EndpointConfiguration,
        requestSerializer: RequestSerializer
    ) {
        self.endpointConfiguration = endpointConfiguration
        self.requestSerializer = requestSerializer
    }

    public func get<ResponseBody: Decodable>(
        _: ResponseBody.Type,
        path: String,
        queryItems: [URLQueryItem]
    ) -> AnyPublisher<ResponseBody, Error> {
        execute(method: .get, path: path, queryItems: queryItems)
            .decode(type: ResponseBody.self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }

    public func execute(
        method: HTTPMethod,
        path: String,
        queryItems: [URLQueryItem] = [],
        body: Data? = nil
    ) -> AnyPublisher<Data, Error> {
        guard let url = endpointConfiguration.url(applying: path, queryItems: queryItems) else {
            return Fail(error: NetworkClientError.failedToGenerateURL(path)).eraseToAnyPublisher()
        }
        let request = requestSerializer.configureContentType(
            on: endpointConfiguration.configureRequest(
                url: url,
                method: method,
                body: body
            )
        )
        return URLSession.shared
            .dataTaskPublisher(for: request)
            .tryMap { try $1.validate(data: $0) }
            .receive(on: DispatchQueue.main)
            .handleEvents(
                receiveOutput: { _ in print("StatusCode: \(method.rawValue) 200 for \(path)") },
                receiveCompletion: { completion in
                    if case let .failure(error) = completion {
                        print("Client Error: \(error)")
                    }
                }
            )
            .eraseToAnyPublisher()
    }
}

private extension URLResponse {
    func validate(data: Data) throws -> Data {
        guard let response = self as? HTTPURLResponse else {
            fatalError("Could not downcast response")
        }
        guard (200 ... 299).contains(response.statusCode) else {
            print("NetworkClient received negative statusCode: \(response)")
            guard let errorBody = try? JSONDecoder().decode(CommonError.self, from: data) else {
                throw NetworkClientError.invalidStatusCode(response.statusCode)
            }
            throw NetworkClientError.externalError(errorBody)
        }
        return data
    }
}
