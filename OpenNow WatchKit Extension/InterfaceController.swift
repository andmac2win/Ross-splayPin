//
//  InterfaceController.swift
//  OpenNow WatchKit Extension
//
//  Created by andrew Mcdonald on 4/17/15.
//  Copyright (c) 2015 Andrew McDonald. All rights reserved.
//

import WatchKit
import Foundation
import MapKit // added this


class InterfaceController: WKInterfaceController {

    @IBOutlet weak var watchMapView: WKInterfaceMap!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
