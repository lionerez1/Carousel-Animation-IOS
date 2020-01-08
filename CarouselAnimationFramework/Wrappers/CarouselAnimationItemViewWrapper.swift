//
//  CarouselAnimationItemViewWrapper.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationItemViewWrapper: UIView {
    var child: UIView?
    var valuesModel: CarouselAnimationWrapperValues?
    var transformer: CarouselAnimationWrapperTransformer?
    
    func initialize(child: UIView) {
        self.child = child
        self.addSubview(child)
    }
    
    func initializeViewTransforms(valuesModel: CarouselAnimationWrapperValues) {
        self.valuesModel = valuesModel
        self.transformer = CarouselAnimationWrapperTransformer(wrapper: self, wrapperValues: valuesModel)
        self.transformer!.setDefaultTransformers()
    }
    
    func setNewValuesModel(valuesModel: CarouselAnimationWrapperValues) {
        self.valuesModel = valuesModel
        self.transformer = CarouselAnimationWrapperTransformer(wrapper: self, wrapperValues: valuesModel)
    }
    
    func handleNextMovement(distance: CGFloat) {
        self.transformer!.handleNextMovement(distance: distance)
    }
    
    func handlePreviousMovement(distance: CGFloat) {
        self.transformer!.handlePreviousMovement(distance: distance)
    }
    
    func resetMovementTransforms() {
        self.transformer!.setDefaultTransformers()
    }
    
    func setNewChild(newChild: UIView) {
        for view in self.subviews {
            view.removeFromSuperview()
        }
        self.initialize(child: newChild)
    }
}
