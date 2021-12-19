//
//  DetailView.swift
//  EnzoHerreraScrippsNetworkCodingChallenge
//
//  Created by Enzo Herrera on 12/18/21.
//

import SwiftUI

struct DetailView: View {

	var urlString: String
	@State var uiImage: UIImage?

    var body: some View {
		VStack {
			Image(uiImage: uiImage ?? UIImage(named: "errorImage")!)
				.resizable()
			Text("Track Name")
			Text("Artist Name")
			Text("Explicitness")
			Spacer()
		}
		//TODO: If you had more time, you could put a modified version of below code with the rest of the networking code. The best way would be to fetch the image during the initial fetch request.
		.onAppear {
			print("on appear")
			if let url = URL(string: urlString) {
				var request = URLRequest(url: url)
				request.httpMethod = "GET"

				URLSession.shared.dataTask(with: request) { data, response, error in

					if let verifiedData = data {

						DispatchQueue.main.async {

							let image = UIImage(data: verifiedData)

							uiImage = image
							print(uiImage)

						}

					}

				}.resume()

			}

		}
	}
	
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
		DetailView(urlString: "https://is2-ssl.mzstatic.com/image/thumb/Music125/v4/c4/65/6a/c4656ad0-6f0b-0b8b-152d-0236b86ace39/source/100x100bb.jpg")
    }
}
