import Foundation


enum CurrencyInputError: Error, LocalizedError {
    
    case invalidAmount
    case incorrectCharacter
    case errorDataFetch
    case incorrectAmount
    case invalidCurrencyCode
    case userEmailExists
    case userUsernameExists
    case userNotFound
}
