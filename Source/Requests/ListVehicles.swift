import Foundation

public struct ListVehicles: RequestProtocol {
    typealias CompletionType = [Vehicle]
    let accessToken: String
    let path = "api/1/vehicles"
    let method = WebRequest.RequestMethod.get

    public init(accessToken: String) {
        self.accessToken = accessToken
    }

    public func execute(completion: @escaping (Result<[Vehicle]>) -> Void) {
        WebRequest.request(
            path: path,
            method: method,
            accessToken: accessToken) { response, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                } else {
                    guard let responseArray = response?["response"] as? [[String: AnyObject]] else {
                        DispatchQueue.main.async {
                            completion(Result.failure(APIError()))
                        }
                        return
                    }
                    let vehicles = responseArray.flatMap { return Vehicle(dictionary: $0) }
                    DispatchQueue.main.async {
                        completion(Result.success(vehicles))
                    }
                }
        }
    }
}
