//
//  CarouselAnimationValues.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

struct CarouselAnimationValues {
    let originalWidth: CGFloat
    let originalHeight: CGFloat
    var wrapperValues: Array<CarouselAnimationWrapperValues>
    let maximumMovementDistance: CGFloat = 50
    let zPositionUnitValue: CGFloat = CGFloat(20)

    
    init(firstWrapper: CarouselAnimationItemViewWrapper, size: Int) {
        self.originalWidth = firstWrapper.frame.width
        self.originalHeight = firstWrapper.frame.height
        self.wrapperValues = Array()
        self.initializeWrappersValues(size: size)
    }
    
    func getFirstWrapperValues() -> CarouselAnimationWrapperValues {
        return self.wrapperValues[0]
    }
    
    func getLastWrapperValues() -> CarouselAnimationWrapperValues {
        return self.wrapperValues[self.wrapperValues.count - 1]
    }
    
    func getWrapperValuesByPosition(position: Int) -> CarouselAnimationWrapperValues {
        return self.wrapperValues[position]
    }
    
    private mutating func initializeWrappersValues(size: Int) {
        let firstZPosition: CGFloat = CGFloat(size - 1) * zPositionUnitValue
        self.addFirstWrapperValue(zPosition: firstZPosition)
        var lastCalculatedWidth: CGFloat = self.originalWidth
        var lastCalculatedHeight: CGFloat = self.originalHeight
        for i in 1...size - 1 {
            let newWidth: CGFloat = lastCalculatedWidth.nextScale()
            let newHeight: CGFloat = lastCalculatedHeight.nextScale()
            let scaleX: CGFloat = newWidth / self.originalWidth
            let scaleY: CGFloat = newHeight / self.originalHeight
            let yTranslation: CGFloat = newHeight - originalHeight - 5
            let reversedCounterValue: Int = size - 1 - i
            let zPosition: CGFloat = CGFloat(reversedCounterValue) * self.zPositionUnitValue
            let wrapperValues = CarouselAnimationWrapperValues(scaleX: scaleX, scaleY: scaleY, translationY: yTranslation, zPosition: zPosition)
            self.wrapperValues.append(wrapperValues)
            lastCalculatedHeight = newHeight
            lastCalculatedWidth  = newWidth
        }
    }
    
    private mutating func addFirstWrapperValue(zPosition: CGFloat) {
        let wrapperValues = CarouselAnimationWrapperValues(scaleX: 1, scaleY: 1, translationY: 0, zPosition: zPosition)
        self.wrapperValues.append(wrapperValues)
    }
}
