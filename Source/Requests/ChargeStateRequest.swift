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
            accessToken: accessToken) { data, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                } else if let data = data {
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let chargeStateResponse = try decoder.decode(ChargeStateResponse.self, from: data)
                        DispatchQueue.main.async {
                            completion(Result.success(chargeStateResponse.response))
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
