import Foundation

public class VehicleResponse: Codable {
    let response: [Vehicle]
}

public class Vehicle: Codable {
//    public enum State: String {
//        case online
//    }
    public let color: String?
    public let displayName: String?
    public let identifier: Int
    public let optionCodes: String
    public let vehicleIdentifier: Int
    public let vin: String
    public let tokens: [String]
//    public let state: State

    private enum CodingKeys: String, CodingKey {
        case color = "color"
        case displayName = "display_name"
        case identifier = "id"
        case optionCodes = "option_codes"
        case vehicleIdentifier = "vehicle_id"
        case vin
        case tokens = "tokens"
//        case state
    }
}

