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
	
	@IBOutlet weak var resMap: MKMapView!
    @IBAction func considerBtnClick() {
    }
	
    @IBAction func goBtnClick() {
		
    }
    
    override func viewDidLoad() {
		self.categoryDetail.text = resta!.locationName
        self.addressDetail.text = resta!.title
        self.phoneDetail.text = String(resta!.phoneNumber!)
    }
}