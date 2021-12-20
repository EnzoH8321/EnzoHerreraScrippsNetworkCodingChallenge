//
//  ItunesAPIModels.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import Foundation

struct iTunesResponseMain: Codable {
	var resultCount: Int
	var results: [iTunesGeneralModel]
}

//Depending on your inputted parameters, iTunes can return JSON with a variety of different properties. However, there are certain properties that are identical in each return and represents the "core" of all returned data. Use this as a base for creating new structs that will conform to those parameters.
//TODO: A more concise way to do this would be to create a seperate data model for each specific filter.
struct iTunesGeneralModel: Codable, Hashable {
	var wrapperType: String?
	var collectionExplicitness: String?
	var trackExplicitness: String?
	var kind: String?
	var trackName: String?
	var artistName: String?
	var collectionName: String?
	var collectionCensoredName: String?
	var trackCensoredName: String?
	var artworkUrl30: String?
	var artworkUrl60: String?
	var artworkUrl100: String?
	var artistViewUrl: URL?
	var trackViewUrl: URL?
	var collectionViewUrl: URL?
	var previewUrl: URL?
	var artistId: Int?
	var collectionId: Int?
	var trackId: Int?
	var collectionPrice: Double?
	var trackPrice: Double?
	var releaseDate: String?
	var discCount: Int?
	var discNumber: Int?
	var trackCount: Int?
	var trackNumber: Int?
	var trackTimeMillis: Int?
	var country: String?
	var currency: String?
	var primaryGenreName: String?
	var isStreamable: Bool?
	var feedUrl: URL?
}



