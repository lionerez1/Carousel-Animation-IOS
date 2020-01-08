//
//  CarouselAnimationYTranslationTransformer.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationYTranslationTransformer : CarouselAnimationTranformer {
    
    func getYTranslation(ty: CGFloat) -> CATransform3D {
        return CATransform3DTranslate(transformIdentity, 0, ty, 0)
    }
    
    func getYTranslationByDistanceForPreviousMovement(distance: CGFloat, startingValue: CGFloat) -> CATransform3D {
        let newDistance = startingValue + distance
        return CATransform3DTranslate(transformIdentity, 0, newDistance, 0)
    }
}
