//
//  RotateImageView.swift
//  EzOrder(Cus)
//
//  Created by Lee Chien Kuan on 2019/5/29.
//  Copyright © 2019 TerryLee. All rights reserved.
//

import Foundation
import UIKit

class RotateImageView: UIImageView {
    var currentValue: Double = 0
    
    func rotateGradually(handler: @escaping () -> ()) -> Int {
        var point = 0
        let randomDouble = Double.random(in: 0..<2 * Double.pi)
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        CATransaction.begin()
        
        rotateAnimation.fromValue = currentValue
        currentValue = currentValue + 100 * Double.pi + randomDouble
        let value = currentValue.truncatingRemainder(dividingBy: Double.pi * 2)
//        let degree = Measurement(value: value, unit: UnitAngle.radians).converted(to: .degrees)
        print(value)
        let degree = value * 180 / Double.pi
        switch degree {
        case 0..<45:
            point = 1
        case 45..<90:
            point = 2
        case 90..<135:
            point = 3
        case 135..<180:
            point = 4
        case 180..<225:
            point = 5
        case 225..<270:
            point = 6
        case 270..<315:
            point = 7
        case 315..<360:
            point = 8
        default:
            point = 0
        }
        rotateAnimation.toValue = currentValue
        rotateAnimation.isRemovedOnCompletion = false
        rotateAnimation.fillMode = .forwards
        rotateAnimation.duration = 3.5
        
        rotateAnimation.repeatCount = 1
        CATransaction.setCompletionBlock {
            if self.currentValue >= Double.pi * 2 {
                self.currentValue -= Double.pi * 2
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                handler()
            }
        }
        rotateAnimation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeOut)
        self.layer.add(rotateAnimation, forKey: nil)
        
        CATransaction.commit()
        return point
    }
}
