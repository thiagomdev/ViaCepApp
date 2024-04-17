import XCTest
import FBSnapshotTestCase

@testable import ViaCep

final class MainTests: FBSnapshotTestCase {
    
}

final class MainViewUITests: XCTestCase {
    func test_mainViewController_launch() {
        let app = XCUIApplication()
        app.launch()

        let textField = app.textFields["inputedCepTextField"]
        XCTAssertTrue(textField.exists)
        
        textField.tap()
        textField.typeText("01150011")
        
        let searchButton = app.buttons["searchCepButton"]
        XCTAssertTrue(searchButton.exists)
        XCTAssertTrue(searchButton.isEnabled)
        searchButton.tap()
        
        let labelLogradouro = app.otherElements.staticTexts["Logradouro: Praça Marechal Deodoro"]
        XCTAssertTrue(labelLogradouro.exists)
        
        let labelBairro = app.otherElements.staticTexts["Bairro: Santa Cecília"]
        XCTAssertTrue(labelBairro.exists)
        
        let labelLocalidade = app.otherElements.staticTexts["Localidade: São Paulo"]
        XCTAssertTrue(labelLocalidade.exists)
    }
}
