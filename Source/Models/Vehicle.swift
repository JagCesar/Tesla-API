import Foundation

public class Vehicle {
    public enum State: String {
        case online
    }
    public let color: String?
    public let displayName: String?
    public let identifier: String
    public let optionCodes: [String]
    public let vehicleIdentifier: Int
    public let vin: String
    public let tokens: [String]
    public let state: State

    init?(dictionary: [String: AnyObject]) {
        guard let identifier = dictionary["id"] as? String,
            let optionCodes = dictionary["option_codes"] as? String,
            let vehicleIdentifier = dictionary["vehicle_id"] as? Int,
            let vin = dictionary["vin"] as? String,
            let tokens = dictionary["tokens"] as? [String],
            let stateString = dictionary["state"] as? String,
            let state = State(rawValue: stateString) else {
                return nil
        }
        self.color = dictionary["color"] as? String
        self.displayName = dictionary["display_name"] as? String
        self.identifier = identifier
        self.optionCodes = optionCodes.components(separatedBy: ",")
        self.vehicleIdentifier = vehicleIdentifier
        self.vin = vin
        self.tokens = tokens
        self.state = state
    }
}
