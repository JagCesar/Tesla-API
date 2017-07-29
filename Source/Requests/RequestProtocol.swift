import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol RequestProtocol {
    associatedtype CompletionType
    var path: String { get }
    var method: WebRequest.RequestMethod { get }
    func execute(completion: @escaping (_ result: Result<CompletionType>) -> Void)
}
