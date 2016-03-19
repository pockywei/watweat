//
//  ResMapViewController.swift
//  watweat
//
//  Created by WEI on 16/3/19.
//  Copyright © 2016年 WEI. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class ResdetailViewController:UIViewController{
	
	@IBOutlet weak var chat_button_detailpage: UIBarButtonItem!
	let user = User.sharedInstance
	
	@IBAction func backButton(sender: AnyObject) {
		let isPresentingInAddMealMode = presentingViewController is UINavigationController
		print("4")
		if isPresentingInAddMealMode {
			print("5")
			dismissViewControllerAnimated(true, completion: nil)
			
		} else {
			navigationController!.popViewControllerAnimated(true)
			print("6")
			
			
		}
		
	}
	
    var resta: Artwork?
	
    @IBOutlet var categoryDetail: UITextView!
    @IBOutlet var addressDetail: UITextView!
    @IBOutlet var phoneDetail: UITextView!
	
	
    @IBAction func considerBtnClick() {
		var someDict = [Int: String]()

		
		user.cl = Client(id: 2,alias: "test1",considering: "C",artw:resta!)
		user.cl!.do_consideration_request(1)
		self.chat_button_detailpage.enabled = true
		
		//运行regina的send function
		
    }
	
    @IBAction func goBtnClick() {
		
    }
	
	override func viewWillAppear(animated: Bool) {
		 super.viewWillAppear(animated);
		if user.roomdic.isEmpty{
			self.chat_button_detailpage.enabled = false
		}
		else
		{
			self.chat_button_detailpage.enabled = true
		}
		
	}
	
    override func viewDidLoad() {
		super.viewDidLoad();
		if user.roomdic.isEmpty{
			self.chat_button_detailpage.enabled = false
		}
		else
		{
			self.chat_button_detailpage.enabled = true
		}
		self.categoryDetail.text = resta!.locationName
        self.addressDetail.text = resta!.title
		
        self.phoneDetail.text = String(resta!.phoneNumber!)
		self.reloadInputViews()
		
    }
}