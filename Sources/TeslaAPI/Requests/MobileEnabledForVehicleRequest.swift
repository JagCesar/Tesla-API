import Foundation

struct MobileEnabledForVehicleRequest: RequestProtocol {
    typealias CompletionType = Bool
    var path: String {
        return "/api/1/vehicles/\(vehicleIdentifier)/mobile_enabled"
    }
    let vehicleIdentifier: String
    let method = WebRequest.RequestMethod.get
    let accessToken: String

    init(vehicle: Vehicle, accessToken: String) {
        self.vehicleIdentifier = vehicle.identifier
        self.accessToken = accessToken
    }

    func execute(completion: @escaping (Result<Bool>) -> Void) {
        WebRequest.request(
            path: path,
            method: method,
            accessToken: accessToken) { response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(Result.failure(error))
                    } else if let response = response as? [String: Bool],
                        let responseBool = response["response"] {
                        completion(Result.success(responseBool))
                    } else {
                        completion(Result.failure(APIError()))
                    }
                }
        }
    }
}
