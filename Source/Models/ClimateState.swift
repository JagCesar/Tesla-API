import Foundation

public struct ClimateState {
    let insideTemp: Double
    let outsideTemp: Double
    let driverTempSetting: Double
    let passengerTempSetting: Double
    let isAutoConditioningOn: Bool
    let isFrontDefrosterOn: Bool
    let isRearDefrosterOn: Bool
    let fanStatus: Int?

    init(dict: [String: Any]) {
        insideTemp = dict["inside_temp"] as! Double
        outsideTemp = dict["outside_temp"] as! Double
        driverTempSetting = dict["driver_temp_setting"] as! Double
        passengerTempSetting = dict["passenger_temp_setting"] as! Double
        isAutoConditioningOn = dict["is_auto_conditioning_on"] as! Bool
        isFrontDefrosterOn = dict["is_front_defroster_on"] as! Bool
        isRearDefrosterOn = dict["is_rear_defroster_on"] as! Bool
        fanStatus = dict["fan_status"] as? Int
    }
}
