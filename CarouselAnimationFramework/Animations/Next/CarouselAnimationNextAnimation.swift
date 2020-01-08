//
//  CarouselAnimationNextAnimation.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationNextAnimation : CarouselAnimationBaseAnimation {
    var currentAnimationStep: Int
    
    override init(wrapper: CarouselAnimationItemViewWrapper, toWrapperModel: CarouselAnimationWrapperValues, contract: CarouselAnimationBaseAnimationContract?) {
        self.currentAnimationStep = 0
        super.init(wrapper: wrapper, toWrapperModel: toWrapperModel, contract: contract)
    }
    
    func play() {
        self.currentAnimationStep = 1
        self.playAnimationStep()
    }
    
    private func playAnimationStep() {
        switch self.currentAnimationStep {
        case 1:
            self.playFirstStep()
            break
        case 2:
            self.playSecondStep()
            break
        case 3:
            self.contract!.notifyViewInvisible(isNextAnimation: true)
            self.playThirdStep()
            break
        default:
            self.handleAnimationCompleted()
        }
    }
    
    private func playFirstStep() {
        UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveEaseInOut, animations: {
            let translate = self.translationTransformer.getYTranslation(ty: 70)
            let rotation = self.rotationTransformer.getRotationByWantedDegree(degree: Float(70))
            let scale = self.scaleTransformer.getScaleTransform(toX: 0.5, toY: 0.4)
            self.wrapper.layer.transform = CATransform3DConcat(rotation, CATransform3DConcat(scale, translate))
            self.wrapper.layer.zPosition = 140
        }, completion: { (finished: Bool) in
            if (finished) {
                self.handleAnimationStepCompleted()
                self.contract!.startSecondaryAnimation(isNextAnimation: true)
            }
        })
    }
    
    private func playSecondStep() {
        UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveEaseInOut, animations: {
            let translate = self.translationTransformer.getYTranslation(ty: 0)
            let rotation = self.rotationTransformer.getRotationByWantedDegree(degree: Float(183))
            let scale = self.scaleTransformer.getScaleTransform(toX: 0.5, toY: 0.2)
            self.wrapper.layer.transform = CATransform3DConcat(rotation, CATransform3DConcat(scale, translate))
            self.wrapper.layer.zPosition = -100
        }, completion: { (finished: Bool) in
            if (finished) {
                self.handleAnimationStepCompleted()
            }
        })
    }
    
    private func playThirdStep() {
        UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveEaseInOut, animations: {
            let translate = self.translationTransformer.getYTranslation(ty: self.toWrapperModel.translationY)
            let scale = self.scaleTransformer.getScaleTransform(toX: self.toWrapperModel.scaleX, toY: self.toWrapperModel.scaleY)
            let rotation = self.rotationTransformer.getRotationByWantedDegree(degree: Float(183))
            self.wrapper.layer.transform = CATransform3DConcat(rotation, CATransform3DConcat(scale, translate))
        }, completion: { (finished: Bool) in
            if (finished) {
                self.handleAnimationStepCompleted()
            }
        })
    }
    
    private func handleAnimationStepCompleted() {
        self.currentAnimationStep += 1
        self.playAnimationStep()
    }
    
    private func handleAnimationCompleted() {
        self.currentAnimationStep = 0
        let translate = self.translationTransformer.getYTranslation(ty: self.toWrapperModel.translationY)
        let scale = self.scaleTransformer.getScaleTransform(toX: self.toWrapperModel.scaleX, toY: self.toWrapperModel.scaleY)
        let rotation = self.rotationTransformer.getRotationByWantedDegree(degree: Float(3))
        self.wrapper.layer.transform = CATransform3DConcat(rotation, CATransform3DConcat(scale, translate))
        self.wrapper.layer.zPosition = self.toWrapperModel.zPosition
        self.contract!.onAnimationDonePlaying(isNextAnimation: true)
    }
}
