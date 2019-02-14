//
//  HomeVIewController.swift
//  WorkfileSwift
//
//  Created by bookpro on 2019/01/28.
//  Copyright © 2019 bookpro. All rights reserved.
//

import UIKit

class HomeVIewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	@IBAction func pushSNSButton(_ sender: Any) {
		let shareText = "Youtubeで学ぶ Swiftプログラミング"
		let activityItems = [shareText] as [String]
		let activityVC = UIActivityViewController(activityItems: activityItems, applicationActivities: nil)
		let excludedActivityTypes = [
			UIActivity.ActivityType.postToFacebook,
			UIActivity.ActivityType.postToTwitter,
			UIActivity.ActivityType.message,
			UIActivity.ActivityType.saveToCameraRoll,
			UIActivity.ActivityType.print
		]
		
		activityVC.excludedActivityTypes = excludedActivityTypes
		self.present(activityVC, animated: true, completion: nil)
	}
	
	func setGradientBackground() {
		let colorTop =  UIColor(red: 73.0/255.0, green: 3.0/255.0, blue: 128.0/255.0, alpha: 0.6).cgColor
		let colorMiddle = UIColor(red: 130.0/255.0, green: 60.0/255.0, blue: 110.0/255.0, alpha: 0.9).cgColor
		let colorBottom = UIColor(red: 196.0/255.0, green: 45.0/255.0, blue: 45.0/255.0, alpha: 0.6).cgColor
		let gradientLayer = CAGradientLayer()
		gradientLayer.startPoint = CGPoint(x:0.0,y:0.0)
		gradientLayer.endPoint = CGPoint(x:1.0,y:1.0)
		gradientLayer.colors = [colorTop, colorMiddle, colorBottom]
		gradientLayer.locations = [0.1, 0.5, 0.9]
		gradientLayer.frame = self.view.bounds
		self.view.layer.insertSublayer(gradientLayer, at: 0)
	}
	
	@IBAction func pushContactButton(_ sender: Any) {
		UIApplication.shared.open(URL(string: "https://goo.gl/forms/bInWFbZoioCaWkiu2")!, options: [:], completionHandler: nil)
	}
	
	override func viewDidLayoutSubviews() {
		setGradientBackground()
	}
}
