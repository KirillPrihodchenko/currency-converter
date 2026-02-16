import Foundation


enum CurrencyInputError: Error, LocalizedError {
    
    case invalidAmount
    case incorrectCharacter
    case errorDataFetch
    case negativeAmount
}
