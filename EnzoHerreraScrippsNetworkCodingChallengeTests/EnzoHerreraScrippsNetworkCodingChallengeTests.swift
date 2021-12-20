//
//  EnzoHerreraScrippsNetworkCodingChallengeTests.swift
//  EnzoHerreraScrippsNetworkCodingChallengeTests
//
//  Created by Enzo Herrera on 12/18/21.
//

import XCTest
@testable import EnzoHerreraScrippsNetworkCodingChallenge



class EnzoHerreraScrippsNetworkCodingChallengeTests: XCTestCase {

	var sut: MainViewModel!

	override func setUpWithError() throws {
		try super.setUpWithError()
		sut = MainViewModel()
	}

	override func tearDownWithError() throws {
		try super.tearDownWithError()
		sut = nil
	}


	//Networking
	func testValidApiCallGetsAGoodResponse() throws {

		//Taken from Apple docs so this link should theoretically always work.
		let urlString = "https://itunes.apple.com/search?term=jack+johnson"
		let url = URL(string: urlString)!


		let promise = expectation(description: "Status code: 200")


		let dataTask = URLSession.shared.dataTask(with: url) { _, response, error in

			if let error = error {

				XCTFail("Error: \(error.localizedDescription)")
				return

			} else if let statusCode = (response as? HTTPURLResponse)?.statusCode {

				if statusCode == 200 {
					// 2
					promise.fulfill()
				} else {
					XCTFail("Status code: \(statusCode)")
				}

			}
		}

		dataTask.resume()

		wait(for: [promise], timeout: 5)
	}


	func testNoParameterWorks() {
		let expectation = XCTestExpectation(description: "No Parameter returns valid data")

		mockFetchDatafromItunesAPI(forTerm: "Rolling Stones", forEntities: .none) { result in

			switch result {
			case .success(let success):
				expectation.fulfill()
			case .failure(let error):
				print("Fail")
			}

		}

		wait(for: [expectation], timeout: 10)

	}


	func testLimitParameterWorks() {

		let expectation = XCTestExpectation(description: "Data stayed within Limit Parameter.")

		mockFetchDatafromItunesAPI(forTerm: "Adele", forEntities: .none) { result in

			switch result {
			case .success(let success):

				if (success.count < 26 && success.count != 0 ) {
					expectation.fulfill()
				}

			case .failure(let error):
				print("Fail")
			}

		}

		wait(for: [expectation], timeout: 10)
	}

	//TODO: iTunes sometimes returns different entity results each query. Have not been able to figure out why. Further testing needs to be done with the entity parameter. For now, works about 90% of the time. 
	func testEntityParameterWorks() {

		let expectation = XCTestExpectation(description: "Data stayed within Entity Parameter")

		mockFetchDatafromItunesAPI(forTerm: "Tom Cruise", forEntities: .movie) { result in

			switch result {
			case .success(let success):
			//Array of Itunes Data
			let tempData = success
				//If any element does not contain the entity, fails.
				for element in tempData {
					//Hard coded string below.
					if ((element.kind?.contains("movie")) == nil)  {
						XCTFail()
					} else {
						expectation.fulfill()
					}
				}

			case .failure(let error):
				XCTFail()
			}

		}

		wait(for: [expectation], timeout: 10)
	}

	func testInvalidTermShowsError() {

		let expectation = XCTestExpectation(description: "Invalid term fails successfully")

		mockFetchDatafromItunesAPI(forTerm: "sdfgsdfcvb", forEntities: .movie) { result in

			switch result {
			case .success(let success):
				XCTFail("Successfully Ran")

			case .failure(let error):
				expectation.fulfill()
			}

		}

		wait(for: [expectation], timeout: 10)
	}



}

//Create extension function that fakes fetchData from Itunes.
//TODO: For bigger projects/more thorough coverage, you can put these into seperate classes with custom data.

extension EnzoHerreraScrippsNetworkCodingChallengeTests {

	func mockFetchDatafromItunesAPI(forTerm term: String, forEntities entity: iTunesEntities, completionHandler: @escaping (Result<[iTunesGeneralModel], NetworkError>) -> Void) {

		//Tests to see if a user selected an entity from the settings view
		var entityType: String {
			return entity.rawValue
		}

		var urlComponents = URLComponents()
		urlComponents.scheme = "https"
		urlComponents.host = "itunes.apple.com"
		urlComponents.path = "/search"
		urlComponents.queryItems = [
			URLQueryItem(name: "term", value: term),
			URLQueryItem(name: "limit", value: "25"),
			//Add a query if the user selected an entity. If not, set empty values.)
			//TODO: When you include more filters, add them as URLQueryItem's.
			entityType != iTunesEntities.none.rawValue ? URLQueryItem(name: "entity", value: "\(entityType)") : URLQueryItem(name: "entity", value: "movie, podcast, musicVideo, mix, audiobook, allTrack")
		]

		//Possibility url could come back invalid
		guard let url = urlComponents.url else {
			completionHandler(.failure(.invalidUrlError))
			return
		}

		var request = URLRequest(url: url)
		request.httpMethod = "GET"

		URLSession.shared.dataTask(with: request) { data, response, error in

			DispatchQueue.main.async {

				if (error != nil) {
					completionHandler(.failure(.decodingError))
				}

				if let verifiedData = data {

					do {
						let decodedJSONValue = try JSONDecoder().decode(iTunesResponseMain.self, from: verifiedData).results

						//Empty array means that no matches to the query were found
						if (decodedJSONValue.count == 0) {
							self.sut.viewModelSetNewiTunesData(forData: decodedJSONValue)
							completionHandler(.failure(.noReturnedResultsError))
							print("Nothing Found")
						} else {
							self.sut.viewModelSetNewiTunesData(forData: decodedJSONValue)
							completionHandler(.success(decodedJSONValue))
							print("success")
						}


					} catch let error as NSError {
						//Failure most likely means there was an issue decoding the JSON.
						completionHandler(.failure(.decodingError))
						print(error)
					}

				}

			}

		}.resume()


	}
}
