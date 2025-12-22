import SwiftUI

struct CurrencyPicker: View {
    
    @Binding var selectedCurrency: Currency?
    let disabled: Currency?

    var body: some View {
        Menu {
            ForEach(Currency.allCases, id: \.self) { currency in
                Button {
                    if currency != disabled {
                        selectedCurrency = currency
                    }
                } label: {
                    HStack {
                        Image(currency.imageName)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 24, height: 24)
                        Text(currency.rawValue)
                    }
                }
            }
        } label: {
            HStack {
                if let selected = selectedCurrency {
                    Image(selected.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 24, height: 24)
                    Text(selected.rawValue)
                } else {
                    Image(systemName: "chevron.down")
                    Text("Select currency")
                        
                }
            }
            .background()
            .frame(alignment: .center)
            .cornerRadius(8)
        }
    }
}

#Preview {
    CurrencyPicker(selectedCurrency: .constant(.gold), disabled: .gold)
}
