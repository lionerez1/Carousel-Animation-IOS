//
//  CarouselAnimationBottomShadowWrapper.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

internal class CarouselAnimationBottomShadowWrapper : UIView {
    private var child: UIImageView?
    private var transformer: CarouselAnimationBottomShadowWrapperTransformer?
    
    public func initialize(child: UIImageView) {
        self.child = child
        self.addSubview(child)
        self.transformer = CarouselAnimationBottomShadowWrapperTransformer(wrapper: self)
    }
    
    public func handleMovement(distance: CGFloat) {
        self.transformer!.setTransformByDistance(distance: distance)
    }
}
