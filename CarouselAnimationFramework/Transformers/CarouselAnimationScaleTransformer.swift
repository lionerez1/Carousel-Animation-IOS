//
//  CarouselAnimationScaleTransformer.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationScaleTransformer : CarouselAnimationTranformer {
    
    func getScaleTransform(toX: CGFloat, toY: CGFloat) -> CATransform3D {
        return CATransform3DScale(transformIdentity, toX, toY, 1)
    }
    
    func getYScaleTransformByDistance(distance: CGFloat) -> CATransform3D {
        let newYScale: CGFloat = 1 - distance / 100
        return CATransform3DScale(transformIdentity, 1, newYScale, 1)
    }
    
    func getXScaleTransformByDistance(distace: CGFloat) -> CATransform3D {
        let newXScale: CGFloat = 1 - distace / 100
        return CATransform3DScale(transformIdentity, newXScale, 1, 1)
    }
}
