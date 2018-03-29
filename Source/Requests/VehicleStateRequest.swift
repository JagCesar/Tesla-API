import Foundation

public struct VehicleStateRequest: RequestProtocol {
    typealias CompletionType = VehicleState
    var path: String {
        return "/api/1/vehicles/\(vehicleIdentifier)/data_request/vehicle_state"
    }
    let method = WebRequest.RequestMethod.get
    let accessToken: String
    let vehicleIdentifier: String

    public func execute(completion: @escaping (Result<VehicleState>) -> Void) {
        WebRequest.request(
            path: path,
            method: method,
            accessToken: accessToken) { data, error in
                if let error = error {
                    DispatchQueue.main.async {
                        completion(Result.failure(error))
                    }
                } else if let data = data {
                    //                    VehicleStateRequest.printStruct(dict: response)
                    do {
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let vehicleStateResponse = try decoder.decode(VehicleStateResponse.self, from: data)
                        DispatchQueue.main.async {
                            completion(Result.success(vehicleStateResponse.response))
                        }
                    } catch (let error) {
                        DispatchQueue.main.async {
                            completion(Result.failure(error))
                        }
                    }
                } else {
                    DispatchQueue.main.async {
                        completion(Result.failure(APIError()))
                    }
                }
        }

        WebRequest.request(
            path: path,
            method: method,
            accessToken: accessToken) { data, error in

        }
    }

    private static func printStruct(dict: [String: [String: Any]]) {
        let response = dict["response"]!
        print("\n\nproperties:")
        for (key, value) in response {
            var type: String? = nil
            if value is Double {
                type = "Double"
            } else if value is String {
                type = "String"
            } else {
                type = "Unknown"
            }
            if type == nil {
                continue
            }
            print("let " + key.camelCased() + ": \(type!)")
        }

        print("\n\nCoding keys:")
        for (key, value) in response {
            var type: String! = nil
            if value is Bool {
                type = "Bool"
            } else if value is Double {
                type = "Int"
            } else if value is String {
                type = "String"
            } else {
                type = "Unknown"
            }
            if type == nil {
                continue
            }

            if key.camelCased() == key {
                print("case " + key.camelCased())
            } else {
                print("case " + key.camelCased() + " = \"\(key)\"" )
            }
        }

        print("\n\n")
    }

    func isKnownType(value: Any) -> Bool {
        return value is String || value is Double
    }
}

public enum StringCaseFormat {

    public enum SnakeCase {
        case lower
        case upper
        case capitalized
    }

    public enum CamelCase {
        case `default`
        case capitalized
    }
}

public extension String {

    public func caseSplit() -> [String] {
        var res: [String] = []
        let trim = self.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let alphanumerics = CharacterSet.alphanumerics
        let uppercaseLetters = CharacterSet.uppercaseLetters
        let lowercaseLetters = CharacterSet.lowercaseLetters
        trim.split(separator: " ").forEach { str in
            var previousCase = 0
            var currentCase = 0
            var caseChange = false
            var scalars = UnicodeScalarView()
            for scalar in str.unicodeScalars {
                if alphanumerics.contains(scalar) {
                    if uppercaseLetters.contains(scalar) {
                        currentCase = 1
                    } else if lowercaseLetters.contains(scalar) {
                        currentCase = 2
                    } else {
                        currentCase = 0
                    }
                    let letterInWord = scalars.count
                    if !caseChange && letterInWord > 0 {
                        if currentCase != previousCase {
                            if previousCase == 1 {
                                if letterInWord > 1 {
                                    caseChange = true
                                }
                            } else {
                                caseChange = true
                            }
                        }
                    }
                    if caseChange {
                        res.append(String(scalars))
                        scalars.removeAll()
                    }
                    scalars.append(scalar)
                    caseChange = false
                    previousCase = currentCase
                } else {
                    caseChange = true
                }
            }
            if scalars.count > 0 {
                res.append(String(scalars))
            }
        }
        return res
    }

    public func snakeCased(_ format: StringCaseFormat.SnakeCase = .lower) -> String {
        let split = self.caseSplit()
        if format == .lower {
            return split.map { $0.lowercased() }.joined(separator: "_")
        } else if format == .upper {
            return split.map { $0.uppercased() }.joined(separator: "_")
        }
        return split.map { $0.capitalized }.joined(separator: "_")
    }

    public func camelCased(_ format: StringCaseFormat.CamelCase = .default) -> String {
        var res: [String] = []
        for (i, str) in self.caseSplit().enumerated() {
            if i == 0 && format == .default {
                res.append(str.lowercased())
                continue
            }
            res.append(str.capitalized)
        }
        return res.joined()
    }
}
