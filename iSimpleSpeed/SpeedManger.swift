//
//  SpeedManger.swift
//  iSimpleSpeed
//
//  Created by Ilya Dolgopolov on 26.07.16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import Foundation
import CoreLocation

protocol SpeedometerDelegate {
    func updateSpeedometer(speed: Double, maxSpeed: Double, gpsSignalQuality: String)
}

class SpeedManager : NSObject, CLLocationManagerDelegate {
    
    
    static let speedManager = SpeedManager()
    
    var locationManager: CLLocationManager?
    
    var delegate: SpeedometerDelegate?
    
    override init() {
        
        super.init()
        
        locationManager = CLLocationManager()
        
        if let lm = locationManager {
            
            if CLLocationManager.authorizationStatus() == CLAuthorizationStatus.NotDetermined {
                lm.requestAlwaysAuthorization()
            }

            lm.requestWhenInUseAuthorization()
            
            lm.desiredAccuracy = kCLLocationAccuracyBestForNavigation
            lm.delegate = self
        }
    }
    
    private func getMaxSpeed (one: Double, two: Double) -> Double {
        if one > two {
            return one
        } else {
            return two
        }
        
    }
    
    private func getGpsSignal(accuracy: CLLocationAccuracy) -> String {
        if accuracy < 0 {
            return "None signal"
        } else if accuracy > 163 {
            return "Poor signal"
        } else if accuracy > 48 {
            return "Average signal"
        } else {
            return "Full signal"
        }
    }
    
    private var maxSpeed = 0.0
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        if let accurancy = locations.last?.horizontalAccuracy where (accurancy > 0 && accurancy < 100) {
            var speed = (locations.last?.speed ?? 0.0) / 1000 * 3600
            speed = speed > 0 ? speed : 0
            maxSpeed = getMaxSpeed(maxSpeed,two: speed)
            let gpsSignalQuality = getGpsSignal(accurancy)
            delegate?.updateSpeedometer(speed, maxSpeed: maxSpeed, gpsSignalQuality: gpsSignalQuality)
        }
    }
    
}