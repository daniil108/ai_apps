import Foundation

enum MockData {
    static let cars: [Car] = [
        Car(id: UUID(), name: "Toyota Corolla Kombi Vit App", plateNumber: "JBA81R", locationName: "Hagagatan 19", distanceText: "6 min"),
        Car(id: UUID(), name: "Volkswagen ID.3", plateNumber: "WQK22B", locationName: "Birger Jarlsgatan 44", distanceText: "9 min"),
        Car(id: UUID(), name: "Volvo XC40 Recharge", plateNumber: "KLM11P", locationName: "Drottninggatan 8", distanceText: "12 min")
    ]

    static func date(dayOffset: Int = 0, hourOffset: Int = 0) -> Date {
        let base = Calendar.current.date(byAdding: .day, value: dayOffset, to: Date()) ?? Date()
        return Calendar.current.date(byAdding: .hour, value: hourOffset, to: base) ?? Date()
    }
}
