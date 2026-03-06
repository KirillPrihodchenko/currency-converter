import SwiftUI
internal import CoreData
import Foundation

enum transactionStatus: String, Codable {
    case failed
    case successful
    
    var transactionStatusDescription: String {
        switch self {
        case .failed:
            return "Failed"
        case .successful:
            return "Success"
        }
    }
}

struct TransferView: View {
    
    private let txRecordManagerVM: TransactionRecordManager
    private let userManagerVM: UserManager
    
    @State private var firstFieldAmount: String = ""
    @State private var secondFieldAmount: String = ""
    @State private var isInfoButtonPressed: Bool = false
    @State private var isCalculationPressed: Bool = false
    @State private var isClearButtonPressed: Bool = false
    @State private var isAlertShown: Bool = false
    @State private var isSwitchFields: Bool = false
    @State private var firstSelectedCurrency: String?
    @State private var secondSelectedCurrency: String?
    @State private var alertMessage: CurrencyInputError = .invalidAmount
    @FocusState private var isAmountFocused: Bool
    @StateObject var currency = Currency()
    @State var selected: NavigationMenuDecription = .account
    @State private var selectedButton: NavigationMenuDecription = .converter
    private var buttonCalculation = Calculation()
    
    init() {
        let context = PersistenceController.shared.container.viewContext
        txRecordManagerVM = TransactionRecordManager(context: context)
        userManagerVM = UserManager(context: context)
    }
    
    private func resetFields() {
        firstFieldAmount = ""
        secondFieldAmount = ""
        firstSelectedCurrency = nil
        secondSelectedCurrency = nil
    }
    
    private func switchCurrencies(_ firstCurrency: inout String?, _ secondCurrency: inout String?) {
        
        isSwitchFields.toggle()
        
        let switchingCurrency = firstCurrency
        firstCurrency = secondCurrency
        secondCurrency = switchingCurrency
    }
    
    var body: some View {
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
                    
                    Spacer()
                }
                .colorInvert()
                
                HStack(alignment: .center) {
                    VStack {
                        CurrencyPicker(viewModel: currency, currencySelection: $firstSelectedCurrency, disabled: secondSelectedCurrency)
                        
                        TextField("Enter an amount", text: $firstFieldAmount)
                            .padding(.leading)
                            .focused($isAmountFocused)
                            .keyboardType(.decimalPad)
                            .frame(width: 150, height: 30)
                            .background(Color(.white))
                            .foregroundStyle(Color.black)
                            .cornerRadius(28)
                    }
                    
                    Button("⇆") {
                        switchCurrencies(&firstSelectedCurrency, &secondSelectedCurrency)
                    }
                    .font(.largeTitle .bold())
                    
                    VStack {
                        CurrencyPicker(viewModel: currency, currencySelection: $secondSelectedCurrency, disabled: firstSelectedCurrency)
                        
                        TextField("", text: $secondFieldAmount)
                            .padding(.leading)
                            .keyboardType(.decimalPad)
                            .frame(width: 150, height: 30)
                            .background(Color(.white))
                            .foregroundStyle(Color.black)
                            .cornerRadius(28)
                            .disabled(true)
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
                        .cornerRadius(28))
                
                VStack(spacing: 20) {
                    HStack(spacing: 20) {
                        Button("Calculate") {
                            
                            guard let from = firstSelectedCurrency, let to = secondSelectedCurrency else {
                                alertMessage = CurrencyInputError.incorrectCharacter
                                isAlertShown = true
                                return
                            }
                            
                            guard !firstFieldAmount.isEmpty && !firstFieldAmount.contains("-") else {
                                alertMessage = CurrencyInputError.incorrectAmount
                                isAlertShown = true
                                return
                            }
                            
                            let result = buttonCalculation.allCurrencyCalculation(
                                currencies: currency.currencies,
                                from: from,
                                to: to,
                                amount: firstFieldAmount)
                            
                            secondFieldAmount = result as! String
                            
                            let user = userManagerVM.readUserOrAnonymous("")
                                
                            if let user = user {
                            if let record = txRecordManagerVM.createTransactionRecord(currencyFrom: from,
                                                                                      currencyTo: to,
                                                                                      amount: Decimal(string: firstFieldAmount) ?? 0,
                                                                                      result: Decimal(string: secondFieldAmount) ?? 0,
                                                                                      user: user,
                                                                                      status: "Success",
                                                                                      createdAt: Date()) {
                                }
                            }
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
                        .offset(x: 87.5)
                        
                        Button("Clear") {
                            resetFields()
                        }
                        .frame(maxWidth: 150, maxHeight: 50)
                        .font(.title .bold())
                        .foregroundColor(.red)
                        .background(Color(.white))
                        .cornerRadius(28)
                        .opacity(0.8)
                        .offset(x: 87.5)
                        
                        Button("Fetch") {
                            currency.fetchData()
                        }
                        .frame(maxWidth: 150, maxHeight: 50)
                        .font(.title .bold())
                        .foregroundColor(.black)
                        .background(Color(.white))
                        .cornerRadius(28)
                        .opacity(0.8)
                        .offset(x:-160, y: 70)
                    }
                }
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .offset(y: 180)
            }
        }
    }

#Preview {
    TransferView()
}
