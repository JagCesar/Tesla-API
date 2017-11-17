import Foundation

struct BoolResponse: Codable {
    let response: Bool
}

struct ResultResponse: Codable {
    let response: BoolResult
}

struct BoolResult: Codable {
    let result: Bool
}
