import SwiftUI

struct NewMeasurementView: View {
    @StateObject private var viewModel: NewMeasurementViewModel

    init(viewModel: NewMeasurementViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                MeasurementValuesGrid(values: viewModel.values)
                VStack(alignment: .leading, spacing: 8) {
                    Text("Comment")
                        .font(.system(size: 15, weight: .semibold))
                        .foregroundColor(Theme.text)
                    TextField("Enter comment", text: $viewModel.comment, axis: .vertical)
                        .padding(12)
                        .frame(minHeight: 44)
                        .background(RoundedRectangle(cornerRadius: 6).stroke(Theme.border))
                }
                PrimaryButton(title: "Save measurement", action: { viewModel.onSaveTapped() }, leadingSystemImage: "square.and.arrow.down", isLoading: viewModel.isSaving)
            }
            .padding(.horizontal, 16)
            .padding(.bottom, 40)
        }
        .background(Color.white.ignoresSafeArea())
        .onAppear { viewModel.onAppear() }
        .onDisappear { viewModel.onDisappear() }
        .navigationTitle("New measurement")
        .navigationBarTitleDisplayMode(.inline)
    }
}
