//
//  GlobalEnums.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import Foundation
import SwiftUI

enum iTunesEntities: String {
	case movie
	case podcast
	case musicArtist
	case musicVideo
	case audiobook
	case shortFilm
	case tvEpisode
	case software
	case ebook
	case none
}

//Implement for Network Errors
enum NetworkError: Error {
	case noReturnedResultsError
	case invalidUrlError
	case generalFetchError
}

