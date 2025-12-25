import Foundation

final class Calculation {
    
    func allCurrencyCalculation(
        from: Currency,
        to: Currency,
        amount: String) -> String {
            guard let value = Int(amount) else { return "0" }
            
            switch (from, to) {
                case(.bronze, .silver):
                    return String(value / 5)
                
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
