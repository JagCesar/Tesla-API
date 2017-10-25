import Foundation

public struct ChargeStateRequest: RequestProtocol {
    typealias CompletionType = ChargeState
    var path: String {
        return "/api/1/vehicles/\(vehicleIdentifier)/data_request/charge_state"
    }
    let method = WebRequest.RequestMethod.get
    let accessToken: String
    let vehicleIdentifier: Int

    public init(accessToken: String, vehicleIdentifier: Int) {
        self.accessToken = accessToken
        self.vehicleIdentifier = vehicleIdentifier
    }

    public func execute(completion: @escaping (Result<ChargeState>) -> Void) {
        WebRequest.request(
            path: path,
            method: method,
            accessToken: accessToken) { response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                } else if let response = response as? [String: [String: Any]],
                    let dictionary = response["response"] {
                    DispatchQueue.main.async {
                        completion(Result.success(ChargeState(dictionary: dictionary)))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(Result.failure(APIError()))
                    }
                }
        }
    }
}
