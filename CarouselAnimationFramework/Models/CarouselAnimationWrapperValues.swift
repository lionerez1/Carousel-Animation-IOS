//
//  CarouselAnimationWrapperValues.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

struct CarouselAnimationWrapperValues {
    let scaleX: CGFloat
    let scaleY: CGFloat
    let translationY: CGFloat
    let zPosition: CGFloat
    
    init(scaleX: CGFloat, scaleY: CGFloat, translationY: CGFloat, zPosition: CGFloat) {
        self.scaleX = scaleX
        self.scaleY = scaleY
        self.translationY = translationY
        self.zPosition = zPosition
    }
}
