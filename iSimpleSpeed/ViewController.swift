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

class ViewController: UIViewController, SpeedometerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SpeedManager.speedManager.delegate = self
        if let location = SpeedManager.speedManager.locationManager {
            location.startUpdatingLocation()
        }
    }
    
    func updateSpeedometer(_ speed: Double, maxSpeed: Double, gpsSignalQuality: String) {
        speedLabel?.text = "\(Int(speed))"
        maxSpeedLabel?.text = "\(Int(maxSpeed))"
        gpsSignal?.text = gpsSignalQuality
        scaleSpeed.counter = Int(speed)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        //locationMamager.stopUpdatingLocation()
        //print("Stop get location!")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)        
        //print("Start get location!")
    }
    

    @IBOutlet weak var scaleSpeed: CircleView! 
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var maxSpeedLabel: UILabel!
    @IBOutlet weak var gpsSignal: UILabel!
    
}
