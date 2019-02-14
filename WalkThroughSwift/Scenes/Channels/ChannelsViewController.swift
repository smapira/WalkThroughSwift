//
//  ChannelsViewController.swift
//  WorkfileSwift
//
//  Created by bookpro on 2019/01/29.
//  Copyright © 2019 bookpro. All rights reserved.
//

import UIKit

class ChannelsViewController: UIViewController {
	@IBOutlet weak var beginnerButton: UIButton!
	
	override func viewDidLoad() {
		super.viewDidLoad()
	}
	@IBAction func pushHomeButton(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func pushBeginnerButton(_ sender: Any) {
		performSegue(withIdentifier: "ChannelSceneToYoutubesSceneSegue",sender: "PL2gbyKWQhYvpO_iLMp6uOgHOjn8IVtLVV")
		
	}
	
	@IBAction func pushXcodeButton(_ sender: Any) {
		performSegue(withIdentifier: "ChannelSceneToYoutubesSceneSegue",sender: "PL2gbyKWQhYvpBy8jB_T1ttcQuxxIMEhDJ")
		
	}
	
	@IBAction func pushSwiftButton(_ sender: Any) {
		performSegue(withIdentifier: "ChannelSceneToYoutubesSceneSegue",sender: "PL2gbyKWQhYvrmZos7XGz680DagE6UbJbM")
		
	}
	
	@IBAction func pushAppleButton(_ sender: Any) {
		performSegue(withIdentifier: "ChannelSceneToYoutubesSceneSegue",sender: "PL2gbyKWQhYvrQV63CAc7PCJeImhDER7ri")
		
	}
	
	@IBAction func pushAutoLayoutButton(_ sender: Any) {
		performSegue(withIdentifier: "ChannelSceneToYoutubesSceneSegue",sender: "PL2gbyKWQhYvqtokv2gh1Nq81HqJaH3r59")
		
	}
	
	@IBAction func pushChatButton(_ sender: Any) {
		performSegue(withIdentifier: "ChannelSceneToYoutubesSceneSegue",sender: "PL0dzCUj1L5JEfHqwjBV0XFb9qx9cGXwkq")
		
	}
	
	@IBAction func pushYoutubeButton(_ sender: Any) {
		performSegue(withIdentifier: "ChannelSceneToYoutubesSceneSegue",sender: "PL0dzCUj1L5JGKdVUtA5xds1zcyzsz7HLj")
		
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if (segue.identifier == "ChannelSceneToYoutubesSceneSegue") {
			let youtubeTableViewController: YoutubesTableViewController = (segue.destination as? YoutubesTableViewController)!
			youtubeTableViewController.playlistID = sender as? String
		}
	}
}
