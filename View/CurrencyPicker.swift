import SwiftUI

struct CurrencyPicker: View {
    
    @ObservedObject var viewModel: Currency
    @Binding var currencySelection: String?
    var disabled: String?
    private var sortedCurrencies: [(key: String, value: Double)] {
        viewModel.currencies.sorted { $0.key < $1.key }
    }
   
    var body: some View {
        Menu {
            ForEach(sortedCurrencies, id: \.key) { element in
                Button {
                   currencySelection = element.key
                } label: {
                    Text(element.key)
                }
                .disabled(element.key == disabled)
            }
        } label: {
            HStack {
                if let selected = currencySelection {
                    Text(selected)
                    Image(systemName: "chevron.down")
                }
                else {
                    Text("Select currency")
                    Image(systemName: "chevron.down")
                }
            }
        }
        .accessibilityIdentifier("currencySelection")
    }
}   

#Preview {
    
    let mockCurrencies: [String: Double] = [
        "USD": 1.0,
        "EUR": 0.92,
    ]
    let mockViewModel = Currency()
    mockViewModel.currencies = mockCurrencies

    return PreviewWrapper(viewModel: mockViewModel)
}

    private struct PreviewWrapper: View {
        @ObservedObject var viewModel: Currency
        @State private var selection: String? = "Select currency"

        var body: some View {
            CurrencyPicker(viewModel: viewModel, currencySelection: $selection, disabled: selection)
                .padding()
        }
}
