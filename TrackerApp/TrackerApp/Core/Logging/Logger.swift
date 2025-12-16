import Foundation

public protocol Logger {
    func log(_ message: String)
    func error(_ message: String)
}

public final class ConsoleLogger: Logger {
    public init() {}

    public func log(_ message: String) {
        print("INFO: \(message)")
    }

    public func error(_ message: String) {
        print("ERROR: \(message)")
    }
}
