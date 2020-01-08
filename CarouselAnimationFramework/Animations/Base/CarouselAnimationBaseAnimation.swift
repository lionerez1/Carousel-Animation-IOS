//
//  CarouselAnimationBaseAnimation.swift
//  CarouselAnimationFramework
//
//  Created by Lion Erez on 08/01/2020.
//  Copyright © 2020 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationBaseAnimation {
    let animationStepTime: Double = 0.25
    let wrapper: CarouselAnimationItemViewWrapper
    let translationTransformer: CarouselAnimationYTranslationTransformer
    let rotationTransformer: CarouselAnimationXRotationTransformer
    let scaleTransformer: CarouselAnimationScaleTransformer
    let toWrapperModel: CarouselAnimationWrapperValues
    let contract: CarouselAnimationBaseAnimationContract?
    
    init(wrapper: CarouselAnimationItemViewWrapper, toWrapperModel: CarouselAnimationWrapperValues, contract: CarouselAnimationBaseAnimationContract?) {
        self.wrapper = wrapper
        self.translationTransformer = CarouselAnimationYTranslationTransformer()
        self.rotationTransformer = CarouselAnimationXRotationTransformer()
        self.scaleTransformer = CarouselAnimationScaleTransformer()
        self.toWrapperModel = toWrapperModel
        self.contract = contract
    }
}
