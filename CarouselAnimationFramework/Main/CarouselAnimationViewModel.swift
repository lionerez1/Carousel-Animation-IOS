//
//  CarouselAnimationViewModel.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

public struct CarouselAnimationViewModel {
    var numberOfVisibleViews: Int
    let totalSize: Int
    
    public init(numberOfVisibleViews: Int, totalSize: Int) {
        self.numberOfVisibleViews = numberOfVisibleViews
        self.totalSize = totalSize
        self.validateModel()
    }
    
    private mutating func validateModel() {
        if self.numberOfVisibleViews > totalSize {
            self.numberOfVisibleViews = totalSize
        }
    }
}
