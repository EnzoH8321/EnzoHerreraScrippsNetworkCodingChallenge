//
//  MainModel.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import Foundation

struct MainModel {

	private(set) var arrayOfItunesData: [iTunesGeneralModel] = []

	//None means that the user wants to use a broad search, akin to all"
	private(set) var entityValue: iTunesEntities = .none

	//Functions
	mutating func setNewItunesData(forData dataArray: [iTunesGeneralModel]) {
		self.arrayOfItunesData = dataArray
	}

	mutating func setNewEntityFilter(forEntity entity: iTunesEntities) {
		self.entityValue = entity
	}

}


