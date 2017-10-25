import Foundation

public class ChargeState {
    enum ChargingState: String {
        case disconnected = "Disconnected"
    }

    let batteryHeaterOn: Bool?
    let batteryLevel: Int
    let batteryRange: Float
    let chargeCurrentRequest: Int
    let chargeCurrentRequestMax: Int
    let chargeEnableRequest: Bool
    let chargeEnergyAdded: Float
    let chargeLimitSoc: Int
    let chargeLimitSocMax: Int
    let chargeLimitSocMin: Int
    let chargeLimitSocStd: Int
    let chargeMilesAddedIdeal: Float
    let chargeMilesAddedRated: Float
    let chargePortDoorOpen: Bool
    let chargePortLatch: String
    let chargeRate: Int
    let chargeToMaxRange: Int
    let chargerActualCurrent: Int
    let chargerPhases: Int?
    let chargerPilotCurrent: Int?
    let chargerPower: Int
    let chargerVoltage: Int
    let chargingState: ChargingState
    let estBatteryRange: Float
    let euVehicle: Bool
    let fastChargerPresent: Bool
    let fastChargerType: String?
    let idealBatteryRange: Float
    let managedChargingActive: Bool
    let managedChargingStartTime: Date?
    let managedChargingUserCanceled: Bool
    let maxRangeChargeCounter: Int
    let motorizedChargePort: Bool
    let notEnoughPowerToHeat: Bool?
    let scheduledChargingPending: Bool
    let scheduledChargingStartTime: Date?
    let timeToFullCharge: Int
    let timestamp: Date
    let tripCharging: Bool
    let usableBatteryLevel: Int
    let userChargeEnableRequest: Bool?

    init(dictionary: [String: Any]) {
        batteryHeaterOn = dictionary["battery_heater_on"] as? Bool
        batteryLevel = dictionary["battery_level"] as! Int
        batteryRange = dictionary["battery_range"] as! Float
        chargeCurrentRequest = dictionary["charge_current_request"] as! Int
        chargeCurrentRequestMax = dictionary["charge_current_request_max"] as! Int
        chargeEnableRequest = dictionary["charge_enable_request"] as! Bool
        chargeEnergyAdded = dictionary["charge_energy_added"] as! Float
        chargeLimitSoc = dictionary["charge_limit_soc"] as! Int
        chargeLimitSocMax = dictionary["charge_limit_soc_max"] as! Int
        chargeLimitSocMin = dictionary["charge_limit_soc_min"] as! Int
        chargeLimitSocStd = dictionary["charge_limit_soc_std"] as! Int
        chargeMilesAddedIdeal = dictionary["charge_miles_added_ideal"] as! Float
        chargeMilesAddedRated = dictionary["charge_miles_added_rated"] as! Float
        chargePortDoorOpen = dictionary["charge_port_door_open"] as! Bool
        chargePortLatch = dictionary["charge_port_latch"] as! String
        chargeRate = dictionary["charge_rate"] as! Int
        chargeToMaxRange = dictionary["charge_to_max_range"] as! Int
        chargerActualCurrent = dictionary["charger_actual_current"] as! Int
        chargerPhases = dictionary["charger_phases"] as? Int
        chargerPilotCurrent = dictionary["charger_pilot_current"] as? Int
        chargerPower = dictionary["charger_power"] as! Int
        chargerVoltage = dictionary["charger_voltage"] as! Int
        chargingState = ChargingState(rawValue: dictionary["charging_state"] as! String)!
        estBatteryRange = dictionary["est_battery_range"] as! Float
        euVehicle = dictionary["eu_vehicle"] as! Bool
        fastChargerPresent = dictionary["fast_charger_present"] as! Bool
        fastChargerType = dictionary["fast_charger_type"] as? String
        idealBatteryRange = dictionary["ideal_battery_range"] as! Float
        managedChargingActive = dictionary["managed_charging_active"] as! Bool
        if let timestamp = dictionary["managed_charging_start_time"] as? Double {
            managedChargingStartTime = Date(timeIntervalSince1970: timestamp)
        } else {
            managedChargingStartTime = nil
        }
        managedChargingUserCanceled = dictionary["managed_charging_user_canceled"] as! Bool
        maxRangeChargeCounter = dictionary["max_range_charge_counter"] as! Int
        motorizedChargePort = dictionary["motorized_charge_port"] as! Bool
        notEnoughPowerToHeat = dictionary["not_enough_power_to_heat"] as? Bool
        scheduledChargingPending = dictionary["scheduled_charging_pending"] as! Bool
        if let timestamp = dictionary["scheduled_charging_start_time"] as? Double {
            scheduledChargingStartTime = Date(timeIntervalSince1970: timestamp)
        } else {
            scheduledChargingStartTime = nil
        }
        timeToFullCharge = dictionary["time_to_full_charge"] as! Int
        timestamp = Date(timeIntervalSince1970: dictionary["timestamp"] as! Double)
        tripCharging = dictionary["trip_charging"] as! Bool
        usableBatteryLevel = dictionary["usable_battery_level"] as! Int
        userChargeEnableRequest = dictionary["user_charge_enable_request"] as? Bool
    }
}
