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

    static func post(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "POST", completion: completion)
    }

    static func put(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "PUT", completion: completion)
    }

    static func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "GET", completion: completion)
    }

    static private func dataTask(
        request: NSMutableURLRequest,
        method: String,
        completion: @escaping (_ success: Bool, _ object: AnyObject?) -> Void) {
        request.httpMethod = method
        let session = URLSession(configuration: URLSessionConfiguration.default)

        let task = session.dataTask(with: request as URLRequest) { data, response, error -> Void in
            if let data = data {
                let json = try? JSONSerialization.jsonObject(with: data, options: [])
                if let response = response as? HTTPURLResponse, 200...299 ~= response.statusCode {
                    completion(true, json as AnyObject)
                } else {
                    completion(false, json as AnyObject)
                }
            }
        }
        task.resume()
    }
}
