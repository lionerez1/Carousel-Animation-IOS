//
//  CarouselAnimationMovementHandler.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationMovementHandler {
    private let maximumDistance: CGFloat
    private let maximumDistanceForPrevious: CGFloat
    private let contract: CarouselAnimationMovementHandlerContract
    
    init(maximumDistance: CGFloat, listener: CarouselAnimationMovementHandlerContract) {
        self.maximumDistance = maximumDistance
        self.maximumDistanceForPrevious = maximumDistance / 2
        self.contract = listener
    }
    
    func handleMovementWhenAnimationPlaying(xDistance: CGFloat) {
        if xDistance > 50 {
            self.contract.addPreviousAnimationToStack()
        }
        
        if xDistance < -50 {
            self.contract.addNextAnimationToStack()
        }
    }
    
    func handleMovementWhenAnimationNotPlaying(yDistance: CGFloat, xDistance: CGFloat) {
        if xDistance > 50 || xDistance < -50 {
            handleHorizontalMovement(xDistance: xDistance)
        } else {
            let calculatedYDistance: CGFloat = yDistance / 3
            handleVerticalMovement(yDistance: calculatedYDistance)
        }
    }
    
    private func handleHorizontalMovement(xDistance: CGFloat) {
        if xDistance > 50 {
            self.contract.playPreviousAnimation()
            return
        }
        
        if xDistance < -50 {
            self.contract.playNextAnimation()
            return
        }
    }
    
    private func handleVerticalMovement(yDistance: CGFloat) {
        if yDistance < 0 {
            handleNextMovement(distance: abs(yDistance))
        } else {
            handlePreviousMovement(distance: yDistance)
        }
    }
    
    private func handleNextMovement(distance: CGFloat) {
        if distance < self.maximumDistance {
            self.contract.handleNextMovement(distance: distance)
        } else {
            self.contract.playNextAnimation()
        }
    }
    
    private func handlePreviousMovement(distance: CGFloat) {
        
        if distance < self.maximumDistanceForPrevious {
            self.contract.handlePreviousMovement(distance: distance)
        } else {
            self.contract.playPreviousAnimation()
        }
    }
}

