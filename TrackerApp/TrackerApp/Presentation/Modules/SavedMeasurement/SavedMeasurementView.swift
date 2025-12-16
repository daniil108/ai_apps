import SwiftUI

struct SavedMeasurementView: View {
    @StateObject private var viewModel: SavedMeasurementViewModel

    init(viewModel: SavedMeasurementViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MMMM yyyy, HH:mm"
        return formatter
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                Text(dateFormatter.string(from: viewModel.measurement.timestamp))
                    .font(.system(size: 20, weight: .semibold))
                    .foregroundColor(Theme.text)
                    .frame(maxWidth: .infinity)
                MeasurementValuesGrid(values: viewModel.measurement.values)
                if !viewModel.measurement.comment.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text(viewModel.measurement.comment)
                            .font(.system(size: 15))
                            .foregroundColor(Theme.text)
                        Divider()
                    }
                }
                PrimaryButton(title: "Export measurement", action: {}, leadingSystemImage: "square.and.arrow.up")
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
        }
        .background(Color.white.ignoresSafeArea())
        .navigationTitle("Saved measurement")
        .navigationBarTitleDisplayMode(.inline)
    }
}
