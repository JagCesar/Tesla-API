import Foundation

public struct HVACRequest: RequestProtocol {
    public enum HVACState {
        case on
        case off
    }
    typealias CompletionType = Bool
    var path: String {
        switch state {
        case .on:
            return "/api/1/vehicles/\(vehicleIdentifier)/command/auto_conditioning_start"
        case .off:
            return "/api/1/vehicles/\(vehicleIdentifier)/command/auto_conditioning_stop"
        }
    }
    let method = WebRequest.RequestMethod.post
    let accessToken: String
    let vehicleIdentifier: String
    let state: HVACState

    public init(accessToken: String, vehicleIdentifier: String, state: HVACState) {
        self.accessToken = accessToken
        self.vehicleIdentifier = vehicleIdentifier
        self.state = state
    }

    public func execute(completion: @escaping (Result<Bool>) -> Void) {
        WebRequest.request(
            path: path,
            method: method,
            accessToken: accessToken) { response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                } else if let response = response as? [String: [String: Any]],
                    let resultBool = response["response"]?["result"] as? Bool {
                    DispatchQueue.main.async {
                        completion(Result.success(resultBool))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(Result.failure(APIError()))
                    }
                }
        }
    }
}
