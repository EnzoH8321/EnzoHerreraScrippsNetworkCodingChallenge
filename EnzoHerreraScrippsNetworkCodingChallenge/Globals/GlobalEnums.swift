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

//Implement basic error handling
enum ErrorEnum: Identifiable, Error {
	
	case noResultsError
	case invalidUrlError
	case generalFetchError

	var id: UUID {
		get {
			UUID()
		}
	}

	var alert: Alert {
		switch (self) {
		case .noResultsError:
			return Alert(title: Text("Error"), message: Text("Search returned no results"), dismissButton: .default(Text("Try Again")))
		case .invalidUrlError:
			return Alert(title: Text("Error"), message: Text("Invalid URL"), dismissButton: .default(Text("Try Again")))
		case .generalFetchError:
			return Alert(title: Text("Error"), message: Text("Fetch Error"), dismissButton: .default(Text("Try Again")))
		}

	}
}


