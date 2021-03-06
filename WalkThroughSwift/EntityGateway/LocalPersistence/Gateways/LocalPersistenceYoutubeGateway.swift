//
//  LocalPersistenceYoutubesGateway.swift
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

protocol LocalPersistenceYoutubesGateway: YoutubesGateway {
	func fetchYoutubes(completionHandler: @escaping (Result<[Youtube]>) -> Void)
}

class CoreDataYoutubesGateway: LocalPersistenceYoutubesGateway {
	func fetchYoutubes(playlistID: String, completionHandler: @escaping FetchYoutubesEntityGatewayCompletionHandler) {
	}
	
	let viewContext: NSManagedObjectContextProtocol

	init(viewContext: NSManagedObjectContextProtocol) {
		self.viewContext = viewContext
	}

	// MARK: - YoutubesGateway
	func fetchYoutubes(completionHandler: @escaping (Result<[Youtube]>) -> Void) {
		if let coreDataYoutubes = try? viewContext.allEntities(withType: CoreDataYoutube.self) {
			let youtubes = coreDataYoutubes.map { $0.youtube }
			completionHandler(.success(youtubes))
		} else {
			completionHandler(.failure(CoreError(message: "Failed retrieving youtubes the data base")))
		}
	}
}
