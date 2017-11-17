import Foundation

public class TokenResponse: Codable {
    let response: Token
}

public class Token: Codable {
    public let accessToken: String
    public let type: String
    public let expires: Date
    public let created: Date
    public let refreshToken: String

    private enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case type = "token_type"
        case expires = "expires_in"
        case created = "created_at"
        case refreshToken = "refresh_token"
    }
}
