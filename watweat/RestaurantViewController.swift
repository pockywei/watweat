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
import AddressBook

class RestaurantViewController: UIViewController {
	
	
	let locationManager = CLLocationManager()
	var annotation: MKPointAnnotation?
	var myLocation = CLLocation()
	
	
	@IBOutlet weak var resMap: MKMapView!
	

	override func viewDidLoad() {
		super.viewDidLoad()
		let artwork = Artwork(title: "Your match location",locationName: ("Restaurant"),
			discipline: "Sculpture",coordinate: CLLocationCoordinate2D(latitude: Double((-37.8132)), longitude: Double((144.963))))
		
		resMap.addAnnotation(artwork)
	}
	
	
	
	
	
	
	
	
}