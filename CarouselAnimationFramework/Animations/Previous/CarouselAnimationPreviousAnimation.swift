//
//  CarouselAnimationPreviousAnimation.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationPreviousAnimation : CarouselAnimationBaseAnimation {
    private var currentAnimationStep: Int
    private let currentWrapperValues: CarouselAnimationWrapperValues

    init(wrapper: CarouselAnimationItemViewWrapper, toWrapperModel: CarouselAnimationWrapperValues, currentWrapperValues: CarouselAnimationWrapperValues, listener: CarouselAnimationBaseAnimationContract) {
        self.currentAnimationStep = 0
        self.currentWrapperValues = currentWrapperValues
        super.init(wrapper: wrapper, toWrapperModel: toWrapperModel, contract: listener)
    }
    
    public func play() {
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
            self.playThirdStep()
            break;
        case 4:
            self.playFourthdStep()
            break;
        default:
            self.handleAnimationCompleted()
        }
    }
    
    private func playFirstStep() {
        UIView.animate(withDuration: self.animationStepTime / 2, delay: 0, options: .curveEaseInOut, animations: {
            let translate = self.translationTransformer.getYTranslation(ty: 30)
            let rotation = self.rotationTransformer.getRotationByWantedDegree(degree: 3)
            let scale = self.scaleTransformer.getScaleTransform(toX: self.currentWrapperValues.scaleX, toY: self.currentWrapperValues.scaleY)
            self.wrapper.layer.transform = CATransform3DConcat(rotation, CATransform3DConcat(scale, translate))
        }, completion: { (finished: Bool) in
            if (finished) {
                self.contract!.notifyViewInvisible(isNextAnimation: false)
                self.handleAnimationStepCompleted()
            }
        })
    }
    
    private func playSecondStep() {
        UIView.animate(withDuration: self.animationStepTime / 2, delay: 0, options: .curveEaseInOut, animations: {
            let translate = self.translationTransformer.getYTranslation(ty: 70)
            let rotation = self.rotationTransformer.getRotationByWantedDegree(degree: 3)
            let scale = self.scaleTransformer.getScaleTransform(toX: self.currentWrapperValues.scaleX, toY: self.currentWrapperValues.scaleY)
            self.wrapper.layer.transform = CATransform3DConcat(rotation, CATransform3DConcat(scale, translate))
        }, completion: { (finished: Bool) in
            if (finished) {
                self.handleAnimationStepCompleted()
            }
        })
    }
    
    private func playThirdStep() {
        UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveEaseInOut, animations: {
            let translate = self.translationTransformer.getYTranslation(ty: 160)
            let rotation = self.rotationTransformer.getRotationByWantedDegree(degree: 40)
            let scale = self.scaleTransformer.getScaleTransform(toX: 0.6, toY: 0.4)
            self.wrapper.layer.transform = CATransform3DConcat(rotation, CATransform3DConcat(scale, translate))
            self.wrapper.layer.zPosition = -100
        }, completion: { (finished: Bool) in
            if (finished) {
                self.handleAnimationStepCompleted()
                self.contract!.startSecondaryAnimation(isNextAnimation: false)
            }
        })
    }
    
    private func playFourthdStep() {
        UIView.animate(withDuration: self.animationStepTime, delay: 0, options: .curveEaseInOut, animations: {
            let translate = self.translationTransformer.getYTranslation(ty: self.toWrapperModel.translationY)
            let rotation = self.rotationTransformer.getRotationByWantedDegree(degree: 3)
            let scale = self.scaleTransformer.getScaleTransform(toX: self.toWrapperModel.scaleX, toY: self.toWrapperModel.scaleY)
            self.wrapper.layer.transform = CATransform3DConcat(rotation, CATransform3DConcat(scale, translate))
            self.wrapper.layer.zPosition = self.toWrapperModel.zPosition
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
        self.contract!.onAnimationDonePlaying(isNextAnimation: false)
    }
}
