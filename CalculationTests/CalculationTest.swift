import Testing
@testable import iosLiosLessonsssons

struct CalculationTests {

    let calculation = Calculation()
    let mockCurrencies = ["USD": 1.0, "EUR": 0.85]
    
    @Test func convert_to_currency_with_rate_less_than_one() async throws {
        
        #expect(calculation.allCurrencyCalculation(
            currencies: mockCurrencies,
            from: "USD",
            to: "EUR",
            amount: "1000") as! String == "850.0")
    }
    
    @Test func convert_to_currency_with_rate_greater_than_one() async throws {
        
        #expect(calculation.allCurrencyCalculation(
            currencies: mockCurrencies,
            from: "EUR",
            to: "USD",
            amount: "1000") as! String == "1176.4705882352941")
    }
    
    @Test func convert_with_negative_amount() async throws {
        
        #expect(calculation.allCurrencyCalculation(
            currencies: mockCurrencies,
            from: "USD",
            to: "EUR",
            amount: "-1000") as! String == CurrencyInputError.invalidAmount.localizedDescription)
    }
    
    // this test expect 'inf' because of value <from> or <to> is Double? currencies[from] ?? 0
    @Test func convert_with_invalid_currency() async throws {
    
        #expect(calculation.allCurrencyCalculation(
            currencies: mockCurrencies,
            from: " ",
            to: "EUR",
            amount: "10") as! String == "inf")
    }
}
