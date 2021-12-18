//
//  FilterModalView.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import SwiftUI



struct FilterModalView: View {
	//Capitalization reflects what's expected for url parameter. For a better UI, you can use gramatically correct capitialization in the UI and do a conversion later. Enums provide misspelling protection.
	var entitySelections = [iTunesEntities.movie.rawValue, iTunesEntities.podcast.rawValue, iTunesEntities.musicArtist.rawValue, iTunesEntities.musicVideo.rawValue, iTunesEntities.audiobook.rawValue, iTunesEntities.shortFilm.rawValue, iTunesEntities.tvEpisode.rawValue, iTunesEntities.software.rawValue, iTunesEntities.ebook.rawValue]

	@State private var selectedMedia = iTunesEntities.movie.rawValue

    var body: some View {
		VStack {
			HStack() {
				Spacer()
				Button("Apply Filters", action: {})
					.padding([.trailing], 16)
			}

			//If your Picker has to choose from a large variety of elements, consider using the .wheel pickerStyle.
			HStack {
				Spacer()
				Text("Media Type")
				Spacer()
				Picker("Please choose a media type", selection: $selectedMedia) {
					ForEach(entitySelections, id: \.self) {
						Text($0)
					}
				}
				Spacer()
			}
			//TODO: If you wanted, you could add more filters below.
			//
			Spacer()
		}
    }
}

struct FilterModalView_Previews: PreviewProvider {
    static var previews: some View {
        FilterModalView()
    }
}
