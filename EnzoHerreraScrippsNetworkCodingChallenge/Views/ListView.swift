//
//  ListView.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import SwiftUI

struct ListView: View {
    var body: some View {
		List {
			ListViewCells()
			ListViewCells()
			ListViewCells()
		}
    }
}

//For more complicated projects you may want to consider putting the cell's in a seperate file
struct ListViewCells: View {

	var body: some View {
		VStack {
			Text("Track Name")
			Text("Artist Name")
			Text("Explicitness")
		}
	}
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        ListView()
    }
}
