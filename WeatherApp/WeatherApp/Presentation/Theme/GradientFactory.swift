import SwiftUI

struct GradientFactory {
    static func background(for condition: String) -> LinearGradient {
        let colors: [Color]
        switch condition.lowercased() {
        case let str where str.contains("clear"):
            colors = [.orange, .pink]
        case let str where str.contains("cloud"):
            colors = [.gray.opacity(0.6), .blue.opacity(0.4)]
        case let str where str.contains("rain") || str.contains("drizzle"):
            colors = [.blue.opacity(0.8), .indigo]
        case let str where str.contains("snow"):
            colors = [.white, .blue.opacity(0.6)]
        case let str where str.contains("thunder"):
            colors = [.purple, .black]
        default:
            colors = [.blue, .indigo]
        }
        return LinearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
}
