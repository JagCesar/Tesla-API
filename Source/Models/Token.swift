import Foundation

public class TokenResponse: Codable {
    let response: Token
}

public struct Token: Codable {
    public let accessToken: String
    public let type: String
    public let expires: Date
    public let created: Date
    public let refreshToken: String
}
