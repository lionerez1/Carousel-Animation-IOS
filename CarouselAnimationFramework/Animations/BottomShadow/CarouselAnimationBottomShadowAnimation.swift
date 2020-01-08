//
//  CarouselAnimationBottomShadowAnimation.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationBottomShadowAnimation {
    private let bottomShadowWrapper: CarouselAnimationBottomShadowWrapper
    let scaleTransformer: CarouselAnimationScaleTransformer
    
    init(bottomShadowWrapper: CarouselAnimationBottomShadowWrapper) {
        self.bottomShadowWrapper = bottomShadowWrapper
        self.scaleTransformer = CarouselAnimationScaleTransformer()
    }
    
    func hide() {
        self.playHideAnimation()
    }
    
    func show() {
        self.playShowAnimation()
    }
    
    private func playHideAnimation() {
        UIView.animate(withDuration: 0.25, delay: 0, options: .curveEaseInOut, animations: {
            let scale = self.scaleTransformer.getScaleTransform(toX: 0.0000001, toY: 1)
            self.bottomShadowWrapper.layer.transform = scale
        }, completion: { (finished: Bool) in
            
        })
    }
    
    private func playShowAnimation() {
        UIView.animate(withDuration: 0.125, delay: 0.125, options: .curveEaseInOut, animations: {
            let scale = self.scaleTransformer.getScaleTransform(toX: 1, toY: 1)
            self.bottomShadowWrapper.layer.transform = scale
        }, completion: { (finished: Bool) in
            
        })
    }
}

