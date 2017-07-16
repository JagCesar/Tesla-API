import Foundation

public class TeslaAPI {
    public static let sharedInstance = TeslaAPI()

    private init() {

    }

    public func authenticate(username: String, password: String, completion: @escaping (_ success: Bool, _ tokenDictionary: [String: AnyObject]?) -> Void) {
        WebRequest.login(email: username, password: password) { success, tokenDictionary in
            completion(success, tokenDictionary)
        }
    }
}
