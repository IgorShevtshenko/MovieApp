import Foundation

public struct CommonError: LocalizedError {
    public let statusMessage: String?
    public let statusCode: Int?
}

extension CommonError: Decodable {
    enum CodingKeys: String, CodingKey {
        case statusMessage
        case statusCode
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        if
            let statusMessage = try? container.decode(String?.self, forKey: .statusMessage),
            let statusCode = try? container.decode(Int?.self, forKey: .statusCode)
        {
            self.statusMessage = statusMessage
            self.statusCode = statusCode
        } else {
            statusMessage = "Something went wrong"
            statusCode = nil
        }
    }
}
