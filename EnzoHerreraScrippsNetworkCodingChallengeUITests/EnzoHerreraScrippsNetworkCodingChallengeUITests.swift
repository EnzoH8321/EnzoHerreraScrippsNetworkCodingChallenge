//
//  EnzoHerreraScrippsNetworkCodingChallengeUITests.swift
//  EnzoHerreraScrippsNetworkCodingChallengeUITests
//
//  Created by Enzo Herrera on 12/18/21.
//

import XCTest

class EnzoHerreraScrippsNetworkCodingChallengeUITests: XCTestCase {

	let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

	override func setUp() {
		super.setUp()
		self.app.launch()
	}


	//Main View
	func testExistanceOfComponents() throws {

		let searchBar = app.textFields["Search Field"]
		let button = app.buttons["Search"]
		let image = app.buttons["Filter Button"]
		
		XCTAssert(searchBar.exists)
		XCTAssert(button.exists)
		XCTAssert(image.exists)
	}

	func testTextFieldReceivesData() {
		let mainViewTextField = self.app.textFields["Search Field"]
		mainViewTextField.tap()
		mainViewTextField.typeText("Bon jovi")

		XCTAssertEqual("Bon jovi", mainViewTextField.value as! String)
	}

	//By Existing, we can see that the tap successful navigated to the FilterView
	func testfilterButtonGoesToFilterScreen() {
		//Navigation Link tap
		let filterButton = self.app.buttons["Filter Button"]
		filterButton.tap()

		let mediaPicker = self.app.staticTexts["Media Type"]

		XCTAssert(mediaPicker.exists)
	}

	func testListAppearsAfterGoodSearchTerm() {
		let mainViewTextField = self.app.textFields["Search Field"]
		mainViewTextField.tap()
		mainViewTextField.typeText("Bon jovi")

		let searchButton = self.app.buttons["Search Button"]
		searchButton.tap()
		//By existing, we can see that the list appeared
		let listCell = self.app.buttons["List Cell"]

		XCTAssert(listCell.waitForExistence(timeout: 6))
	}

	func testListDoesNotAppearAfterBadSearchTerm() {
		let mainViewTextField = self.app.textFields["Search Field"]
		mainViewTextField.tap()
		mainViewTextField.typeText("zdfgzxb vxcvzgxcv")

		let searchButton = self.app.buttons["Search Button"]
		searchButton.tap()

		let listCell = self.app.buttons["List Cell"]
		//When we type a search term that will return an error, we do not want to see a list appear.
		XCTAssertFalse(listCell.waitForExistence(timeout: 6))
	}

}
