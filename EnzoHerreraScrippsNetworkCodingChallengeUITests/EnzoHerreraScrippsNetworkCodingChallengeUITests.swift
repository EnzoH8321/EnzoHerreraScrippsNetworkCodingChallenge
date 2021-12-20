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
		let image = app.images.element
		let list = app.staticTexts["list of returned results"]
		
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

	func testListAppearsAfterBadSearchTerm() {
		let mainViewTextField = self.app.textFields["Search Field"]
		mainViewTextField.tap()
		mainViewTextField.typeText("Jamal")

		let searchButton = self.app.buttons["Search Button"]
		searchButton.tap()

		let listCell = self.app.buttons["List Cell"]
		//When we type a search term that will return an error, we do not want to see a list appear.
		XCTAssertFalse(listCell.waitForExistence(timeout: 6))
	}

//	//
//	func testClickingOnCellGoesToDetailView() {
//		let mainViewTextField = self.app.textFields["Search Field"]
//		mainViewTextField.tap()
//		mainViewTextField.typeText("Bon Jovi")
//
//		let searchButton = self.app.buttons["Search Button"]
//		searchButton.tap()
//
//		let listCell = app.segmentedControls["List"]
//
//		let text = self.app.staticTexts["Detail Track Name"]
//
//		XCTAssert(listCell.exists)
//		XCTAssert(listCell.waitForExistence(timeout: 15))
//	}
//
//	//Filters View
//	func testIfTheFiltersChangeSearchTerms() {
//		let mainViewTextField = self.app.textFields["Search Field"]
////		mainViewTextField.tap()
////		mainViewTextField.typeText("Bon Jovi")
//
//		//Navigation Link tap
//		let filterButton = self.app.buttons["Filter Button"]
//		filterButton.tap()
//
//		let mediaPicker = self.app.pickers["Media Type Picker"]
////		let backButton = self.app.navigationBars.buttons.element(boundBy: 0)
////		backButton.tap()
//
//
//		XCTAssert(mediaPicker.waitForExistence(timeout: 2))
//
//	}



}
