//
//  MapViewController.swift
//  OpenNow
//
//  Created by andrew Mcdonald on 3/10/15.
//  Copyright (c) 2015 Andrew McDonald. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

var onceToken:dispatch_once_t = 0

class MyPointAnnotation: MKPointAnnotation{
    
    var index: Int = 0
    var name: String? = nil
    var hoursOfOpperation: String? = nil
}

class MapViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate  {
    
    @IBOutlet weak var mapView: MKMapView!
    
    
    
    var lManager = CLLocationManager()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.navigationController?.navigationBar.hidden = true
        
        mapView.delegate = self
        
        mapView.frame = view.frame
        
        view.addSubview(mapView)
        
        lManager.requestWhenInUseAuthorization()
        
        
        
        lManager.delegate = self
        
        lManager.desiredAccuracy = kCLLocationAccuracyBest
        
        lManager.distanceFilter = kCLDistanceFilterNone
        
        lManager.startUpdatingLocation()
        
        // added from maps project DONT THINK I NEED THIS
        
        if CLLocationManager.locationServicesEnabled() {
            lManager.delegate = self
            lManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            lManager.startUpdatingLocation()
            
        }
    }
    
    
    func locationManager(manager: CLLocationManager!, didUpdateLocations locations: [AnyObject]!) {
        
        mapView.showsUserLocation = true
        
        
        
        dispatch_once(&onceToken) { () -> Void in
            
            println(locations.last)
            
            if let location = locations.last as? CLLocation {
                // CHECK THIS OUT TOO
                //                self.mapView.centerCoordinate = location.coordinate
                
                let span = MKCoordinateSpanMake(0.1, 0.1)
                
                let region = MKCoordinateRegion(center: location.coordinate, span: span)
                
                self.mapView.setRegion(region, animated: true)
                
                let venues = FourSquareRequest.requestVenuesWithLocation(location)
                
                println(venues)
                
                self.createAnnotationsWithVenues(venues)
                
                //
                //                var annotationArray = self.mapView.annotations
                //                self.mapView.showAnnotations(annotationArray, animated: true)
                
                
                
                
                
            }
            
        }
        
        lManager.stopUpdatingLocation()
        
    }
    
    
    func createAnnotationsWithVenues(venues: [AnyObject]) {
        
        for (i,venue) in enumerate(venues as [[String:AnyObject]]) {
            
            let annotation = MyPointAnnotation()
            
            let locationInfo = venue["location"] as [String:AnyObject]
          
            let nameInfo = venue["name"] as NSString!
            annotation.name = nameInfo
            
            let photo = venue["photos"] as [String:AnyObject]
            
            let times = venue["hours"] as [String:AnyObject]
            
            let lat = locationInfo["lat"] as CLLocationDegrees
            let lng = locationInfo["lng"] as CLLocationDegrees
            
            let coordinate = CLLocationCoordinate2DMake(lat,lng)
            
            
            
            annotation.title = venue["name"] as String!
            annotation.index = i
            annotation.setCoordinate(coordinate)
            
            mapView.addAnnotation(annotation)
            
            // need some shit here to display some shit
            
        }
        
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
//    
//        
//        
//        if annotation is MKUserLocation {
//            //return nil so map view draws "blue dot" for standard user location
//            return nil
//        }
//        
//        
//        let reuseId = "pin"
//        
//        var pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//        pinView!.canShowCallout = true
//        pinView!.animatesDrop = true
//        pinView!.pinColor = .Red
// 
//        
//        
//        return pinView
//    }

    func buttonPressed (sender : ArrowButton!) {
        println("button Pressed")
        
        self.performSegueWithIdentifier("info", sender: ArrowButton())
        
        
    }
    
  func mapView(mapView: MKMapView!, viewForAnnotation annotation: MKAnnotation!) -> MKAnnotationView! {
    
//        println("view for anno")
    
    
    
    
    if annotation is MKUserLocation {
        return nil
    }
    
        var annotationView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: "myAnn")
        
        var rightArrowButton = ArrowButton(frame: CGRectMake(0, 0, 22, 22))
        
        rightArrowButton.strokeSize = 2
        rightArrowButton.strokeColor = UIColor.redColor()
        rightArrowButton.leftInset = 8
        rightArrowButton.rightInset = 8
        rightArrowButton.topInset = 5
        rightArrowButton.bottomInset = 5
    
        annotationView.rightCalloutAccessoryView = rightArrowButton
        annotationView.canShowCallout = true
    
        
        annotationView.rightCalloutAccessoryView = UIButton.buttonWithType(UIButtonType.DetailDisclosure) as UIView
        
     return annotationView
    
    }
    

   func mapView(MapView: MKMapView!, annotationView view: MKAnnotationView!, calloutAccessoryControlTapped control: UIControl!) {
    
    var infoViewController = storyboard?.instantiateViewControllerWithIdentifier("info") as InfoViewController
    infoViewController.annotation = view.annotation as? MyPointAnnotation
    
    self.navigationController?.pushViewController(infoViewController, animated: true)
 //   presentViewController(infoViewController, animated: true, completion: nil)
    
    }

    func mapView(mapView: MKMapView!, didSelectAnnotationView view: MKAnnotationView!) {
       
    println("clicked")
    
        
    }
    
   
    
    
}