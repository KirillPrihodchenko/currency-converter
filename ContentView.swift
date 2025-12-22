import SwiftUI
import Foundation

struct ContentView: View {
    
    @State private var firstFieldAmount: String = ""
    @State private var secondFieldAmount: String = ""
    @State private var isInfoButtonPressed: Bool = false
    @State private var isCalculationPressed: Bool = false
    @State private var firstSelectedCurrency: Currency? = nil
    @State private var secondSelectedCurrency: Currency? = nil
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                Image("background")
                    .saturation(0.69)
                    .blur(radius: 0.849)
                
                
                VStack {
                    Spacer().frame(height: 180)
                    Image("exchange")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100)
                        .colorInvert()
                    
                    Text("Currency Converter")
                        .font(.largeTitle .bold())
                        .colorInvert()
                    
                    Spacer()
                }
                
                HStack(alignment: .center) {
                    
                    VStack {

                        CurrencyPicker(selectedCurrency: $firstSelectedCurrency, disabled: secondSelectedCurrency)
                        
                        TextField("Enter an amount", text: $firstFieldAmount)
                            .keyboardType(.decimalPad)
                            .frame(width: 150, height: 30)
                            .background()
                            .cornerRadius(28)
                        
                    }
              
                    VStack {
                        Text("=")
                            .font(.largeTitle .bold())
                    }
                    
                    VStack {
                        
                        CurrencyPicker(selectedCurrency: $secondSelectedCurrency, disabled: firstSelectedCurrency)
                        
                        TextField("Enter an amount", text: $secondFieldAmount)
                            .keyboardType(.decimalPad)
                            .frame(width: 150, height: 30)
                            .background()
                            .cornerRadius(28)
                    }
                }
                .padding()
                .frame(maxWidth: 380)
                .foregroundColor(.primary)
                .background(Color.primary
                    .colorInvert()
                    .opacity(0.55)
                    .cornerRadius(28))
                
                HStack(spacing: 20) {
                    Button("Calculate") {
                        
                    }
                    .frame(maxWidth: 150, maxHeight: 50, alignment: .center)
                    .font(.title .bold())
                    .foregroundColor(.black)
                    .background()
                    .cornerRadius(28)
                    .opacity(0.8)
                 
                    Button("Clear") {
                        
                    }
                    .frame(maxWidth: 150, maxHeight: 50)
                    .font(.title .bold())
                    .foregroundColor(.red)
                    .background()
                    .cornerRadius(28)
                    .opacity(0.8)

                }
                .frame(maxWidth: .infinity)
                .offset(y: 180)
                    
                Button("?"){
                    
                    isInfoButtonPressed = true
                }
                .frame(maxWidth: 40, maxHeight: 40, alignment: .center)
                .font(.title2 .bold())
                .foregroundColor(.black)
                .background()
                .opacity(0.55)
                .cornerRadius(60)
                .position(x: 530, y: 920)
                .navigationDestination(isPresented: $isInfoButtonPressed) {
                    RedirectionInfo()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
