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
	
	var locationManager = CLLocationManager()
	
	
	
	
	
	var annotation: MKPointAnnotation?
	var myLocation = CLLocation()
	// set initial location in Honolulu
	//let initialLocation = CLLocation(latitude: -37.8132, longitude: 144.963)
	let regionRadius: CLLocationDistance = 1000
	func centerMapOnLocation(location: CLLocation) {
	let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
	regionRadius * 2.0, regionRadius * 2.0)
	resMap.setRegion(coordinateRegion, animated: true)
	}
	
	
	
	

	override func viewDidLoad() {
		super.viewDidLoad()
		
		let tapGesture = UITapGestureRecognizer(target: self, action: Selector("handleTap:"))
		
		
		let artwork = Artwork(title: "SYD Tower",locationName: ("SYD Tower Buffet!!"),
			discipline: "Sculpture",coordinate: CLLocationCoordinate2D(latitude: Double((-33.8705)), longitude: Double((151.2089))),phoneN: 0405558104)
		
		
		resMap.addAnnotation(artwork)
		
		//=====================================
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		//=========================================
		
		
		// For use in foreground
		
		self.resMap.mapType = MKMapType.Standard
		self.resMap.showsUserLocation = true
		//self.MapView.removeAnnotations(self.MapView.annotations)
		
		
		
		
		
		
		

	}
	
	
	
	
	func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
		print("Error while updating location " + error.localizedDescription)
	}
	
	func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation])
	{
		//let location = locations.last!
		var coord = CLLocationCoordinate2D()
		coord.longitude = locations[0].coordinate.longitude;
		coord.latitude = locations[0].coordinate.latitude;
		let initialLocation = CLLocation(latitude: coord.latitude, longitude: coord.longitude)
		centerMapOnLocation(initialLocation)
		print(coord.longitude)
		//stop updating location to save battery life
		locationManager.stopUpdatingLocation()
		
	}

	
	
	func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
		
		if annotation is MKUserLocation {
			return nil
		}
		
		let reuseId = "pin"
		
		var pinView = mapView.dequeueReusableAnnotationViewWithIdentifier(reuseId)
		if pinView == nil {
			pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
			pinView?.canShowCallout = true
			
			let rightButton: AnyObject! = UIButton(type: UIButtonType.DetailDisclosure)
			rightButton.titleForState(UIControlState.Normal)
			
			pinView!.rightCalloutAccessoryView = rightButton as! UIView
		}
		else {
			pinView?.annotation = annotation
		}
		
		return pinView
	}
	
	func mapView(mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
		if control == view.rightCalloutAccessoryView {
			performSegueWithIdentifier("toTheMoon", sender: view)
		}
	}
	
	
}