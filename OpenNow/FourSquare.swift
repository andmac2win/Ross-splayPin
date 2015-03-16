//
//  FourSquare.swift
//  OpenNow
//
//  Created by andrew Mcdonald on 3/10/15.
//  Copyright (c) 2015 Andrew McDonald. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation

let API_URL = "https://api.foursquare.com/v2/"
let CLIENT_ID = "E4Y10SM2AOSG3TG2KGQQXHUCXV3W04HKQKVVLCVBIGDICQKJ"
let CLIENT_SECRET = "OWWVQIRNWKMWHLTJNQDNDSZXCNJ5CED42J0MC4Y1POV2CK44"


class FourSquareRequest: NSObject {
    
    class func requestVenuesWithLocation(location: CLLocation) ->
        [AnyObject] {
            
            let requestString = "\(API_URL)venues/explore?client_id=\(CLIENT_ID)&client_secret=\(CLIENT_SECRET)&v=20130815&ll=\(location.coordinate.latitude),\(location.coordinate.longitude)&query=food&openNow=1&drinks"/////check into drinks and gas stations
            
            println(requestString)
            
            if let url = NSURL(string: requestString) {
                
                let request = NSURLRequest(URL: url)
                
                if let data = NSURLConnection.sendSynchronousRequest(request, returningResponse: nil, error: nil) {
                    
                    
                    if let returnInfo = NSJSONSerialization.JSONObjectWithData(data, options: .MutableContainers, error: nil) as? [String:AnyObject] {
                        
//                        println(returnInfo)
                        
                        let responseInfo = returnInfo["response"] as [String:AnyObject]
                        
                        var venues: [[String:AnyObject]] = []
                        
                        let groups = responseInfo["groups"] as [[String:AnyObject]]
                        
                        for group in groups {
                            
                            let items = group["items"] as [[String:AnyObject]]
                            
                            for item in items {
                                
                                let venue = item["venue"] as [String:AnyObject]
                                venues.append(venue)
                                
                               
                                
                            }
                            
                            
                        }
//                        
//                        println("my: \(venues)")
                        
                        return venues
                        
                        
                        
                    }
                    
                }
                
            }
            
            
            //TODO: add implementation to return venues
            
            return[]
            
    }
    
}