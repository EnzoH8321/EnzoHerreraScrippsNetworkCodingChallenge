//
//  ItunesAPIModels.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import Foundation

//Created in order to provide a base case for possible extensions of the iTunesGeneralModel. As every request to the iTunes API irrespective of parameters chosen will return these properties, this should be used every time you need to create a new custom struct.
protocol iTunesBaseProtocol {
	var wrapperType: String { get set }
	var collectionExplicitness: String { get set }
	var trackExplicitness: String { get set }
	var kind: String { get set }
	var trackName: String { get set }
	var artistName: String { get set }
	var collectionName: String { get set }
	var collectionCensoredName: String { get set }
	var trackCensoredName: String { get set }
	var artworkUrl60: URL? { get set }
	var artworkUrl100: URL? { get set }
	var artistViewUrl: URL? { get set }
	var trackViewUrl: URL? { get set }
	var collectionViewUrl: URL? { get set }
	var previewUrl: URL? { get set }
	var trackTimeMillus: Int { get set }
}

//Depending on your inputted parameters, iTunes can return JSON with a variety of different properties. However, there are certain properties that are identical in each return and represents the "core" of all returned data. Use this as a base for creating new structs that will conform to those parameters
struct iTunesGeneralModel: Codable, iTunesBaseProtocol {
	var wrapperType: String
	var collectionExplicitness: String
	var trackExplicitness: String
	var kind: String
	var trackName: String
	var artistName: String
	var collectionName: String
	var collectionCensoredName: String
	var trackCensoredName: String
	var artworkUrl60: URL?
	var artworkUrl100: URL?
	var artistViewUrl: URL?
	var trackViewUrl: URL?
	var collectionViewUrl: URL?
	var previewUrl: URL?
	var trackTimeMillus: Int
}

//TODO: If you want to add additional parameters to your fetch, create a new struct and extend the iTunes Base Protocol.


