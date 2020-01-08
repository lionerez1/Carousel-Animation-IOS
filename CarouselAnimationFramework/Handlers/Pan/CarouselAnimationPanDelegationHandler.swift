//
//  CarouselAnimationPanDelegationHandler.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationPanDelegationHandler {
    private var startingPoint: CGPoint
    private var lastDetectedPoint: CGPoint
    private var isTrackingMovement: Bool
    
    init() {
        self.startingPoint = CGPoint()
        self.lastDetectedPoint = CGPoint()
        self.isTrackingMovement = true
    }
    
    func setLastDetectedPoint(point: CGPoint) {
        self.lastDetectedPoint = point
    }
    
    func resetPoints() {
        self.startingPoint = CGPoint()
        self.lastDetectedPoint = CGPoint()
    }
    
    func getYDistance() -> CGFloat {
        return startingPoint.y - lastDetectedPoint.y
    }
    
    func getXDistance() -> CGFloat {
        return startingPoint.x - lastDetectedPoint.x
    }
    
    func disableTracking() {
        self.isTrackingMovement = false
    }
    
    func enableTracking() {
        self.isTrackingMovement = true
    }
    
    func isTracking() -> Bool {
        return self.isTrackingMovement
    }
}

