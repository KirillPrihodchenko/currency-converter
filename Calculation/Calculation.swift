import Foundation

final class Calculation {
        
    func allCurrencyCalculation(
        currencies: [String: Double],
        from: String,
        to: String,
        amount: String) -> Any {
            
            let extendedCurrenciesKey = Array(currencies.keys)
            let extendedValueFrom = currencies[from] ?? 0
            let extendedValueTo = currencies[to] ?? 0
            let convertedAmount: Double = Double(amount) ?? 0
            var result = 0.0
            
            for (_, value) in extendedCurrenciesKey.enumerated() {
                
                if amount.contains("-") {
                    return CurrencyInputError.invalidAmount.localizedDescription
                }
                
                guard value.contains(from) && value.contains(to) && extendedValueTo <= 1 else {
                    result = convertedAmount / extendedValueFrom * extendedValueTo
                    return String(result)
                }
                
                result = convertedAmount / extendedValueFrom / extendedValueTo
                return String(result)
        }
            return CurrencyInputError.invalidCurrencyCode.localizedDescription
    }
}
