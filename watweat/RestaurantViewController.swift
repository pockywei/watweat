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

class RestaurantViewController: UIViewController,MKMapViewDelegate,CLLocationManagerDelegate {
	@IBOutlet weak var resMap: MKMapView!
	
	var locationManager = CLLocationManager()
	
	
	
	
	
	let annotation = MKPointAnnotation()
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
		
		//=====================================
		locationManager.delegate = self
		locationManager.desiredAccuracy = kCLLocationAccuracyBest
		locationManager.requestWhenInUseAuthorization()
		locationManager.startUpdatingLocation()
		//=========================================
		
		
		self.resMap.delegate=self
		annotation.title="SYD Tower"
		annotation.subtitle="SYD Tower Buffet!!"
		annotation.coordinate=CLLocationCoordinate2D(latitude: Double((-33.8705)), longitude: Double((151.2089)))
		let artwork = Artwork(title: "SYD Tower",locationName: ("SYD Tower Buffet!!"),
			discipline: "Sculpture",coordinate: CLLocationCoordinate2D(latitude: Double((-33.8705)), longitude: Double((151.2089))),phoneN: 0405558104)
		
		let span = MKCoordinateSpanMake(0.003, 0.003)

		let region = MKCoordinateRegionMake(annotation.coordinate, span)

		resMap.setRegion(region, animated:true)
		resMap.addAnnotation(annotation)
		
	
		
		
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

	func mapView(resMap: MKMapView, regionWillChangeAnimated animated: Bool) {
		print(__FUNCTION__)
	}
	
	func mapView(resMap: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
		print("ssssssss")
		if annotation is MKUserLocation {
			return nil
		}
		
		let reuseId = "pin"
		
		var pinView = resMap.dequeueReusableAnnotationViewWithIdentifier(reuseId)
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
			performSegueWithIdentifier("ShowResDetailSegue", sender: view)
		}
	}
	
	
}