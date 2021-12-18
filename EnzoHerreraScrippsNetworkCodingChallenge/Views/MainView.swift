//
//  ContentView.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import SwiftUI

struct ContentView: View {

	@State var searchString = ""

    var body: some View {
		VStack {
			HStack {
				TextField("Search Prompt", text: $searchString)
					.accessibilityLabel("Search Field")
				Button("Search", action: {
					
				})
					.accessibilityLabel("Search Button")
				//When using system symbol image, make sure the symbol is available on the iOS versions you are targeting.
				Image(systemName: "list.dash")
					.accessibilityLabel("Filter Button")

			}
			ListView()
				.accessibilityLabel("list of returned results")
		}


    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

