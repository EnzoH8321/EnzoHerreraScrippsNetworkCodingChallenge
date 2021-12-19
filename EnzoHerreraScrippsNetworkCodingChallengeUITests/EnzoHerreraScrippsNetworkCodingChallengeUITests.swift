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


	//Main View
	func testExistanceOfComponents() throws {

		let searchBar = app.textFields["Search Prompt"]
		let button = app.buttons["Search"]
		let image = app.images.element
		let list = app.staticTexts["list of returned results"]
		
		XCTAssert(searchBar.exists)
		XCTAssert(button.exists)
		XCTAssert(image.exists)
	}

	//FilterSettingsview

	func testEntityPicker() {

		let picker = app.pickerWheels.element
		XCTAssert(picker.exists)

	}


}
