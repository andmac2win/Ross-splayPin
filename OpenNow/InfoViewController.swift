//
//  InfoViewController.swift
//  OpenNow
//
//  Created by andrew Mcdonald on 3/9/15.
//  Copyright (c) 2015 Andrew McDonald. All rights reserved.
//

import UIKit
import MapKit

class InfoViewController: UIViewController {
 
    @IBOutlet weak var venuePictureView: UIView!
  
    
    @IBOutlet weak var nameLabel: UILabel!
   
  //  var nameLabel: UILabel = "name"
    
    //seatNameLabel.text = FeedData.mainData().selectedSeat?["name"] as? String try something like this
    
    @IBOutlet weak var addressLabel: UILabel!
    
    
    @IBOutlet weak var hoursOfOperationLabel: UILabel!
    
    var annotation: MyPointAnnotation? = nil

    // myLabel.numberOfLines = 0;
   // [myLabel sizeToFit]; for label in obj c
   
    
    //var newSeatSB = UIStoryboard(name: "NewSeat", bundle: nil)
    //var newSeatVC = newSeatSB.instantiateInitialViewController() as NewSeatViewController
   // presentViewController(newSeatVC, animated: true, completion:nil)
  
 
    
    @IBAction func routeToAddressButton(sender: UIButton) {
        
        
    }
    
//    @IBAction func backButton(sender: AnyObject) {
//    
//    
//        
//        var MapViewController = storyboard?.instantiateViewControllerWithIdentifier("map") as MapViewController
//        
//        self.navigationController?.pushViewController(MapViewController, animated: true)
//   
//    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = annotation?.name
        hoursOfOperationLabel.text = annotation?.hoursOfOpperation


        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
  
  
 


}
