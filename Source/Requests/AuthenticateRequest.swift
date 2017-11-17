import Foundation

public struct AuthenticateRequest: RequestProtocol {
    typealias CompletionType = Token
    let path = "/oauth/token"
    let method = WebRequest.RequestMethod.post
    private let clientIdentifier = "81527cff06843c8634fdc09e8ac0abefb46ac849f38fe1e431c2ef2106796384"
    private let clientSecret = "c7257eb71a564034f9419ee651c7d0e5f7aa6bfbd18bafb5c5c033b093bb2fa3"
    private let grantType = "password"
    private let username: String
    private let password: String

    public init(username: String, password: String) {
        self.username = username
        self.password = password
    }

    public func execute(completion: @escaping (Result<Token>) -> Void) {
        let params: [String: AnyObject] = [
            "email": username as NSString,
            "password": password as NSString,
            "grant_type": grantType as NSString,
            "client_id": clientIdentifier as NSString,
            "client_secret": clientSecret as NSString
            ]
        WebRequest.request(
            path: path,
            method: method,
            params: params) { data, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                } else if let data = data {
                    do {
                        let token = try JSONDecoder().decode(Token.self, from: data)
                        DispatchQueue.main.async {
                            completion(Result.success(token))
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completion(Result.failure(error))
                        }
                    }
                }
        }
    }
}
