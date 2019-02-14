//
//  LicensesViewRouter.swift
//  WorkfileSwift
//
//  Created by Cosmin Stirbu on 2/23/17.
//  MIT License
//
//  Copyright (c) 2017 Fortech
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

protocol LicensesViewRouter: ViewRouter {
	func presentDetailsView(for license: License)
}

class LicensesViewRouterImplementation: LicensesViewRouter {
	fileprivate weak var licensesTableViewController: LicensesTableViewController?
	fileprivate var license: License!

	init(licensesTableViewController: LicensesTableViewController) {
		self.licensesTableViewController = licensesTableViewController
	}

	// MARK: - LicensesViewRouter

	func presentDetailsView(for license: License) {
		self.license = license
		licensesTableViewController?.performSegue(withIdentifier: "LicensesSceneToLicenseDetailsSceneSegue", sender: nil)
	}

	func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let licenseDetailsViewController = segue.destination as? LicenseDetailsViewController {
			licenseDetailsViewController.configurator = LicenseDetailsConfiguratorImplementation(license: license)
		}
	}

}
