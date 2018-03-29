import Foundation

public class VehicleResponse: Codable {
    let response: [Vehicle]
}

public struct Vehicle: Codable {

    public enum State: String, Codable {
        case online
    }

    public let color: String?
    public let displayName: String?
    public let identifier: Int
    public let optionCodes: String
    public let vehicleIdentifier: Int
    public let vin: String
    public let tokens: [String]
    public let state: State
}
