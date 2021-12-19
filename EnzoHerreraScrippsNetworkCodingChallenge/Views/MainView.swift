//
//  ContentView.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import SwiftUI

struct ContentView: View {

	@EnvironmentObject var viewModel: MainViewModel
	@State var searchString = ""

	var body: some View {
		NavigationView {
			VStack {
				HStack {

					TextField("Search Prompt", text: $searchString)
						.accessibilityLabel("Search Field")
					Button("Search", action: {
						viewModel.fetchDatafromItunesAPI(forTerm: searchString, forEntities: self.viewModel.viewModelEntityValue)
					})
						.accessibilityLabel("Search Button")

					//When using system symbol image, make sure the symbol is available on the iOS versions you are targeting.
					NavigationLink(destination: {FilterSettingsView()}) {
						Image(systemName: "list.dash")
							.accessibilityLabel("Filter Button")
					}
					.navigationBarHidden(true)

				}

				ListView()
					.accessibilityLabel("list of returned results")
			}
		}
		
		.navigationBarHidden(true)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

