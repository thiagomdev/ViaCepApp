import Foundation

enum NetworkError: Error {
    case responseError(Data?, Int)
}
