import XCTest
@testable import ViaCep

final class MainViewUITests: XCTestCase {
    func test_launch_whenSearchSomeCep_shouldReturnAValidCep() {
        let app = XCUIApplication()
        app.launch()
                
        let textField = app.textFields["Digite um cep válido"]
        XCTAssertTrue(textField.exists)
        
        textField.tap()
        textField.typeText("01150011")
        
        let searchButton = app/*@START_MENU_TOKEN@*/.buttons["Buscar Cep"].staticTexts["Buscar Cep"]/*[[".buttons[\"Buscar Cep\"].staticTexts[\"Buscar Cep\"]",".staticTexts[\"Buscar Cep\"]"],[[[-1,1],[-1,0]]],[1]]@END_MENU_TOKEN@*/
        XCTAssertTrue(searchButton.exists)
        
        searchButton.tap()
    }
}
