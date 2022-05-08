import Foundation

public struct EndpointConfigurationImpl: EndpointConfiguration {
    public func url(
        applying path: String,
        queryItems: [URLQueryItem]
    ) -> URL? {
        var components = URLComponents()
        components.scheme = "https"
        components.host = Environment.host
        components.path = "\(path)"
        components.queryItems = [
            URLQueryItem(
                name: "api_key",
                value: "093e10c4b1325e4370dcb391dc76a4a9"
            ),
        ]
        components.queryItems?.append(contentsOf: queryItems)
        return components.url
    }

    public func configureRequest(
        url: URL,
        method: HTTPMethod,
        body: Data?
    ) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = body
        return request
    }
}
