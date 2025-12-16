import SwiftUI

struct MeasurementRowView: View {
    let measurement: Measurement

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy, HH:mm"
        return formatter
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(dateFormatter.string(from: measurement.timestamp))
                .font(.system(size: 15, weight: .semibold))
                .foregroundColor(Theme.text)
            VStack(alignment: .leading, spacing: 2) {
                valueRow(title: "Gauge", value: measurement.values.gauge)
                valueRow(title: "Check gauge", value: measurement.values.checkGauge)
                valueRow(title: "Flangeway Clearance", value: measurement.values.flangewayClearance)
                valueRow(title: "Cant", value: measurement.values.cant, prefix: "+")
                valueRow(title: "Back-to-Back", value: measurement.values.backToBack)
            }
        }
        .padding(12)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Theme.border, lineWidth: 1)
                .background(RoundedRectangle(cornerRadius: 12).fill(Color.white))
        )
    }

    private func valueRow(title: String, value: Double, prefix: String = "") -> some View {
        HStack {
            Text(title)
                .font(.system(size: 13))
                .foregroundColor(Theme.text)
            Spacer()
            Text("\(prefix)\(String(format: "%.1f", value)) mm")
                .font(.system(size: 13, weight: .semibold))
                .foregroundColor(Theme.text)
        }
    }
}
