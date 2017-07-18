import Foundation

class WebRequest {

    static var baseURLString = "https://owner-api.teslamotors.com/"

    static func clientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil, accessToken: String? = nil) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: URL(string: baseURLString+path)!)
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

    static func post(request: NSMutableURLRequest, completion: @escaping (_ response: AnyObject?, _ error: Error?) -> ()) {
        dataTask(request: request, method: "POST", completion: completion)
    }

    static func put(request: NSMutableURLRequest, completion: @escaping (_ response: AnyObject?, _ error: Error?) -> ()) {
        dataTask(request: request, method: "PUT", completion: completion)
    }

    static func get(request: NSMutableURLRequest, completion: @escaping (_ response: AnyObject?, _ error: Error?) -> ()) {
        dataTask(request: request, method: "GET", completion: completion)
    }

    static private func dataTask(
        request: NSMutableURLRequest,
        method: String,
        completion: @escaping (_ response: AnyObject?, _ error: Error?) -> Void) {
        request.httpMethod = method
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
