import Foundation

public extension Error {
    var asAPIError: APIError {
        switch self as? NetworkClientError {
        case let .externalError(error):
            return APIError(statusCode: error.statusCode)
                ?? .other(self)
        case .failedToGenerateURL,
             .invalidStatusCode,
             .noInternetConnection,
             .unrecognizedError,
             .none:
            return .other(self)
        }
    }
}

public enum APIErrorCode: Int {
    case invalidAPIKey = 7
    case incorrectResource = 34
}

public enum APIError: Error {
    case incorrectResource
    case invalidAPIKey
    case other(Error)
}

public extension APIError {
    init?(statusCode: Int?) {
        switch statusCode {
        case APIErrorCode.incorrectResource.rawValue:
            self = .incorrectResource
        case APIErrorCode.invalidAPIKey.rawValue:
            self = .invalidAPIKey
        default:
            return nil
        }
    }
}
