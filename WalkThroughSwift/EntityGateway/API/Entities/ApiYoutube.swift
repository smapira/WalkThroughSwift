//
//  ApiYoutube.swift
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

// If your company develops the API then it's relatively safe to have a single representation
// for both the API entities and your core entities. So depending on the complexity of your app this entity might be an overkill
struct ApiYoutube: InitializableWithData, InitializableWithJson, InitializableWithYoutube {

	var id: String
	var publishedAt: String
	var title: String
	var channelDescription: String
	var thumbnailUrl: String
	var channelTitle: String
	var videoId: String

	init(data: Data?) throws {
		self.id = ""
		self.publishedAt = ""
		self.title = ""
		self.channelDescription = ""
		self.thumbnailUrl = ""
		self.channelTitle = ""
		self.videoId = ""
	}
	
	init(json: [String : Any]) throws {
		self.id = ""
		self.publishedAt = ""
		self.title = ""
		self.channelDescription = ""
		self.thumbnailUrl = ""
		self.channelTitle = ""
		self.videoId = ""
	}
	
	init(youtube: PlaylistItem?) throws {
		guard let id = youtube?.id,
			let publishedAt = youtube?.snippet?.publishedAt,
			let title = youtube?.snippet?.title,
			let channelDescription = youtube?.snippet?.description,
			let thumbnailUrl = youtube?.snippet?.thumbnails?.default.url,
			let channelTitle = youtube?.snippet?.channelTitle,
			let videoId = youtube?.contentDetails?.videoID else {
				throw NSError.createPraseError()
		}
		self.id = id
		self.publishedAt = publishedAt
		self.title = title
		self.channelDescription = channelDescription
		self.thumbnailUrl = thumbnailUrl
		self.channelTitle = channelTitle
		self.videoId = videoId
	}
}

extension ApiYoutube {
	var youtube: Youtube {
		return Youtube(id: id,
					   publishedAt: publishedAt,
					   title: title,
					   channelDescription: channelDescription,
					   thumbnailUrl: thumbnailUrl,
					   channelTitle: channelTitle,
					   videoId: videoId)
	}
}
