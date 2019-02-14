//
//  CoreDataYoutube.swift
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
import CoreData

// It's best to decouple the application / business logic from your persistence framework
// That's why CoreDataYoutube - which is a NSManagedObjectModel subclass is converted into a Youtube entity
extension CoreDataYoutube {
	var youtube: Youtube {
		return Youtube(id: id ?? "",
					   publishedAt: publishedAt ?? "",
					   title: title ?? "",
					   channelDescription: channelDescription ?? "",
					   thumbnailUrl: thumbnailUrl ?? "",
					   channelTitle: channelTitle ?? "",
					   videoId: videoId ?? "")
	}

	func populate(with youtube: Youtube) {
		id = youtube.id
		publishedAt = youtube.publishedAt
		title = youtube.title
		channelDescription = youtube.channelDescription
		thumbnailUrl = youtube.thumbnailUrl
		channelTitle = youtube.channelTitle
		videoId = youtube.videoId
	}
}
