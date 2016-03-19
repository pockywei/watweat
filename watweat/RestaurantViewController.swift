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

class RestaurantViewController: UIViewController,CLLocationManagerDelegate {
	@IBOutlet weak var resMap: MKMapView!
	@IBAction func BackButton(sender: AnyObject) {
		let isPresentingInAddMealMode = presentingViewController is UINavigationController
		print("1")
		if isPresentingInAddMealMode {
			print("2")
			navigationController!.popViewControllerAnimated(true)
		} else {
			print("3")
			dismissViewControllerAnimated(true, completion: nil)
			
		}

	}
	
	let locationManager = CLLocationManager()
	var annotation: MKPointAnnotation?
	var myLocation = CLLocation()
	// set initial location in Honolulu
	let initialLocation = CLLocation(latitude: -37.8132, longitude: 144.963)
	let regionRadius: CLLocationDistance = 1000
	func centerMapOnLocation(location: CLLocation) {
	let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
	regionRadius * 2.0, regionRadius * 2.0)
	resMap.setRegion(coordinateRegion, animated: true)
	}
	
	
	
	

	override func viewDidLoad() {
		super.viewDidLoad()
		centerMapOnLocation(initialLocation)
		let artwork = Artwork(title: "Your match location",locationName: ("Restaurant"),
			discipline: "Sculpture",coordinate: CLLocationCoordinate2D(latitude: Double((-37.8132)), longitude: Double((144.963))),phoneN: 0405558104)
		
		resMap.addAnnotation(artwork)
		
		self.locationManager.requestAlwaysAuthorization()
		
		// For use in foreground
		self.locationManager.requestWhenInUseAuthorization()
		
		self.resMap.mapType = MKMapType.Standard
		self.resMap.showsUserLocation = true
		//self.MapView.removeAnnotations(self.MapView.annotations)
		
		
		
		if CLLocationManager.locationServicesEnabled() {
			locationManager.delegate = self
			locationManager.desiredAccuracy = kCLLocationAccuracyBest
			locationManager.startUpdatingLocation()
		}
		
		
		

	}
	
	
	
	
	func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
		print("Error while updating location " + error.localizedDescription)
	}
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
	{
		//let location = locations.last!
		
		let center = CLLocationCoordinate2D(latitude: myLocation.coordinate.latitude, longitude: myLocation.coordinate.longitude)
		
		//		print(location.coordinate.latitude)
		//		print(location.coordinate)
		
		
		let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
		
		
		self.resMap.setRegion(region, animated: true)
		
		
		// Add an annotation on Map View
		
		//stop updating location to save battery life
		locationManager.stopUpdatingLocation()
		
	}

	
	
	
	
	
	
}