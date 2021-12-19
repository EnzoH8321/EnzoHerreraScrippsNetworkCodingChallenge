//
//  MainModel.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import Foundation




struct MainModel {

	private(set) var arrayOfItunesData: [iTunesBaseProtocol] = []
	//If null, assume user wants to use the all filter
	private(set) var entityValue: iTunesEntities = .none

	//Functions
	mutating func setNewItunesData(forData dataArray: [iTunesBaseProtocol]) {
		self.arrayOfItunesData = dataArray
	}

	mutating func setNewEntityFilter(forEntity entity: iTunesEntities) {
		self.entityValue = entity
	}



}


