import Foundation

extension CurrencyInputError {
    
    var localizedDescription: String {
        switch self {
        case .invalidAmount:
            return "Invalid Amount"
        case .incorrectCharacter:
            return "Incorrect character"
        case .errorDataFetch:
            return "Error data fetch"
        case .negativeAmount:
            return "Negative amount"
        case .invalidCurrencyCode:
            return "Invalid currency code"
        }
    }
    
    var errorDescription: String {
        switch self {
            case .invalidAmount:
                return "Should be more than current amount"
            case .incorrectCharacter:
                return "Please choose another currency"
            case .errorDataFetch:
                return "Something went wrong while fetching the API"
            case .negativeAmount:
                return "Should be more than current amount"
            case .invalidCurrencyCode:
            return "Currency with this code may not exists"
        }
    }
}
