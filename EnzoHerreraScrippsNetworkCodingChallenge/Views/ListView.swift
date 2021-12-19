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
			ForEach(viewModel.viewModelArrayOfItunesData) { element in
				ListViewCell()
		}
    }
}

//For more complicated projects you may want to consider putting the cell's in a seperate file
struct ListViewCell: View {

	var trackName: String
	var artistName: String
	var explicitness: String

	var body: some View {
		VStack {
			Text(trackName)
			Text(artistName)
			Text(explicitness)
		}
	}
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
}
