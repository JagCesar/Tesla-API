import Foundation

public struct ClimateStateRequest: RequestProtocol {
    typealias CompletionType = ClimateState
    var path: String {
        return "/api/1/vehicles/\(vehicleIdentifier)/data_request/climate_state"
    }
    let method = WebRequest.RequestMethod.get
    let accessToken: String
    let vehicleIdentifier: String

    public init(accessToken: String, vehicleIdentifier: String) {
        self.accessToken = accessToken
        self.vehicleIdentifier = vehicleIdentifier
    }

    public func execute(completion: @escaping (Result<ClimateState>) -> Void) {
        WebRequest.request(
            path: path,
            method: method,
            accessToken: accessToken) { response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                    return
                }
                let responseDict = response as! [String: [String: Any]]
                let dataDict = responseDict["response"]!
                DispatchQueue.main.async {
                    completion(Result.success(ClimateState(dict: dataDict)))
                }
        }
    }
}
