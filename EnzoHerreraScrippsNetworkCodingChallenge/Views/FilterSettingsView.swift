//
//  FilterModalView.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import SwiftUI



struct FilterSettingsView: View {

	@EnvironmentObject var viewModel: MainViewModel
	@Environment(\.presentationMode) var presentationMode

	//Capitalization reflects what's expected for url parameter. For a better UI, you can use gramatically correct capitialization in the UI and do a conversion later. Enums provide misspelling protection.
	var entitySelections = [iTunesEntities.none.rawValue,iTunesEntities.movie.rawValue, iTunesEntities.podcast.rawValue, iTunesEntities.musicArtist.rawValue, iTunesEntities.musicVideo.rawValue, iTunesEntities.audiobook.rawValue, iTunesEntities.shortFilm.rawValue, iTunesEntities.tvEpisode.rawValue, iTunesEntities.software.rawValue, iTunesEntities.ebook.rawValue]

	//TODO: We need to use a string here because as of SwiftUI 2.0, using an enum as the State of a picker component does not work. Check back later to see if they fixed this issue.
	@State private var selectedMedia = "none"


	var body: some View {
		NavigationView {
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
			.onAppear {
				self.selectedMedia = viewModel.dataModel.entityValue.rawValue
			}

		}
		.toolbar {
			ToolbarItemGroup(placement: .automatic) {

				Button("Apply Filters", action: {

					//Converts the selectedMedia string to a iTunesEntity.
					//TODO: Once Apple fixes the bug with the Picker component not recognizing enums, you can remove the below conversion code.
					
					var convertedPickerValue: iTunesEntities

					switch(selectedMedia) {
					case "none":
						convertedPickerValue = iTunesEntities.none
					case "movie":
						convertedPickerValue = iTunesEntities.movie
					case "podcast":
						convertedPickerValue = iTunesEntities.podcast
					case "musicArtist":
						convertedPickerValue = iTunesEntities.musicArtist
					case "musicVideo":
						convertedPickerValue = iTunesEntities.musicVideo
					case "audiobook":
						convertedPickerValue = iTunesEntities.audiobook
					case "shortFilm":
						convertedPickerValue = iTunesEntities.shortFilm
					case "tvEpisode":
						convertedPickerValue = iTunesEntities.tvEpisode
					case "software":
						convertedPickerValue = iTunesEntities.software
					case "ebook":
						convertedPickerValue = iTunesEntities.ebook
					default:
						convertedPickerValue = iTunesEntities.none
					}

					viewModel.viewModelSetNewEntityfilter(forEntity: convertedPickerValue)

					
					self.presentationMode.wrappedValue.dismiss()
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
