//
//  LicenseDetailsViewController.swift
//  WorkfileSwift
//
//  Created by bookpro on 2019/01/29.
//  Copyright © 2019 bookpro. All rights reserved.
//

import UIKit

class LicenseDetailsViewController: UIViewController, LicenseDetailsView {
	var presenter: LicenseDetailsPresenter!
	var configurator: LicenseDetailsConfigurator!
	@IBOutlet weak var bodyLabel: UILabel!
	
	// MARK: - IBOutlets
	
	// MARK: - UIViewController
	override func viewDidLoad() {
		super.viewDidLoad()
		configurator.configure(licenseDetailsViewController: self)
		presenter.viewDidLoad()
	}

	func display(body: String) {
		self.bodyLabel.text = body
	}
}
