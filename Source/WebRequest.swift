import Foundation

class WebRequest {
    enum RequestMethod: String {
        case get = "GET"
        case post = "POST"
        case put = "PUT"
    }

    private init() {

    }

    static private func clientURLRequest(
        path: String,
        params: [String: AnyObject]? = nil,
        accessToken: String? = nil) -> URLRequest {

        var components = URLComponents()
        components.scheme = "https"
        components.host = TeslaAPI.host
        components.path = path

        var request = URLRequest(url: components.url!)
        if let params = params {
            var paramString = ""
            for (key, value) in params {
                let escapedKey = (key as NSString).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                let escapedValue = (value as! NSString).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                paramString += "\(escapedKey)=\(escapedValue)&"
            }

            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpBody = paramString.data(using: String.Encoding.utf8)
        }

        if let accessToken = accessToken {
            request.addValue("Bearer " + accessToken, forHTTPHeaderField: "Authorization")
        }

        return request
    }

    static public func request(
        path: String,
        method: RequestMethod,
        params: [String: AnyObject]? = nil, accessToken: String? = nil,
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
        let session = URLSession(configuration: URLSessionConfiguration.default)

        let task = session.dataTask(with: request as URLRequest) { data, response, error -> Void in
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
