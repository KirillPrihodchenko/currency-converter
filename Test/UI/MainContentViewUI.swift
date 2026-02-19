import XCTest

final class MainContentViewUI: XCTestCase {
    
    private let app = XCUIApplication()
    
    override func setUpWithError() throws {
        continueAfterFailure = false
        app.launch()
    }
    
    func fetchCurrencyData() {
        app.buttons["Fetch"].tap()
        sleep(3)
    }
    
    func generalAlertPattern(_ alertStaticText: String) {
        
        let alert = app.alerts.firstMatch
        XCTAssertTrue(alert.waitForExistence(timeout: 1))
        XCTAssertTrue(alert.staticTexts[alertStaticText].exists)
        alert.buttons["OK"].tap()
        XCTAssertFalse(alert.exists)
    }
    
    func testWholeInterface() throws {
        
        fetchCurrencyData()
        app.buttons.matching(identifier: "currencySelection").element(boundBy: 0).tap()
        app.swipeUp()
        XCTAssertTrue(app.buttons["USD"].exists, "USD is not available")
        app.buttons["USD"].tap()
        
        app.buttons.matching(identifier: "currencySelection").element(boundBy: 1).tap()
        XCTAssertTrue(app.buttons["EUR"].exists, "EUR is not available")
        app.buttons["EUR"].tap()
        
        let amountTextField = app.textFields["Enter an amount"].firstMatch
        amountTextField.tap()
        amountTextField.typeText("100")
        
        app.buttons["Done"].tap()
        app.buttons["Calculate"].tap()
        
        
        let resultTextField = amountTextField.value as? String
        XCTAssertTrue(!resultTextField!.isEmpty)
        
        app.buttons["⇆"].tap()
        app.buttons["Calculate"].tap()
        XCTAssertTrue(!resultTextField!.isEmpty)
        
        app.buttons["Clear"].tap()
        let firstValue = amountTextField.value as? String
        XCTAssertTrue(firstValue!.isEmpty)
        let firstMenu = app.buttons.matching(identifier: "currencySelection").element(boundBy: 0)
        let secondMenu = app.buttons.matching(identifier: "currencySelection").element(boundBy: 1)
        XCTAssertTrue(firstMenu.label.contains("Select currency"))
        XCTAssertTrue(secondMenu.label.contains("Select currency"))
    }
    
    func testNegativeAmountTextField() throws {
        
        fetchCurrencyData()
        app.buttons.matching(identifier: "currencySelection").element(boundBy: 0).tap()
        app.swipeUp()
        XCTAssertTrue(app.buttons["USD"].exists, "USD is not available")
        app.buttons["USD"].tap()
        
        app.buttons.matching(identifier: "currencySelection").element(boundBy: 1).tap()
        XCTAssertTrue(app.buttons["EUR"].exists, "EUR is not available")
        app.buttons["EUR"].tap()
        
        let negativeAmountTextField = app.textFields["Enter an amount"].firstMatch
        negativeAmountTextField.tap()
        negativeAmountTextField.typeText("-100")
        
        app.buttons["Done"].tap()
        app.buttons["Calculate"].tap()
        
        generalAlertPattern("Negative amount")
    }
    
    func testSelectedOnlyOneCurrencyAndInputAmount() throws {
        
        fetchCurrencyData()
        app.buttons.matching(identifier: "currencySelection").element(boundBy: 0).tap()
        app.swipeUp()
        XCTAssertTrue(app.buttons["USD"].exists, "USD is not available")
        app.buttons["USD"].tap()
        
        let amountTextField = app.textFields["Enter an amount"].firstMatch
        amountTextField.tap()
        amountTextField.typeText("100")
        
        app.buttons["Done"].tap()
        app.buttons["Calculate"].tap()
        
        generalAlertPattern("Incorrect character")
    }
    
    
}
