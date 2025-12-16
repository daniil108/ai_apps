import SwiftUI

struct SearchView: View {
    @ObservedObject var viewModel: SearchViewModel

    var body: some View {
        VStack(spacing: 12) {
            header
            searchField
            if viewModel.isLoading {
                ProgressView().padding()
            }
            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.yellow)
            }
            List(viewModel.results) { location in
                Button(action: { viewModel.select(location: location) }) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(location.name).font(.headline)
                        Text([location.state, location.country].compactMap { $0 }.joined(separator: ", "))
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                        Text(String(format: "%.3f, %.3f", location.latitude, location.longitude))
                            .font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
            .listStyle(.plain)
        }
        .padding()
        .background(GradientFactory.background(for: "search").ignoresSafeArea())
        .navigationBarBackButtonHidden()
    }

    private var header: some View {
        HStack {
            Button(action: { viewModel.backTapped() }) {
                Image(systemName: "chevron.left")
                    .frame(width: 44, height: 44)
            }
            Spacer()
            Text("Search")
                .font(.title2.bold())
            Spacer()
            Spacer().frame(width: 44)
        }
    }

    private var searchField: some View {
        TextField("City, state, country", text: $viewModel.query)
            .textFieldStyle(.roundedBorder)
            .padding(.bottom, 8)
    }
}
