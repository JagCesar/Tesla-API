import Foundation

public class ChargeStateResponse: Codable {
    let response: ChargeState
}

public class ChargeState: Codable {
//    public enum ChargingState: String {
//        case disconnected = "Disconnected"
//        case charging = "Charging"
//        case complete = "Complete"
//    }

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
//    public let chargingState: ChargingState
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

    private enum CodingKeys: String, CodingKey {
        case batteryHeaterOn = "battery_heater_on"
        case batteryLevel = "battery_level"
        case batteryRange = "battery_range"
        case chargeCurrentRequest = "charge_current_request"
        case chargeCurrentRequestMax = "charge_current_request_max"
        case chargeEnableRequest = "charge_enable_request"
        case chargeEnergyAdded = "charge_energy_added"
        case chargeLimitSoc = "charge_limit_soc"
        case chargeLimitSocMax = "charge_limit_soc_max"
        case chargeLimitSocMin = "charge_limit_soc_min"
        case chargeLimitSocStd = "charge_limit_soc_std"
        case chargeMilesAddedIdeal = "charge_miles_added_ideal"
        case chargeMilesAddedRated = "charge_miles_added_rated"
        case chargePortDoorOpen = "charge_port_door_open"
        case chargePortLatch = "charge_port_latch"
        case chargeRate = "charge_rate"
        case chargeToMaxRange = "charge_to_max_range"
        case chargerActualCurrent = "charger_actual_current"
        case chargerPhases = "charger_phases"
        case chargerPilotCurrent = "charger_pilot_current"
        case chargerPower = "charger_power"
        case chargerVoltage = "charger_voltage"
        //    case chargingState = "charging_state"
        case estBatteryRange = "est_battery_range"
        case euVehicle = "eu_vehicle"
        case fastChargerPresent = "fast_charger_present"
        case fastChargerType = "fast_charger_type"
        case idealBatteryRange = "ideal_battery_range"
        case managedChargingActive = "managed_charging_active"
        case managedChargingStartTime = "managed_charging_start_time"
        case managedChargingUserCanceled = "managed_charging_user_canceled"
        case maxRangeChargeCounter = "max_range_charge_counter"
        case motorizedChargePort = "motorized_charge_port"
        case notEnoughPowerToHeat = "not_enough_power_to_heat"
        case scheduledChargingPending = "scheduled_charging_pending"
        case scheduledChargingStartTime = "scheduled_charging_start_time"
        case timeToFullCharge = "time_to_full_charge"
        case timestamp = "timestamp"
        case tripCharging = "trip_charging"
        case usableBatteryLevel = "usable_battery_level"
        case userChargeEnableRequest = "user_charge_enable_request"
    }
}
