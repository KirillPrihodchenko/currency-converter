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
        }
    }
    
    var errorDescription: String {
        switch self {
            case .invalidAmount:
                return "Should be more than current amount"
            case .incorrectCharacter:
                return "Should be number"
            case .errorDataFetch:
            return "Something went wrong while fetching the API"
        }
    }
}
