import SwiftUI

struct TestView: View {
        
    @StateObject var currency = CurrencyA()
    
    var body: some View {
            
        ZStack {
            Image("background")
            
            
            List {
                ForEach(currency.currencies.sorted(by: { $0.key < $1.key }), id: \.key) { value in
                    HStack {
                        Text("\(value.key): \(value.value)")
        
                    }
                }
            }
            .frame(maxWidth: 350, maxHeight: 600, alignment: .center)
            .scrollContentBackground(.hidden)
            
            VStack {
                Button("Fetch") {
                    currency.fetchData()
                }
                .position(x: 375, y: 900)
            }
        }
    }
}

#Preview {
    TestView()
}
