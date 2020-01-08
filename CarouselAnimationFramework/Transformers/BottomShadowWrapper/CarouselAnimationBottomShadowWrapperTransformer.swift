//
//  CarouselAnimationBottomShadowWrapperTransformer.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationBottomShadowWrapperTransformer {
    private let wrapper: CarouselAnimationBottomShadowWrapper
    private let scaleTransformer: CarouselAnimationScaleTransformer

    init(wrapper: CarouselAnimationBottomShadowWrapper) {
        self.wrapper = wrapper
        self.scaleTransformer = CarouselAnimationScaleTransformer()
    }
    
    public func setTransformByDistance(distance: CGFloat) {
        let scale = scaleTransformer.getXScaleTransformByDistance(distace: distance)
        self.wrapper.layer.transform = scale
    }
}
