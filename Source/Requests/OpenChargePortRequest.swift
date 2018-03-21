import Foundation

public struct OpenChargePortRequest: RequestProtocol {
    typealias CompletionType = Bool
    var path: String {
        return "/api/1/vehicles/\(vehicleIdentifier)/command/charge_port_door_open"
    }
    let method = WebRequest.RequestMethod.post
    let accessToken: String
    let vehicleIdentifier: String

    public init(accessToken: String, vehicleIdentifier: String) {
        self.accessToken = accessToken
        self.vehicleIdentifier = vehicleIdentifier
    }

    public func execute(completion: @escaping (Result<Bool>) -> Void) {
        WebRequest.request(
            path: path,
            method: method,
            accessToken: accessToken) { response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(Result.failure(error))
                    } else if let response = response as? [String: [String: Any]],
                        let resultBool = response["response"]?["result"] as? Bool {
                        completion(Result.success(resultBool))
                    } else {
                        completion(Result.failure(APIError()))
                    }
                }
        }
    }
}
