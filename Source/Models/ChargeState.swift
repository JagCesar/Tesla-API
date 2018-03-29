import Foundation

public class ChargeStateResponse: Codable {
    let response: ChargeState
}

public struct ChargeState: Codable {

    public enum ChargingState: String, Codable {
        case disconnected = "Disconnected"
        case charging = "Charging"
        case complete = "Complete"
    }

    public let batteryHeaterOn: Bool?
    public let batteryLevel: Int
    public let batteryRange: Double
    public let chargeCurrentRequest: Int
    public let chargeCurrentRequestMax: Int
    public let chargeEnableRequest: Bool
    public let chargeEnergyAdded: Double
    public let chargeLimitSoc: Int
    public let chargeLimitSocMax: Int
    public let chargeLimitSocMin: Int
    public let chargeLimitSocStd: Int
    public let chargeMilesAddedIdeal: Double
    public let chargeMilesAddedRated: Double
    public let chargePortDoorOpen: Bool?
    public let chargePortLatch: String
    public let chargeRate: Double
    public let chargeToMaxRange: Int
    public let chargerActualCurrent: Int
    public let chargerPhases: Int?
    public let chargerPilotCurrent: Int?
    public let chargerPower: Int
    public let chargerVoltage: Int
    public let chargingState: ChargingState
    public let estBatteryRange: Double
    public let euVehicle: Bool
    public let fastChargerPresent: Bool
    public let fastChargerType: String?
    public let idealBatteryRange: Double
    public let managedChargingActive: Bool
    public let managedChargingStartTime: Date?
    public let managedChargingUserCanceled: Bool
    public let maxRangeChargeCounter: Int
    public let motorizedChargePort: Bool
    public let notEnoughPowerToHeat: Bool?
    public let scheduledChargingPending: Bool
    public let scheduledChargingStartTime: Date?
    public let timeToFullCharge: Double
    public let timestamp: Date
    public let tripCharging: Bool?
    public let usableBatteryLevel: Int
    public let userChargeEnableRequest: Bool?
}
