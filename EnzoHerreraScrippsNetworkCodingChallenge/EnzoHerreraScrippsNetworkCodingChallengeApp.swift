//
//  EnzoHerreraScrippsNetworkCodingChallengeApp.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import SwiftUI

@main
struct EnzoHerreraScrippsNetworkCodingChallengeApp: App {

	@StateObject var viewModel = MainViewModel()

    var body: some Scene {
        WindowGroup {
            ContentView()
				.environmentObject(viewModel)
        }
    }
}
