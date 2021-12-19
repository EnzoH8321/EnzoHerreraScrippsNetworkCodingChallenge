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
				ListViewCell(trackName: element.trackName ?? "", artistName: element.artistName ?? "", explicitness: element.trackExplicitness ?? "", mediaType: element.kind ?? "")
		}
			.listStyle(.grouped)
    }
}

//For more complicated projects you may want to consider putting the cell's in a seperate file
struct ListViewCell: View {

	var trackName: String
	var artistName: String
	var explicitness: String
	var mediaType: String

	var body: some View {
		VStack(alignment: .leading) {
			Text(mediaType)
			Text(trackName)
			Text(artistName)
			Text(explicitness)

		}
	}
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
			.environmentObject(MainViewModel())
    }
}
}
