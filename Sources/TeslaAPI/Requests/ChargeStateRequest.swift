import Foundation

public struct ChargeStateRequest: RequestProtocol {
    typealias CompletionType = ChargeState
    var path: String {
        return "/api/1/vehicles/\(vehicleIdentifier)/data_request/charge_state"
    }
    let method = WebRequest.RequestMethod.get
    let accessToken: String
    let vehicleIdentifier: String

    public init(accessToken: String, vehicleIdentifier: String) {
        self.accessToken = accessToken
        self.vehicleIdentifier = vehicleIdentifier
    }

    public func execute(completion: @escaping (Result<ChargeState>) -> Void) {
        WebRequest.request(
            path: path,
            method: method,
            accessToken: accessToken) { response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(Result.failure(error))
                    } else if let response = response as? [String: [String: Any]],
                        let dictionary = response["response"] {
                        completion(Result.success(ChargeState(dictionary: dictionary)))
                    } else {
                        completion(Result.failure(APIError()))
                    }
                }
        }
    }
}
