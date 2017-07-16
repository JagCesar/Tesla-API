import Foundation

class WebRequest {

    static func login(email: String, password: String, completion: @escaping (_ success: Bool, _ tokenDictionary: [String: AnyObject]?) -> ()) {
        let loginObject = [
            "email": email,
            "password": password,
            "grant_type": "password",
            "client_id": "81527cff06843c8634fdc09e8ac0abefb46ac849f38fe1e431c2ef2106796384",
            "client_secret": "c7257eb71a564034f9419ee651c7d0e5f7aa6bfbd18bafb5c5c033b093bb2fa3"]

        post(request: clientURLRequest(path: "oauth/token", params: loginObject as Dictionary<String, AnyObject>)) { (success, object) -> () in
            DispatchQueue.main.async {
                if success {
                    completion(true, object as? [String: AnyObject])
                } else {
                    completion(false, nil)
                }
            }
        }
    }

    static private func clientURLRequest(path: String, params: Dictionary<String, AnyObject>? = nil) -> NSMutableURLRequest {
        let request = NSMutableURLRequest(url: URL(string: "https://owner-api.teslamotors.com/"+path)!)
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

//        if let token = token {
//            request.addValue("Bearer "+token, forHTTPHeaderField: "Authorization")
//        }

        return request
    }

    static private func post(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "POST", completion: completion)
    }

    static private func put(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
        dataTask(request: request, method: "PUT", completion: completion)
    }

    static private func get(request: NSMutableURLRequest, completion: @escaping (_ success: Bool, _ object: AnyObject?) -> ()) {
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
