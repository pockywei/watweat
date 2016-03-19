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
        self.addressDetail.text = resta?.locationName
        self.phoneDetail.text = String(resta?.phoneNumber)
    }
}