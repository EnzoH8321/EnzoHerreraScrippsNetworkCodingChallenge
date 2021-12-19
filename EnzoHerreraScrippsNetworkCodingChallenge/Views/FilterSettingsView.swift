//
//  FilterModalView.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import SwiftUI



struct FilterSettingsView: View {

	@EnvironmentObject var viewModel: MainViewModel

	//Capitalization reflects what's expected for url parameter. For a better UI, you can use gramatically correct capitialization in the UI and do a conversion later. Enums provide misspelling protection.
	var entitySelections = [iTunesEntities.none.rawValue,iTunesEntities.movie.rawValue, iTunesEntities.podcast.rawValue, iTunesEntities.musicArtist.rawValue, iTunesEntities.musicVideo.rawValue, iTunesEntities.audiobook.rawValue, iTunesEntities.shortFilm.rawValue, iTunesEntities.tvEpisode.rawValue, iTunesEntities.software.rawValue, iTunesEntities.ebook.rawValue]

	@State private var selectedMedia = iTunesEntities.none

    var body: some View {
		VStack {
			Spacer()
			//If your Picker has to choose from a large variety of elements, consider using the .wheel pickerStyle.
			HStack {
				Spacer()
				Text("Media Type")
				Spacer()

				//TODO: Add functionality to create a multi choice picker
				Picker("Please choose a media type", selection: $selectedMedia) {
					ForEach(entitySelections, id: \.self) {
						Text($0)
					}
				}
				.accessibilityIdentifier("Media Type")
				Spacer()
			}
			//TODO: If you wanted, you could add more filters below.

			Spacer()
			
		}
		.navigationBarTitleDisplayMode(.inline)
		.toolbar {
			ToolbarItemGroup(placement: .automatic) {
				Button("Apply Filters", action: {
					viewModel.viewModelSetNewEntityfilter(forEntity: selectedMedia)
				})
			}
		}
    }
}

struct FilterModalView_Previews: PreviewProvider {
    static var previews: some View {
        FilterSettingsView()
    }
}
