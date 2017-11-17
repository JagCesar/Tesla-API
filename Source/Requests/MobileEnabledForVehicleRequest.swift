import Foundation

struct MobileEnabledForVehicleRequest: RequestProtocol {
    typealias CompletionType = Bool
    var path: String {
        return "/api/1/vehicles/\(vehicleIdentifier)/mobile_enabled"
    }
    let vehicleIdentifier: String
    let method = WebRequest.RequestMethod.get
    let accessToken: String

    init(vehicleIdentifier: String, accessToken: String) {
        self.vehicleIdentifier = vehicleIdentifier
        self.accessToken = accessToken
    }

    func execute(completion: @escaping (Result<Bool>) -> Void) {
        WebRequest.request(
            path: path,
            method: method,
            accessToken: accessToken) { data, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                } else if let data = data {
                    do {
                        let boolResponse = try JSONDecoder().decode(BoolResponse.self, from: data)
                        DispatchQueue.main.async {
                            completion(Result.success(boolResponse.response))
                        }
                    } catch let error {
                        DispatchQueue.main.async {
                            completion(Result.failure(error))
                        }
                    }
                }
        }
    }
}
