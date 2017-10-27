import Foundation

public struct LockRequest: RequestProtocol {
    public enum LockState {
        case lock
        case unlock
    }
    typealias CompletionType = Bool
    var path: String {
        switch state {
        case .lock:
            return "/api/1/vehicles/\(vehicleIdentifier)/command/door_lock"
        case .unlock:
            return "/api/1/vehicles/\(vehicleIdentifier)/command/door_unlock"
        }
    }
    let method = WebRequest.RequestMethod.post
    let accessToken: String
    let vehicleIdentifier: String
    let state: LockState

    public init(accessToken: String, vehicleIdentifier: String, state: LockState) {
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
