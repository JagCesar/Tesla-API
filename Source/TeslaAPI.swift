import Foundation

public struct TeslaAPI {
    public static var baseURLString: String {
        get {
            return WebRequest.baseURLString
        }
        set {
            WebRequest.baseURLString = newValue
        }
    }

    private init() {

    }
}
