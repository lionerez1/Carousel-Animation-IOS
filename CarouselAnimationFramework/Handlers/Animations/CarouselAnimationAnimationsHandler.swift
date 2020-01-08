//
//  CarouselAnimationAnimationsHandler.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationAnimationsHandler {
    let contract: CarouselAnimationAnimationsHandlerContract
    
    init(contract: CarouselAnimationAnimationsHandlerContract) {
        self.contract = contract
    }

    func playNextAnimation(wrapper: CarouselAnimationItemViewWrapper, toValues: CarouselAnimationWrapperValues) {
        self.contract.onAnimationStartPlaying(isNext: true)
        let nextAnimation = CarouselAnimationNextAnimation(wrapper: wrapper, toWrapperModel: toValues, contract: self)
        nextAnimation.play()
    }

    func playViewsNextSecondaryAnimation(wrapper: CarouselAnimationItemViewWrapper, toValues: CarouselAnimationWrapperValues) {
            let animation = CarouselAnimationSecondaryScaleAnimation(wrapper: wrapper, toScale: toValues)
            animation.play()
    }
    
    func playPreviousAnimation(wrapper: CarouselAnimationItemViewWrapper, toValues: CarouselAnimationWrapperValues, currentValues: CarouselAnimationWrapperValues) {
        self.contract.onAnimationStartPlaying(isNext: false)
        let previousAniamtion = CarouselAnimationPreviousAnimation(wrapper: wrapper, toWrapperModel: toValues, currentWrapperValues: currentValues, listener: self)
        previousAniamtion.play()
    }
    
    func playViewsPreviousSecondaryAnimation(wrapper: CarouselAnimationItemViewWrapper, toValues: CarouselAnimationWrapperValues) {
        let animation = CarouselAnimationSecondaryScaleAnimation(wrapper: wrapper, toScale: toValues)
        animation.play()
    }
    
    func hideBottomShadowAnimation(bottomShadowWrapper: CarouselAnimationBottomShadowWrapper) {
        let bottomShadowAnimation = CarouselAnimationBottomShadowAnimation(bottomShadowWrapper: bottomShadowWrapper)
        bottomShadowAnimation.hide()
    }
    
    func showBottomShadowAnimation(bottomShadowWrapper: CarouselAnimationBottomShadowWrapper) {
        let bottomShadowAnimation = CarouselAnimationBottomShadowAnimation(bottomShadowWrapper: bottomShadowWrapper)
        bottomShadowAnimation.show()
    }
}

extension CarouselAnimationAnimationsHandler : CarouselAnimationBaseAnimationContract {
    
    func startSecondaryAnimation(isNextAnimation: Bool) {
        if isNextAnimation {
            self.contract.preaperNextSecondaryAnimation()
        } else {
            self.contract.preaperPreviousSecondaryAnimations()
        }
    }
    
    func notifyViewInvisible(isNextAnimation: Bool) {
        self.contract.notifyViewInvisible(isNext: isNextAnimation)
    }
    
    func onAnimationDonePlaying(isNextAnimation: Bool) {
        if isNextAnimation {
            self.contract.onNextAnimationDonePlaying()
        } else {
            self.contract.onPreviousAnimationDonePlaying()
        }
    }
}

