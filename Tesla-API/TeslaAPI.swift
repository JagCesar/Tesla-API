import Foundation

public class TeslaAPI {

    public enum Result<T> {
        case Success(T)
        case Failure(NSError)
    }

    public var baseURLString: String {
        get {
            return WebRequest.baseURLString
        }
        set {
            WebRequest.baseURLString = newValue
        }
    }

    public static let sharedInstance = TeslaAPI()

    private init() {

    }

    public func authenticate(username: String, password: String, completion: @escaping (_ success: Bool, _ response: [String: AnyObject]?) -> Void) {
        let loginObject = [
            "email": username,
            "password": password,
            "grant_type": "password",
            "client_id": "81527cff06843c8634fdc09e8ac0abefb46ac849f38fe1e431c2ef2106796384",
            "client_secret": "c7257eb71a564034f9419ee651c7d0e5f7aa6bfbd18bafb5c5c033b093bb2fa3"]

        WebRequest.post(
            request: WebRequest.clientURLRequest(
                path: "oauth/token",
                params: loginObject as Dictionary<String, AnyObject>)) { success, response -> () in
                    DispatchQueue.main.async {
                        if success {
                            completion(true, response as? [String: AnyObject])
                        } else {
                            completion(false, nil)
                        }
                    }
        }
    }

    public func listVehicles(accessToken: String, completion: @escaping (_ success: Bool, _ response: [String: AnyObject?]?) -> Void) {
        WebRequest.get(
            request: WebRequest.clientURLRequest(
                path: "api/1/vehicles",
                accessToken: accessToken)) { success, response in
                    if success {
                        completion(true, response as? [String: AnyObject?])
                    } else {
                        completion(false, nil)
                    }
        }
    }
}
