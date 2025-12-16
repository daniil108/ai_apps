import Foundation

protocol NetworkLogger {
    func log(_ message: String)
}

struct DefaultNetworkLogger: NetworkLogger {
    func log(_ message: String) {
        print("[Network] \(message)")
    }
}
