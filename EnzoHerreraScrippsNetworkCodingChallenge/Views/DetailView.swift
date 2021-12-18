//
//  DetailView.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import SwiftUI

struct DetailView: View {
    var body: some View {
		VStack {
			Image(systemName: "burn")
				.resizable()
			Text("Track Name")
			Text("Artist Name")
			Text("Explicitness")
		}
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView()
    }
}
