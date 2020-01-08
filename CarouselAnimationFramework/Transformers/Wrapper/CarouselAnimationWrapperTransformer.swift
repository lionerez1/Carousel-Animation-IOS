//
//  CarouselAnimationWrapperTransformer.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationWrapperTransformer {
    private let wrapper: CarouselAnimationItemViewWrapper
    private let wrapperValues: CarouselAnimationWrapperValues
    private let translateTransformer: CarouselAnimationYTranslationTransformer
    private let rotationTransformer: CarouselAnimationXRotationTransformer
    private let scaleTransformer: CarouselAnimationScaleTransformer
    
    init(wrapper: CarouselAnimationItemViewWrapper, wrapperValues: CarouselAnimationWrapperValues) {
        self.wrapper = wrapper
        self.wrapperValues = wrapperValues
        self.translateTransformer = CarouselAnimationYTranslationTransformer()
        self.rotationTransformer = CarouselAnimationXRotationTransformer()
        self.scaleTransformer = CarouselAnimationScaleTransformer()
    }
    
    func setDefaultTransformers() {
        let scale = self.scaleTransformer.getScaleTransform(toX: self.wrapperValues.scaleX, toY: self.wrapperValues.scaleY)
        let rotation = self.rotationTransformer.getRotationByWantedDegree(degree: 3)
        let translate = self.translateTransformer.getYTranslation(ty: self.wrapperValues.translationY)
        self.wrapper.layer.transform = CATransform3DConcat(rotation, CATransform3DConcat(scale, translate))
    }
    
    func handleNextMovement(distance: CGFloat) {
        let translate = self.translateTransformer.getYTranslation(ty: distance)
        let rotation = self.rotationTransformer.getRotationByDistance(distance: distance)
        let scale = self.scaleTransformer.getYScaleTransformByDistance(distance: distance)
        self.wrapper.layer.transform = CATransform3DConcat(rotation, CATransform3DConcat(scale, translate))
    }
    
    func handlePreviousMovement(distance: CGFloat) {
        let translate = self.translateTransformer.getYTranslationByDistanceForPreviousMovement(distance: distance, startingValue: self.wrapperValues.translationY)
        let scale = self.scaleTransformer.getScaleTransform(toX: self.wrapperValues.scaleX, toY: self.wrapperValues.scaleY)
        let rotation = self.rotationTransformer.getRotationByDistance(distance: distance * -1)
        self.wrapper.layer.transform = CATransform3DConcat(rotation, CATransform3DConcat(scale, translate))
    }
}
