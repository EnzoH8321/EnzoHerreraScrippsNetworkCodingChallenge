//
//  MainViewModel.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import Foundation

class MainViewModel: ObservableObject {

	//Set the dataModel as a Publisher to allow easy view refreshes
	@Published var dataModel = MainModel()
//	@Published var error: ErrorEnum?

	var viewModelArrayOfItunesData: [iTunesGeneralModel] {
		return self.dataModel.arrayOfItunesData
	}

	var viewModelEntityValue: iTunesEntities {
		return self.dataModel.entityValue
	}

	//Functions
	func viewModelSetNewiTunesData(forData data: [iTunesGeneralModel]) {
		dataModel.setNewItunesData(forData: data)
	}

	func viewModelSetNewEntityfilter(forEntity entity: iTunesEntities) {
		dataModel.setNewEntityFilter(forEntity: entity)
	}
	
}

//Networking Code
extension MainViewModel {
	//As you add more filters, you must also include them as arguments to this function
	func fetchDatafromItunesAPI(forTerm term: String, forEntities entity: iTunesEntities, completionHandler: @escaping (Result<[iTunesGeneralModel], NetworkError>) -> Void) {

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

		print(request)

		URLSession.shared.dataTask(with: request) { data, response, error in

			DispatchQueue.main.async {

			if let verifiedData = data {

				do {
					let decodedJSONValue = try JSONDecoder().decode(iTunesResponseMain.self, from: verifiedData).results


						self.objectWillChange.send()

						//Empty array means that no matches to the query were found
						if (decodedJSONValue.count == 0) {
							self.viewModelSetNewiTunesData(forData: decodedJSONValue)
							completionHandler(.failure(.noReturnedResultsError))
							print("nothing found")
						} else {
							self.viewModelSetNewiTunesData(forData: decodedJSONValue)
							print("success")
						}


				} catch let error as NSError {
					//Failure most likely means there was an issue decoding the JSON.
					completionHandler(.failure(.generalFetchError))
					print(error)
				}

			}
			}

		}.resume()
	}
}
