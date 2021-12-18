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

	func viewModelSetNewiTunesData(forData data: [iTunesBaseProtocol]) {
		dataModel.setNewItunesData(forData: data)
	}
	
}

//Networking work done here
extension MainViewModel {
	func fetchDatafromItunesAPI(forTerm term: String) {



	}
}
