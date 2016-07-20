//
//  ViewController.swift
//  iSimpleSpeed
//
//  Created by Ilya Dolgopolov on 20/07/16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    var locationMamager = CLLocationManager()
    var speed = 0.0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationMamager.requestAlwaysAuthorization()
        locationMamager.requestWhenInUseAuthorization()
        
        locationMamager.desiredAccuracy = kCLLocationAccuracyBest
        locationMamager.delegate = self
        locationMamager.startUpdatingLocation()
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locationMamager.location {
            speed = location.speed
            speedLabel.text = "\(speed * 3.6)"
            print ("\(speed * 3.6)")
        }
    }
    

    @IBOutlet weak var speedLabel: UILabel!

}

