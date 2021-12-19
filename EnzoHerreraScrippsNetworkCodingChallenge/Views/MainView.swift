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
	@State var errorAlert = false

	var body: some View {
		NavigationView {
			VStack {
				HStack {

					TextField("Search Prompt", text: $searchString)
						.accessibilityLabel("Search Field")

					Button("Search", action: {
						
						viewModel.fetchDatafromItunesAPI(forTerm: searchString, forEntities: self.viewModel.viewModelEntityValue) { result in

							switch result {
							case .success(let count):
								print("Success")
							case .failure(let error):

								switch error {
								case .generalFetchError:
									print("Fetch Error")
								case .noReturnedResultsError:
									print ("No Results Returned")
								case .invalidUrlError:
									print("Invalid URL")
								}
								
							}
						}
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
			//Checks the model to see if no results were returned. User is warned so they can try a different query
			.alert(isPresented: $errorAlert, content: {Alert(title: Text("Error"), message: Text("Unable to Fetch"))})
		}
		.navigationBarHidden(true)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}

