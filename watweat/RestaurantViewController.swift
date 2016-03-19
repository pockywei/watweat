//
//  RestaurantViewController.swift
//  watweat
//
//  Created by WEI on 16/3/19.
//  Copyright © 2016年 WEI. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class RestaurantViewController: UIViewController {
	
	
	let locationManager = CLLocationManager()
	var annotation: MKPointAnnotation?
	var myLocation = CLLocation()
	
	@IBOutlet weak var resMap: MKMapView!
	
	
}