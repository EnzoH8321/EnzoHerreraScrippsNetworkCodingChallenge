//
//  MainModel.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import Foundation




struct MainModel {

	private(set) var arrayOfItunesData: [iTunesBaseProtocol] = []


	mutating func setNewItunesData(forData dataArray: [iTunesBaseProtocol]) {
		self.arrayOfItunesData = dataArray
	}

	

}
