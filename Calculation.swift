import Foundation

final class Calculation {
        
    func allCurrencyCalculation(
        from: Currency,
        to: Currency,
        amount: String,
        errorChecker: inout Bool) -> String {
            
            guard let value = Int(amount) else {
                let noEnteredAmount: String = CurrencyInputError.incorrectCharacter.localizedDescription
                errorChecker = true
                
                return noEnteredAmount
            }
            
            switch (from, to) {
                case(.bronze, .silver):
                    guard value >= 5 else {
                        let invalidAmount: String = CurrencyInputError.invalidAmount.localizedDescription
                        errorChecker = true
                        return invalidAmount
                    }
                    return String(value / 5)
                
                case(.bronze, .gold):
                    guard value >= 25 else {
                        let invalidAmount: String = CurrencyInputError.invalidAmount.localizedDescription
                        errorChecker = true
                        return invalidAmount
                }
                    return String(value / 25)
                
                case(.silver, .bronze):
                    return String(value * 5)
            
                case(.silver, .gold):
                    return String(value / 5)
                
                case(.gold, .silver):
                    return String(value * 5)
                
                case(.gold, .bronze):
                    return String(value * 25)
                
                default:
                    return ""
            }
    }
}
