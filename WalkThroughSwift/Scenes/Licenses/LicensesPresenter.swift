//
//  LicensesPresenter.swift
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

protocol LicensesView: class {
	func refreshLicensesView()
	func displayLicensesRetrievalError(title: String, message: String)
	func displayLicensesDeleteError(title: String, message: String)
	func deleteAnimated(row: Int)
	func endEditing()
}

// It would be fine for the cell view to declare a LicensesCellViewModel property and have it configure itself
// Using this approach makes the view even more passive/dumb - but I can understand if some might consider it an overkill
protocol LicensesCellView {
	func display(title: String)
}

protocol LicensesPresenter {
	var numberOfLicenses: Int { get }
	var router: LicensesViewRouter { get }
	func viewDidLoad()
	func configure(cell: LicensesCellView, forRow row: Int)
	func canEdit(row: Int) -> Bool
	func didSelect(row: Int)
}

class LicensesPresenterImplementation: LicensesPresenter {
	fileprivate weak var view: LicensesView?
	internal let router: LicensesViewRouter
	var licenses = [License]()
	lazy private var constants: [Dictionary<String, String>] = {
		return NSDictionary(contentsOf: Bundle.main.url(forResource: "constant", withExtension: "plist")!)?["licenses"] as! [Dictionary<String, String>]
	}()

	var numberOfLicenses: Int {
		return licenses.count
	}

	init(view: LicensesView,
	     router: LicensesViewRouter) {
		self.view = view
		self.router = router
		self.licenses = self.constants.map({
			(constant: Dictionary) -> License in
			return License(title: constant["title"] ?? "", body: constant["body"] ?? "")
		})
	}

	// MARK: - LicensesPresenter

	func viewDidLoad() {
	}

	func configure(cell: LicensesCellView, forRow row: Int) {
		let licenses = self.licenses[row]
		cell.display(title: licenses.title)
	}

	func didSelect(row: Int) {
		let licenses = self.licenses[row]
		router.presentDetailsView(for: licenses)
	}

	func canEdit(row: Int) -> Bool {
		return false
	}


}
