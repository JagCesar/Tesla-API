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
        let params = [
            "email": username,
            "password": password,
            "grant_type": grantType,
            "client_id": clientIdentifier,
            "client_secret": clientSecret
        ]
        WebRequest.request(
            path: path,
            method: method,
            params: params) { response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        guard let responseDictionary = response as? [String: AnyObject] else {
                            completion(Result.failure(APIError()))
                            return
                        }
                        do {
                            let result = try Result.success(Token(dictionary: responseDictionary))
                            completion(result)
                        } catch {
                            completion(Result.failure(error))
                        }
                    }
                }
        }
    }
}
