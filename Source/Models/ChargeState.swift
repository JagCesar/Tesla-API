import Foundation

public class ChargeState {
    public enum ChargingState: String {
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
    public let euVehicle: Bool?
    public let fastChargerPresent: Bool
    public let fastChargerType: String?
    public let idealBatteryRange: Double
    public let managedChargingActive: Bool
    public let managedChargingStartTime: Date?
    public let managedChargingUserCanceled: Bool
    public let maxRangeChargeCounter: Int
    public let motorizedChargePort: Bool?
    public let notEnoughPowerToHeat: Bool?
    public let scheduledChargingPending: Bool
    public let scheduledChargingStartTime: Date?
    public let timeToFullCharge: Double
    public let timestamp: Date
    public let tripCharging: Bool?
    public let usableBatteryLevel: Int
    public let userChargeEnableRequest: Bool?

    init(dictionary: [String: Any]) {
        batteryHeaterOn = dictionary["battery_heater_on"] as? Bool
        batteryLevel = dictionary["battery_level"] as! Int
        batteryRange = dictionary["battery_range"] as! Double
        chargeCurrentRequest = dictionary["charge_current_request"] as! Int
        chargeCurrentRequestMax = dictionary["charge_current_request_max"] as! Int
        chargeEnableRequest = dictionary["charge_enable_request"] as! Bool
        chargeEnergyAdded = dictionary["charge_energy_added"] as! Double
        chargeLimitSoc = dictionary["charge_limit_soc"] as! Int
        chargeLimitSocMax = dictionary["charge_limit_soc_max"] as! Int
        chargeLimitSocMin = dictionary["charge_limit_soc_min"] as! Int
        chargeLimitSocStd = dictionary["charge_limit_soc_std"] as! Int
        chargeMilesAddedIdeal = dictionary["charge_miles_added_ideal"] as! Double
        chargeMilesAddedRated = dictionary["charge_miles_added_rated"] as! Double
        chargePortDoorOpen = dictionary["charge_port_door_open"] as? Bool
        chargePortLatch = dictionary["charge_port_latch"] as! String
        chargeRate = dictionary["charge_rate"] as! Double
        chargeToMaxRange = dictionary["charge_to_max_range"] as! Int
        chargerActualCurrent = dictionary["charger_actual_current"] as! Int
        chargerPhases = dictionary["charger_phases"] as? Int
        chargerPilotCurrent = dictionary["charger_pilot_current"] as? Int
        chargerPower = dictionary["charger_power"] as! Int
        chargerVoltage = dictionary["charger_voltage"] as! Int
        chargingState = ChargingState(rawValue: dictionary["charging_state"] as! String)!
        estBatteryRange = dictionary["est_battery_range"] as! Double
        euVehicle = dictionary["eu_vehicle"] as? Bool
        fastChargerPresent = dictionary["fast_charger_present"] as! Bool
        fastChargerType = dictionary["fast_charger_type"] as? String
        idealBatteryRange = dictionary["ideal_battery_range"] as! Double
        managedChargingActive = dictionary["managed_charging_active"] as! Bool
        if let timestamp = dictionary["managed_charging_start_time"] as? Double {
            managedChargingStartTime = Date(timeIntervalSince1970: timestamp)
        } else {
            managedChargingStartTime = nil
        }
        managedChargingUserCanceled = dictionary["managed_charging_user_canceled"] as! Bool
        maxRangeChargeCounter = dictionary["max_range_charge_counter"] as! Int
        motorizedChargePort = dictionary["motorized_charge_port"] as? Bool
        notEnoughPowerToHeat = dictionary["not_enough_power_to_heat"] as? Bool
        scheduledChargingPending = dictionary["scheduled_charging_pending"] as! Bool
        if let timestamp = dictionary["scheduled_charging_start_time"] as? Double {
            scheduledChargingStartTime = Date(timeIntervalSince1970: timestamp)
        } else {
            scheduledChargingStartTime = nil
        }
        timeToFullCharge = dictionary["time_to_full_charge"] as! Double
        timestamp = Date(timeIntervalSince1970: dictionary["timestamp"] as! Double)
        tripCharging = dictionary["trip_charging"] as? Bool
        usableBatteryLevel = dictionary["usable_battery_level"] as! Int
        userChargeEnableRequest = dictionary["user_charge_enable_request"] as? Bool
    }
}
