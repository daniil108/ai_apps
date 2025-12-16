import SwiftUI

struct MeasurementValuesGrid: View {
    let values: MeasurementValues

    var body: some View {
        VStack(spacing: 16) {
            VStack(spacing: 2) {
                Text(String(format: "%.1f", values.gauge))
                    .font(.system(size: 42, weight: .semibold))
                    .foregroundColor(Theme.text)
                    .kerning(-1)
                HStack(spacing: 4) {
                    Text("mm")
                        .font(.system(size: 22, weight: .semibold))
                        .foregroundColor(Theme.text)
                    Text("Gauge")
                        .font(.system(size: 15))
                        .foregroundColor(Theme.mutedText)
                }
            }
            HStack(alignment: .top, spacing: 32) {
                VStack(spacing: 12) {
                    metric(title: "Check gauge", value: values.checkGauge)
                    metric(title: "Cant", value: values.cant, prefix: "+")
                }
                VStack(spacing: 12) {
                    metric(title: "Flangeway Clearance", value: values.flangewayClearance)
                    metric(title: "Back-to-Back", value: values.backToBack)
                }
            }
        }
    }

    private func metric(title: String, value: Double, prefix: String = "") -> some View {
        VStack(spacing: 2) {
            Text("\(prefix)\(String(format: "%.1f", value)) mm")
                .font(.system(size: 26, weight: .semibold))
                .foregroundColor(Theme.text)
            Text(title)
                .font(.system(size: 13))
                .foregroundColor(Theme.mutedText)
        }
    }
}
