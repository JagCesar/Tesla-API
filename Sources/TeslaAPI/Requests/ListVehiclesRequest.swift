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
            accessToken: accessToken) { response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(Result.failure(error))
                    } else {
                        guard let responseArray = response?["response"] as? [[String: AnyObject]] else {
                            completion(Result.failure(APIError()))
                            return
                        }
                        let vehicles = responseArray.compactMap { return Vehicle(dictionary: $0) }
                        completion(Result.success(vehicles))
                    }
                }
        }
    }
}
