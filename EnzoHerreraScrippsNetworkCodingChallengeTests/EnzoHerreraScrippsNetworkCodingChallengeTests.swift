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

	func testLimitParameterWorks() {

		let dataArray = sut.dataModel.arrayOfItunesData
		let expectation = XCTestExpectation(description: "Array Successfully filled Model with Data")

		mockFetchDatafromItunesAPI(forTerm: "Adele", forEntities: .none) { result in

			switch result {
			case .success(let success):
				print("")
				print(dataArray.count)
				expectation.fulfill()
			case .failure(let error):
				print("")
			}

		}

		wait(for: [expectation], timeout: 10)
	}


}

//Create extension function that fakes fetchData from Itunes. For bigger projects/more thorough coverage, you can put these into seperate classes.

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
