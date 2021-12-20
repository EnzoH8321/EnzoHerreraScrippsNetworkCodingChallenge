//
//  ListView.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import SwiftUI

struct ListView: View {

	@EnvironmentObject var viewModel: MainViewModel

	var body: some View {

		List {
			ForEach(viewModel.viewModelArrayOfItunesData, id: \.self) { element in
				NavigationLink(destination: DetailView(urlString: element.artworkUrl100 ?? "", trackName: element.trackName ?? "", artistName: element.artistName ?? "", explicitContent: element.collectionExplicitness ?? "")) {
					ListViewCell(trackName: element.trackName ?? "Not Found", artistName: element.artistName ?? "Not Found", explicitness: element.trackExplicitness ?? "Not Found", mediaType: element.kind ?? "Not Found")
						
				}
				.accessibilityIdentifier("List Cell")

			}
			.listStyle(.grouped)
		}
		.accessibilityIdentifier("List")


	}

	//For more complicated projects you may want to consider putting the cell's in a seperate file
	struct ListViewCell: View {

		var trackName: String
		var artistName: String
		var explicitness: String
		var mediaType: String

		var body: some View {
			VStack(alignment: .leading) {
				Text("Media Type: \(mediaType)")
				Text("Track Name: \(trackName)")
				Text("Artist Name: \(artistName)")
				Text("Explicit Content: \(explicitness)")

			}
			.accessibilityIdentifier("ListCell")
		}
	}
	

	struct ListView_Previews: PreviewProvider {
		static var previews: some View {
			ListView()
				.environmentObject(MainViewModel())
		}
	}
}
