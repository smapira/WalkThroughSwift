//
//  YoutubesPresenter.swift
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

protocol YoutubesView: class {
	func refreshYoutubesView()
	func displayYoutubesRetrievalError(title: String, message: String)
}

// It would be fine for the cell view to declare a YoutubeCellViewModel property and have it configure itself
// Using this approach makes the view even more passive/dumb - but I can understand if some might consider it an overkill
protocol YoutubeCellView {
	func display(publishedAt: String)
	func display(title: String)
	func display(channelDescription: String)
	func display(thumbnailUrl: String)
	func display(channelTitle: String)
	func display(videoId: String)
}

protocol YoutubesPresenter {
	var numberOfYoutubes: Int { get }
	var router: YoutubesViewRouter { get }
	var playlistID: String { get set }
	func viewDidLoad()
	func configure(cell: YoutubeCellView, forRow row: Int)
	func didSelect(row: Int)
	func canEdit(row: Int) -> Bool
}

class YoutubesPresenterImplementation: YoutubesPresenter {
	fileprivate weak var view: YoutubesView?
	fileprivate let displayYoutubesUseCase: DisplayYoutubesUseCase
	internal let router: YoutubesViewRouter
	var playlistID: String

	// Normally this would be file private as well, we keep it internal so we can inject values for testing purposes
	var youtubes = [Youtube]()

	var numberOfYoutubes: Int {
		return youtubes.count
	}

	init(view: YoutubesView,
	     displayYoutubesUseCase: DisplayYoutubesUseCase,
	     router: YoutubesViewRouter) {
		self.view = view
		self.displayYoutubesUseCase = displayYoutubesUseCase
		self.router = router
		self.playlistID = ""
	}

	deinit {
		NotificationCenter.default.removeObserver(self)
	}

	// MARK: - YoutubesPresenter

	func viewDidLoad() {
		self.displayYoutubesUseCase.displayYoutubes(playlistID: self.playlistID) { (result) in
			switch result {
			case let .success(youtubes):
				self.handleYoutubesReceived(youtubes)
			case let .failure(error):
				self.handleYoutubesError(error)
			}
		}
	}

	func configure(cell: YoutubeCellView, forRow row: Int) {
		let youtube = youtubes[row]

		cell.display(publishedAt: youtube.publishedAt)
		cell.display(title: youtube.title)
		cell.display(channelDescription: youtube.channelDescription)
		cell.display(thumbnailUrl: youtube.thumbnailUrl)
		cell.display(channelTitle: youtube.channelTitle)
		cell.display(videoId: youtube.videoId)
	}

	func didSelect(row: Int) {
		let youtube = youtubes[row]

		router.presentDetailsView(for: youtube)
	}

	func canEdit(row: Int) -> Bool {
		return false
	}

	// MARK: - Private

	fileprivate func handleYoutubesReceived(_ youtubes: [Youtube]) {
		self.youtubes = youtubes
		view?.refreshYoutubesView()
	}

	fileprivate func handleYoutubesError(_ error: Error) {
		// Here we could check the error code and display a localized error message
		view?.displayYoutubesRetrievalError(title: "Error", message: error.localizedDescription)
	}

}
