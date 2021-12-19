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

	var viewModelArrayOfItunesData: [iTunesBaseProtocol] {
		return self.dataModel.arrayOfItunesData
	}

	var viewModelEntityValue: iTunesEntities {
		return self.dataModel.entityValue
	}

	//Functions
	func viewModelSetNewiTunesData(forData data: [iTunesBaseProtocol]) {
		dataModel.setNewItunesData(forData: data)
	}

	func viewModelSetNewEntityfilter(forEntity entity: iTunesEntities) {
		dataModel.setNewEntityFilter(forEntity: entity)
	}
	
}

//Networking work done here
extension MainViewModel {
	//As you add more filters, you must also include them as arguments to this function
	func fetchDatafromItunesAPI(forTerm term: String, forEntities entity: iTunesEntities) {

		//Tests to see if a user selected an entity from the settings view
		var entityType: String? {
			if (entity == .none) {
				return nil
			} else {
				return entity.rawValue
			}

		}

		var urlComponents = URLComponents()
		urlComponents.scheme = "https"
		urlComponents.host = "itunes.apple.com"
		urlComponents.path = "/search"
		urlComponents.queryItems = [
			URLQueryItem(name: "term", value: term),
			URLQueryItem(name: "limit", value: "25"),
			//Add a query if the user selected an entity. If not, set empty values.)
			entityType != nil ? URLQueryItem(name: "entity", value: "\(entityType)") : URLQueryItem(name: "entity", value: "movie, album, allArtist, podcast, musicVideo, mix, audiobook, tvSeason, allTrack")
		]

		//Possibility url could come back invalid
		guard let url = urlComponents.url else {
			return print("URL NOT VALID")
		}

		var request = URLRequest(url: url)
		request.httpMethod = "GET"

		print(request)

		URLSession.shared.dataTask(with: request) { data, response, error in

			if let verifiedData = data {

				do {

					let decodedJSONValue = try JSONDecoder().decode(iTunesResponseMain.self, from: verifiedData).results

					DispatchQueue.main.async {
						self.objectWillChange.send()
						self.viewModelSetNewiTunesData(forData: decodedJSONValue)
						print("success -> \(self.dataModel.arrayOfItunesData)")
					}

				} catch let error as NSError {
					//Failure most likely means there was an issue decoding the JSON.
					print(error)
				}

			}

			//If you are here, it means that there was an error somewhere in your fetch request.
			print(error)

		}.resume()



	}

	
}
