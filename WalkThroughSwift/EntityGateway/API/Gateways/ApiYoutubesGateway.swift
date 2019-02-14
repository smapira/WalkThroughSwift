//
//  ApiYoutubesGateway.swift
//  WorkfileSwift
//
//  Created by Cosmin Stirbu on 2/23/17.
//  Modified by smapira on 12/23/18.
//  MIT License
//
//  Copyright (c) 2017 Fortech
//  Copyright (c) 2018 smapira
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import Foundation
import YoutubeKit

// This protocol in not necessarily needed since it doesn't include any extra methods
// besides what YoutubesGateway already provides. However, if there would be any extra methods
// on the API that we would need to support it would make sense to have an API specific gateway protocol
protocol ApiYoutubesGateway: YoutubesGateway {

}

class ApiYoutubesGatewayImplementation: ApiYoutubesGateway {

	let apiClient: ApiClient

	init(apiClient: ApiClient) {
		self.apiClient = apiClient
	}

	// MARK: - ApiYoutubesGateway

	func fetchYoutubes(playlistID: String, completionHandler: @escaping (Result<[Youtube]>) -> Void) {
		let youtubesApiRequest = PlaylistItemsListRequest(part: [.id, .snippet, .contentDetails],
														  filter: .playlistID(playlistID),
														  maxResults: 50)
		ApiSession.shared.send(youtubesApiRequest) { result in
			switch result {
			case let .success(response):
				let videos = response.items.compactMap {
					try? ApiYoutube.init(youtube: $0).youtube
				}
				completionHandler(.success(videos))
			case .failed(let error):
				completionHandler(.failure(error))
			}
		}
		
	}
}
