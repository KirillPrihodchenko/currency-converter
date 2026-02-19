import Testing
@testable import iosLiosLessonsssons

struct CalculationTests {

    private let calculation = Calculation()
    private let mockCurrencies = ["USD": 1.0, "EUR": 0.85]
    
    @Test func convertToCurrencyWithRateLessThanOne() async throws {
        
        #expect(calculation.allCurrencyCalculation(
            currencies: mockCurrencies,
            from: "USD",
            to: "EUR",
            amount: "1000") as! String == "850.0000")
    }
    
    @Test func convertToCurrencyWithRateGreaterThanOne() async throws {
        
        #expect(calculation.allCurrencyCalculation(
            currencies: mockCurrencies,
            from: "EUR",
            to: "USD",
            amount: "1000") as! String == "1176.4706")
    }
    
    @Test func convertWithNegativeAmount() async throws {
        
        #expect(calculation.allCurrencyCalculation(
            currencies: mockCurrencies,
            from: "USD",
            to: "EUR",
            amount: "-1000") as! String == CurrencyInputError.invalidAmount.localizedDescription)
    }
    
    // this test expect 'inf' because of value <from> or <to> is Double? currencies[from] ?? 0
    @Test func convertWithInvalidCurrency() async throws {
    
        #expect(calculation.allCurrencyCalculation(
            currencies: mockCurrencies,
            from: " ",
            to: "EUR",
            amount: "10") as! String == "inf")
    }
}
