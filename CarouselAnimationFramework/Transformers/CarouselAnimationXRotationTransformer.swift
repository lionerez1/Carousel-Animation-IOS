//
//  CarouselAnimationXRotationTransformer.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationXRotationTransformer : CarouselAnimationTranformer {
    
    func getDefaultRotatationTransform() -> CATransform3D {
        return CATransform3DRotate(transformIdentity, degrees2Radians(_degrees: 3), -1.0, 0.0, 0.0)
    }
    
    func getRotationByDistance(distance: CGFloat) -> CATransform3D {
        let degree: Float = Float(4 + distance / 20)
        return CATransform3DRotate(transformIdentity, degrees2Radians(_degrees: degree), -1, 0, 0)
    }
    
    func getRotationByWantedDegree(degree: Float) -> CATransform3D {
        return CATransform3DRotate(transformIdentity, degrees2Radians(_degrees: degree), -1, 0, 0)
    }
}
