import Foundation

extension CurrencyInputError {
    
    var localizedDescription: String {
        switch self {
        case .invalidAmount:
            return "Invalid amount"
        case .incorrectCharacter:
            return "Incorrect character"
        case .errorDataFetch:
            return "Error data fetch"
        case .incorrectAmount:
            return "Incorrect amount"
        case .invalidCurrencyCode:
            return "Invalid currency code"
        case .userEmailExists:
            return "Email already exists"
        case .userUsernameExists:
            return "Username already exists"
        case .userNotFound:
            return "User not found"
        }
    }
    
    var errorDescription: String {
        switch self {
            case .invalidAmount:
                return "Should be more than current amount"
            case .incorrectCharacter:
                return "Please make sure you are entering the correct characters or try to convert to another currency"
            case .errorDataFetch:
                return "Something went wrong while fetching the API"
            case .incorrectAmount:
                return "Should be more than current amount"
            case .invalidCurrencyCode:
                return "Currency with this code may not exists"
            case .userEmailExists:
                return "User with email this already exists"
            case .userUsernameExists:
                return "User with username this already exists"
            case .userNotFound:
                return "User with this username or password does not exists"
        }
    }
}
