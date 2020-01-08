//
//  CarouselAnimationSecondaryScaleAnimation.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationSecondaryScaleAnimation : CarouselAnimationBaseAnimation {
    
    init(wrapper: CarouselAnimationItemViewWrapper, toScale: CarouselAnimationWrapperValues) {
        super.init(wrapper: wrapper, toWrapperModel: toScale, contract: nil)
    }
    
    public func play() {
        self.playAnimation()
    }
    
    private func playAnimation() {
        UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveEaseInOut, animations: {
            let translate = self.translationTransformer.getYTranslation(ty: self.toWrapperModel.translationY)
            let scale = self.scaleTransformer.getScaleTransform(toX: self.toWrapperModel.scaleX, toY: self.toWrapperModel.scaleY)
            let rotation = self.rotationTransformer.getRotationByWantedDegree(degree: Float(3))
            self.wrapper.layer.transform = CATransform3DConcat(rotation, CATransform3DConcat(scale, translate))
            self.wrapper.layer.zPosition = self.toWrapperModel.zPosition
        }, completion: { (finished: Bool) in
            if (finished) {
                
            }
        })
    }
}

