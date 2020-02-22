import Foundation

final class WebRequest {
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }

    static private func clientURLRequest(
        path: String,
        params: [String: String] = [:],
        accessToken: String? = nil) -> URLRequest {

        var components = URLComponents()
        components.scheme = "https"
        components.host = TeslaAPI.host
        components.path = path

        var request = URLRequest(url: components.url!)

        let bodyString = params.compactMap { args -> String? in
            guard let escapedKey = args.key.percentageEncoded else { return nil }
            guard let escapedValue = args.value.percentageEncoded else { return nil }
            return escapedKey + "=" + escapedValue
        }.joined(separator: "&")

        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpBody = bodyString.data(using: .utf8)

        if let accessToken = accessToken {
            request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }

        return request
    }

    static public func request(
        path: String,
        method: RequestMethod,
        params: [String: String] = [:],
        accessToken: String? = nil,
        completion: @escaping (_ response: AnyObject?, _ error: Error?) -> Void) {
        dataTask(
            request: clientURLRequest(
                path: path,
                params: params,
                accessToken: accessToken),
            method: method,
            completion: completion)
    }

    static private func dataTask(
        request: URLRequest,
        method: RequestMethod,
        completion: @escaping (_ response: AnyObject?, _ error: Error?) -> Void) {
        var request = request
        request.httpMethod = method.rawValue
        let session = URLSession(configuration: .default)

        let task = session.dataTask(with: request) { data, response, error -> Void in
            if let error = error {
                completion(nil, error)
                return
            }
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: [])
                completion(json as AnyObject, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
}

private extension String {
    var percentageEncoded: String? {
        var allowedCharacterSet = CharacterSet.urlQueryAllowed
        allowedCharacterSet.remove(charactersIn: "&")
        return addingPercentEncoding(withAllowedCharacters: allowedCharacterSet)
    }
}
