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
						.accessibilityIdentifier("Search Field")
						.padding([.leading], 16)

					Button("Search", action: {

						viewModel.fetchDatafromItunesAPI(forTerm: searchString, forEntities: self.viewModel.viewModelEntityValue) { result in

							switch result {
							case .success(_):
								errorAlert = false
							case .failure(let error):
								errorAlert = true
								//For larger projects, you can do more with these Errors. 
								switch error {
								case .generalFetchError:
									print("Fetch Error")
								case .noReturnedResultsError:
									print ("No Results Returned")
								case .invalidUrlError:
									print("Invalid URL")
								case .decodingError:
									print("Issue Decoding JSON")
								}
							}
						}
					})
						.accessibilityIdentifier("Search Button")
						.padding([.trailing], 16)

					//When using system symbol image, make sure the symbol is available on the iOS versions you are targeting.
					NavigationLink(destination: {FilterSettingsView()}) {
						Image(systemName: "list.dash")
							.padding([.trailing], 16)
					}
					.navigationBarHidden(true)
					.accessibilityIdentifier("Filter Button")
				}
				ListView()
					.accessibilityIdentifier("list of returned results")
			}
			//Checks the model to see if no results were returned. User is warned so they can try a different query
			.alert(isPresented: $errorAlert, content: {Alert(title: Text("Error"), message: Text("Error Retrieving Data"))})
		}
		.navigationBarHidden(true)
		.padding([.top], 8)
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
			.environmentObject(MainViewModel())
	}
}

