//
//  CarouselAnimationMovementHandlerContract.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

protocol CarouselAnimationMovementHandlerContract {
    func handleNextMovement(distance: CGFloat)
    
    func handlePreviousMovement(distance: CGFloat)
    
    func playNextAnimation()
    
    func playPreviousAnimation()
    
    func addNextAnimationToStack()
    
    func addPreviousAnimationToStack()
}
