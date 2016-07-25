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
        
        locationMamager.desiredAccuracy = kCLLocationAccuracyBestForNavigation
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
            
        if let accurancy = locations.last?.horizontalAccuracy where (accurancy > 0 && accurancy < 100) {
            speed = (locations.last?.speed ?? 0.0) / 1000 * 3600
            speedLabel?.text = "\(Int(speed) ?? 0)"
            
            if Int(speed) ?? 0 > 0 {
                scaleSpeed.counter = Int(speed) ?? 0
            }
            
            maxSpeed = getMaxSpeed(maxSpeed,two: (speed))
            maxSpeedLabel?.text = "\(Int(maxSpeed) ?? 0)"
        
            getGpsSignal(accurancy)
            accurancyValue.text = "\(Int(accurancy))"
        }
        //print ("\(speed) km/h and max speed \(maxSpeed) km/h")

    }
    
    private func getGpsSignal(accuracy: CLLocationAccuracy) {
        if accuracy < 0 {
            gpsSignal.text = "None"
        } else if accuracy > 163 {
            gpsSignal.text = "Poor"
        } else if accuracy > 48 {
            gpsSignal.text = "Average"
        } else {
            gpsSignal.text = "Full"
        }
    }
    

    @IBOutlet weak var scaleSpeed: CircleView! {
        didSet {
            scaleSpeed.counter = Int(speed) ?? 0
            //scaleSpeed.scale = scale
        }
    }
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var maxSpeedLabel: UILabel!
    @IBOutlet weak var accurancyValue: UILabel!
    @IBOutlet weak var gpsSignal: UILabel!
    
}