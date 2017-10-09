import Foundation

public class Token {
    public let accessToken: String
    let type: String
    let expires: Date
    let created: Date
    let refreshToken: String

    init(dictionary: [String: AnyObject]) throws {
        guard let accessToken = dictionary["access_token"] as? String,
            let type = dictionary["token_type"] as? String,
            let expiresInteger = dictionary["expires_in"] as? Double,
            let createdInteger = dictionary["created_at"] as? Double,
            let refreshToken = dictionary["refresh_token"] as? String else {
                throw APIError()
        }
        self.accessToken = accessToken
        self.type = type
        self.expires = Date(timeIntervalSince1970: expiresInteger + createdInteger)
        self.created = Date(timeIntervalSince1970: createdInteger)
        self.refreshToken = refreshToken
    }
}
