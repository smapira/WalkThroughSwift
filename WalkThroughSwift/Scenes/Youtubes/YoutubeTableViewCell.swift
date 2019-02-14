//
//  YoutubeTableViewCell.swift
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

class YoutubeTableViewCell: UITableViewCell, YoutubeCellView {

	@IBOutlet weak var youtubePublishedAtLabel: UILabel!
	@IBOutlet weak var youtubeTitleLabel: UILabel!
	@IBOutlet weak var youtubeChannelDescriptionLabel: UILabel!
	@IBOutlet weak var youtubeThumbnailImage: UIImageView!
	

	func display(id: String) {
	}

	func display(publishedAt: String) {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
		dateFormatter.timeZone = TimeZone.current
		dateFormatter.locale = Locale.current
		let datePublishedAt = dateFormatter.date(from: publishedAt)
		dateFormatter.dateFormat = "yyyy-MM-dd"
		youtubePublishedAtLabel.text = dateFormatter.string(from: datePublishedAt!)
	}

	func display(title: String) {
		youtubeTitleLabel.text = title
	}
	
	func display(channelDescription: String) {
		youtubeChannelDescriptionLabel.text = channelDescription
	}
	
	func display(thumbnailUrl: String) {
		youtubeThumbnailImage.downloaded(from: thumbnailUrl)
	}

	func display(channelTitle: String) {
	}
	
	func display(videoId: String) {
	}
}

extension UIImageView {
	func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
		contentMode = mode
		URLSession.shared.dataTask(with: url) { data, response, error in
			guard
				let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
				let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
				let data = data, error == nil,
				let image = UIImage(data: data)
				else { return }
			DispatchQueue.main.async() {
				self.image = image
			}
			}.resume()
	}
	func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
		guard let url = URL(string: link) else { return }
		downloaded(from: url, contentMode: mode)
	}
}

extension DateFormatter {
	func date(fromSwapiString dateString: String) -> Date? {
		self.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SZ"
		self.timeZone = TimeZone(abbreviation: "UTC")
		self.locale = Locale(identifier: "en_US_POSIX")
		return self.date(from: dateString)
	}
}
