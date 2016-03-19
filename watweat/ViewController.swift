//
//  ViewController.swift
//  watweat
//
//  Created by WEI on 16/3/18.
//  Copyright © 2016年 WEI. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var OkButton: UIButton!
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.OkButton.userInteractionEnabled = true
		let tapGesture = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
		
		OkButton.addGestureRecognizer(tapGesture)
		
		
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	func handleTap(sender : UIButton){
		
		//post2website
		//verify the password
		//set the ID
		
		
		
		//self.user.userId = 42
		self.performSegueWithIdentifier("loginSegue", sender:self)
		
		
		//
	}


}

