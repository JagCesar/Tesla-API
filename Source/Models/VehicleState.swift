import Foundation

public struct VehicleStateResponse: Codable {
    let response: VehicleState
}

public struct VehicleState: Codable {
    let parsedCalendarSupported: Double
    let spoilerType: String
    let rt: Double
    let carVersion: String
    let rearSeatType: Double
    let df: Double
    let locked: Double
    let thirdRowSeats: String
    let sunRoofState: String
    let carType: String
    let remoteStartSupported: Double
    let hasSpoiler: Double
    let pf: Double
    let odometer: Double
    let lastAutoparkError: String
    let darkRims: Double
    let autoparkState: String
    let sunRoofInstalled: Double
    let sunRoofPercentOpen: Double
    let exteriorColor: String
    let timestamp: Double
    let vehicleName: String
    let homelinkNearby: Double
    let valetPinNeeded: Double
    let notificationsSupported: Double
    let pr: Double
    let rearSeatHeaters: Double
    let valetMode: Double
    let calendarSupported: Double
    let dr: Double
    let centerDisplayState: Double
    let apiVersion: Double
    let remoteStart: Double
    let ft: Double
    let autoparkStateV2: String
    let wheelType: String
    let perfConfig: String
    let autoparkStyle: String
    let roofColor: String
    let rhd: Double
    let seatType: Double

    private enum CodingKeys: String, CodingKey {
        case parsedCalendarSupported = "parsed_calendar_supported"
        case spoilerType = "spoiler_type"
        case rt
        case carVersion = "car_version"
        case rearSeatType = "rear_seat_type"
        case df
        case locked
        case thirdRowSeats = "third_row_seats"
        case sunRoofState = "sun_roof_state"
        case carType = "car_type"
        case remoteStartSupported = "remote_start_supported"
        case hasSpoiler = "has_spoiler"
        case pf
        case odometer
        case lastAutoparkError = "last_autopark_error"
        case darkRims = "dark_rims"
        case autoparkState = "autopark_state"
        case sunRoofInstalled = "sun_roof_installed"
        case sunRoofPercentOpen = "sun_roof_percent_open"
        case exteriorColor = "exterior_color"
        case timestamp
        case vehicleName = "vehicle_name"
        case homelinkNearby = "homelink_nearby"
        case valetPinNeeded = "valet_pin_needed"
        case notificationsSupported = "notifications_supported"
        case pr
        case rearSeatHeaters = "rear_seat_heaters"
        case valetMode = "valet_mode"
        case calendarSupported = "calendar_supported"
        case dr
        case centerDisplayState = "center_display_state"
        case apiVersion = "api_version"
        case remoteStart = "remote_start"
        case ft
        case autoparkStateV2 = "autopark_state_v2"
        case wheelType = "wheel_type"
        case perfConfig = "perf_config"
        case autoparkStyle = "autopark_style"
        case roofColor = "roof_color"
        case rhd
        case seatType = "seat_type"
    }
}
