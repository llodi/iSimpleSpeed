//
//  CircleView.swift
//  iSimpleSpeed
//
//  Created by Ilya Dolgopolov on 21/07/16.
//  Copyright © 2016 Ilya Dolgopolov. All rights reserved.
//

import UIKit

@IBDesignable
class CircleView: UIView {
    
    struct CircleConstants {
        static let P: CGFloat = CGFloat(M_PI)
        static let OutLineOffsett: CGFloat = 2.5
    }
   
    @IBInspectable
    var counter: Int = 10 {
        didSet {
            if counter > maxSpeed {
                counter = maxSpeed
            }
            setNeedsDisplay()
        }
    }
    
    fileprivate var scale: CGFloat {

        var scale: CGFloat = 0.7
        
        if bounds.width > bounds.height {
            scale = bounds.height / bounds.width
        } else {
            scale = bounds.width / bounds.height
        }
        
        return scale
    }
    
    @IBInspectable
    var outLineColor: UIColor = UIColor.green { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var counterColor: UIColor = UIColor.orange { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var lineWidth: CGFloat = 5.0 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var verticalCirclePosition: CGFloat = 20.0 { didSet { setNeedsDisplay() } }
    
    @IBInspectable
    var  maxSpeed: Int = 200
    
       
    override func draw(_ rect: CGRect) {
        
        var center: CGPoint {
            return CGPoint(x: bounds.midX, y: bounds.midY + verticalCirclePosition)
        }
        
        let radius: CGFloat = max(bounds.width, bounds.height) / 2 * scale
        
        let arcWidth: CGFloat = 64
        
        let startAngle: CGFloat = 3 * CircleConstants.P / 4
        let endAngle: CGFloat = CircleConstants.P / 4
        
        let path = UIBezierPath (
            arcCenter: center,
            radius: radius - arcWidth / 2 ,
            startAngle: startAngle,
            endAngle: endAngle,
            clockwise: true
        )
        
        path.lineWidth = arcWidth
        counterColor.setStroke()
        path.stroke()
        
        
        let angleDifference: CGFloat = 2 * CircleConstants.P  - startAngle + endAngle
        
        let arcLenthPer = angleDifference / CGFloat(maxSpeed)
        
        let outLineEndAngle = arcLenthPer * CGFloat(counter) + startAngle
        
        let outLinePath = UIBezierPath(
            arcCenter: center,
            radius: radius - CircleConstants.OutLineOffsett,
            startAngle: startAngle,
            endAngle: outLineEndAngle,
            clockwise: true
        )
        
        outLinePath.addArc(
            withCenter: center,
            radius: (radius - arcWidth + CircleConstants.OutLineOffsett),
            startAngle: outLineEndAngle,
            endAngle: startAngle,
            clockwise: false
        )
        
        outLinePath.close()
        
        outLineColor.setStroke()
        outLinePath.lineWidth = lineWidth
        outLinePath.stroke()
        
    }
    
}
