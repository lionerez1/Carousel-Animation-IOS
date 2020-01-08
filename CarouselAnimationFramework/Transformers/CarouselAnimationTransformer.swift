//
//  CarouselAnimationTransformer.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationTranformer {
    var transformIdentity = CATransform3DIdentity

    init() {
        self.transformIdentity.m34 = -1.0 / 450
    }
    
    func degrees2Radians(_degrees: Float) -> CGFloat {
        return CGFloat(_degrees * .pi / 180)
    }
}
