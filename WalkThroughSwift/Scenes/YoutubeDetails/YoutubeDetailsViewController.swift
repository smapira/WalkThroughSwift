//
//  YoutubeDetailsTableViewController.swift
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

import UIKit
import YoutubeKit

class YoutubeDetailsViewController: UIViewController, YoutubeDetailsView {
	var presenter: YoutubeDetailsPresenter!
	var configurator: YoutubeDetailsConfigurator!
	private var player: YTSwiftyPlayer!
	
	// MARK: - IBOutlets
	@IBOutlet weak var videoView: UIView!
	
	// MARK: - UIViewController
	override func viewDidLoad() {
		super.viewDidLoad()
		configurator.configure(youtubeDetailsViewController: self)
		presenter.viewDidLoad()
	}

	// MARK: - YoutubeDetailsView
	func display(videoId: String) {
		player = YTSwiftyPlayer(
			frame: CGRect(x: 0, y: 0, width: 640, height: 480),
			playerVars: [.videoID(videoId)])
		player.autoplay = true
		view = player
		player.loadPlayer()
		videoView = player
	}
	
	func displayScreenTitle(title: String) {
		self.navigationItem.title = title
	}
}
