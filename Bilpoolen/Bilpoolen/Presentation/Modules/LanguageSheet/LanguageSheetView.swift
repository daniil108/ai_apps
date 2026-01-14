import SwiftUI

struct LanguageSheetView: View {
    @StateObject private var viewModel: LanguageSheetViewModel

    init(viewModel: LanguageSheetViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Language")
                .font(AppFonts.title(18))
                .foregroundStyle(AppColors.navy)
                .padding(.horizontal, 16)

            VStack(spacing: 0) {
                LanguageRow(title: "System (English)", selected: viewModel.selectedLanguage == "System (English)") {
                    viewModel.languageTapped("System (English)")
                }
                Divider()
                LanguageRow(title: "English", selected: viewModel.selectedLanguage == "English") {
                    viewModel.languageTapped("English")
                }
                Divider()
                LanguageRow(title: "Svenska", selected: viewModel.selectedLanguage == "Svenska") {
                    viewModel.languageTapped("Svenska")
                }
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 14, style: .continuous))
            .padding(.horizontal, 16)
        }
        .padding(.bottom, 10)
    }
}

private struct LanguageRow: View {
    let title: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .font(AppFonts.medium(14))
                    .foregroundStyle(AppColors.navy)
                Spacer()
                if selected {
                    Image(systemName: "checkmark")
                        .foregroundStyle(AppColors.accentGreen)
                }
            }
            .padding(14)
        }
        .buttonStyle(.plain)
    }
}
