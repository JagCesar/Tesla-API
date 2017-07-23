import Foundation

public class TeslaAPI {

    public enum Result<T> {
        case Success(T)
        case Failure(Error)
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

    public func authenticate(
        username: String,
        password: String,
        completion: @escaping (_ result: Result<Token>) -> Void) {
        let loginObject = [
            "email": username,
            "password": password,
            "grant_type": "password",
            "client_id": "81527cff06843c8634fdc09e8ac0abefb46ac849f38fe1e431c2ef2106796384",
            "client_secret": "c7257eb71a564034f9419ee651c7d0e5f7aa6bfbd18bafb5c5c033b093bb2fa3"]

        WebRequest.post(
            request: WebRequest.clientURLRequest(
                path: "oauth/token",
                params: loginObject as [String: AnyObject])) { response, error -> () in
                    if let error = error {
                        DispatchQueue.main.async {
                            completion(Result.Failure(error))
                        }
                    } else {
                        guard let responseDictionary = response as? [String: AnyObject] else {
                            DispatchQueue.main.async {
                                completion(Result.Failure(APIError()))
                            }
                            return
                        }
                        do {
                            let result = try Result.Success(Token(dictionary: responseDictionary))
                            DispatchQueue.main.async {
                                completion(result)
                            }
                        } catch let error {
                            DispatchQueue.main.async {
                                completion(Result.Failure(error))
                            }
                        }
                    }
        }
    }

    public func listVehicles(accessToken: String, completion: @escaping (Result<[Vehicle]>) -> Void) {
        WebRequest.get(
            request: WebRequest.clientURLRequest(
                path: "api/1/vehicles",
                accessToken: accessToken)) { response, error in
                    if let error = error {
                        DispatchQueue.main.async {
                            completion(Result.Failure(error))
                        }
                    } else {
                        let response = response!["response"] as! [[String: AnyObject]]
                        let vehicles = response.flatMap { return Vehicle(dictionary: $0) }
                        DispatchQueue.main.async {
                            completion(Result.Success(vehicles))
                        }
                    }
        }
    }
}
