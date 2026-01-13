import SwiftUI
import Foundation

struct ContentView: View {
    
    @State private var firstFieldAmount: String = ""
    @State private var secondFieldAmount: String = ""
    @State private var isInfoButtonPressed: Bool = false
    @State private var isCalculationPressed: Bool = false
    @State private var isClearButtonPressed: Bool = false
    @State private var isAlertShown: Bool = false
    @State private var isSwitchFields: Bool = false
    @State private var firstSelectedCurrency: Currency? = nil
    @State private var secondSelectedCurrency: Currency? = nil
    @State private var alertMessage: CurrencyInputError = .invalidAmount
    @FocusState private var isAmountFocused: Bool
    private var buttonCalculation = Calculation()
    
    private func resetFields() {
        firstFieldAmount = ""
        secondFieldAmount = ""
        firstSelectedCurrency = nil
        secondSelectedCurrency = nil
    }
    
    private func switchFields(_ firstField: inout String, _ secondField: inout String, _ firstCurrency: inout Currency?, _ secondCurrency: inout Currency?) {
        
        isSwitchFields = true
        
        let switching = firstField
        firstField = secondField
        secondField = switching
        
        let switchingCurrency = firstCurrency
        firstCurrency = secondCurrency
        secondCurrency = switchingCurrency
    }
    
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
                    
                    Text("Currency Converter")
                        .font(.largeTitle .bold())
                        .colorInvert()
                    
                    Spacer()
                }
                .colorInvert()
                
                HStack(alignment: .center) {
                    VStack {
                        CurrencyPicker(selectedCurrency: $firstSelectedCurrency, disabled: secondSelectedCurrency)
                        
                        TextField("Enter an amount", text: $firstFieldAmount)
                            .focused($isAmountFocused)
                            .keyboardType(.decimalPad)
                            .frame(width: 150, height: 30)
                            .background(Color(.white))
                            .foregroundStyle(Color.black)
                            .cornerRadius(28)
                    }
                    
                    Button("⇆") {
                        switchFields(&firstFieldAmount, &secondFieldAmount, &firstSelectedCurrency, &secondSelectedCurrency)
                    }
                    .font(.largeTitle .bold())
                    
                    VStack {
                        CurrencyPicker(selectedCurrency: $secondSelectedCurrency, disabled: firstSelectedCurrency)
                        
                        TextField("Enter an amount", text: $secondFieldAmount)
                            .keyboardType(.decimalPad)
                            .frame(width: 150, height: 30)
                            .background(Color(.white))
                            .foregroundStyle(Color.black)
                            .cornerRadius(28)
                            //.disabled(true)
                    }
                    .foregroundStyle(Color.primary)
                }
                .toolbar {
                    ToolbarItem(placement: .keyboard) {
                        Button("Done") {
                            isAmountFocused = false
                        }
                    }
                }
                .padding()
                .frame(maxWidth: 390)
                .foregroundColor(.primary)
                .background(
                    Color.primary
                        .colorInvert()
                        .opacity(0.55)
                        .cornerRadius(28)
                )
                
                HStack(spacing: 20) {
                    Button("Calculate") {
                        
                        guard let from = firstSelectedCurrency, let to = secondSelectedCurrency else {
                            return
                        }
                        let result = buttonCalculation.allCurrencyCalculation(
                                from: from,
                                to: to,
                                amount: firstFieldAmount,
                                errorChecker: &isAlertShown
                            )
                            
                            secondFieldAmount = result
                    }
                    .alert(alertMessage.localizedDescription, isPresented: $isAlertShown) {
                        
                    } message: {
                        Text(alertMessage.errorDescription)
                    }
                    .frame(maxWidth: 150, maxHeight: 50, alignment: .center)
                    .font(.title .bold())
                    .foregroundColor(.black)
                    .background(Color(.white))
                    .cornerRadius(28)
                    .opacity(0.8)
                    
                    Button("Clear") {
                        resetFields()
                    }
                    .frame(maxWidth: 150, maxHeight: 50)
                    .font(.title .bold())
                    .foregroundColor(.red)
                    .background(Color(.white))
                    .cornerRadius(28)
                    .opacity(0.8)
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .offset(y: 180)
                
                Button("?") {
                    isInfoButtonPressed = true
                }
                .frame(maxWidth: 40, maxHeight: 40, alignment: .center)
                .font(.title2 .bold())
                .foregroundColor(.black)
                .background(Color(.white))
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
