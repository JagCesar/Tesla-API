import Foundation

public struct SetTemperaturesRequest: RequestProtocol {
    typealias CompletionType = Bool
    var path: String {
        return "/api/1/vehicles/\(vehicleIdentifier)/command/set_temps"
    }
    let method = WebRequest.RequestMethod.post
    let accessToken: String
    let vehicleIdentifier: String
    let driverTemp: Double
    let passengerTemp: Double

    public init(accessToken: String, vehicleIdentifier: String, driverTemp: Double, passengerTemp: Double) {
        self.accessToken = accessToken
        self.vehicleIdentifier = vehicleIdentifier
        self.driverTemp = driverTemp
        self.passengerTemp = passengerTemp
    }

    public func execute(completion: @escaping (Result<Bool>) -> Void) {
        WebRequest.request(
            path: path,
            method: method,
            params: ["driver_temp": "\(driverTemp)", "passenger_temp": "\(passengerTemp)"],
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
