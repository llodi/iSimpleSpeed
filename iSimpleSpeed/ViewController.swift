//
//  ViewController.swift
//  iSimpleSpeed
//
//  Created by Ilya Dolgopolov on 20/07/16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit
import CoreLocation
import Foundation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationMamager = CLLocationManager()
    var speed = 0.0
    var maxSpeed = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationMamager.requestAlwaysAuthorization()
        locationMamager.requestWhenInUseAuthorization()
        
        locationMamager.desiredAccuracy = kCLLocationAccuracyBest
        locationMamager.delegate = self
        locationMamager.startUpdatingLocation()
    }
    
    func getMaxSpeed (one: Double, two: Double) -> Double {
        if one > two {
            return one
        } else {
            return two
        }
        
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
        speed = (locations.last?.speed ?? 0.0) * 3.6
        speedLabel.text = "\(Int(speed) ?? 0)"
        
        maxSpeed = getMaxSpeed(maxSpeed,two: (speed))
        maxSpeedLabel.text = "\(Int(maxSpeed) ?? 0)"
        
        print ("\(speed * 3.6) km/h and max speed \(maxSpeed) km/h")

    }
    

    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var maxSpeedLabel: UILabel!

}

