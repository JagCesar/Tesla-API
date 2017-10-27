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
                if let error = error {
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                } else if let response = response as? [String: Bool],
                    let responseBool = response["response"] {
                    DispatchQueue.main.async {
                        completion(Result.success(responseBool))
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(Result.failure(APIError()))
                    }
                }
        }
    }
}
