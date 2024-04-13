import XCTest
@testable import ViaCep

final class MainViewUITests: XCTestCase {
    func test_launch_whenSearchSomeCep_shouldReturnAValidCep() {
        let app = XCUIApplication()
        app.launch()
                
        let digiteUmCepVLidoTextField = app.textFields["Digite um cep válido"]
        digiteUmCepVLidoTextField.tap()
        digiteUmCepVLidoTextField.typeText("01150011")
        
        let buscarCepStaticText = app/*@START_MENU_TOKEN@*/.staticTexts["Buscar Cep"]/*[[".buttons[\"Buscar Cep\"].staticTexts[\"Buscar Cep\"]",".staticTexts[\"Buscar Cep\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/
        buscarCepStaticText.tap()
        buscarCepStaticText.tap()
        app.alerts["ALERT ⚠️"].scrollViews.otherElements.buttons["FECHAR"].tap()
        XCTAssertEqual(app.firstMatch.staticTexts.count, 2)
    }
}
