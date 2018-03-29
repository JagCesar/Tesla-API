import Foundation

public struct ListVehiclesRequest: RequestProtocol {
    typealias CompletionType = [Vehicle]
    let accessToken: String
    let path = "/api/1/vehicles"
    let method = WebRequest.RequestMethod.get

    public init(accessToken: String) {
        self.accessToken = accessToken
    }

    public func execute(completion: @escaping (Result<[Vehicle]>) -> Void) {
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
                        let vehicleResponse = try decoder.decode(VehicleResponse.self, from: data)
                        DispatchQueue.main.async {
                            completion(Result.success(vehicleResponse.response))
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
