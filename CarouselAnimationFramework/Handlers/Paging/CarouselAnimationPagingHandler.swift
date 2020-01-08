//
//  CarouselAnimationPagingHandler.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 05/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

class CarouselAnimationPagingHandler {
    private var totalSize: Int
    private let viewsSize: Int
    let isNeedPaging: Bool
    private var currentFocusedViewIndex: Int
    
    init(viewModel: CarouselAnimationViewModel) {
        self.totalSize = viewModel.totalSize
        self.viewsSize = viewModel.numberOfVisibleViews
        self.isNeedPaging = self.totalSize > viewsSize
        self.currentFocusedViewIndex = 0
        self.validateModel()
    }
    
    private func validateModel() {
        if self.viewsSize > self.totalSize {
            self.totalSize = self.viewsSize
        }
    }
    
    func getCurrentFocusedViewIndex() -> Int {
        return self.currentFocusedViewIndex
    }
    
    func getLastVisibleItemIndex() -> Int {
        let index = self.currentFocusedViewIndex + self.viewsSize - 1
        if index < self.totalSize {
            return index
        } else {
            return index - self.totalSize
        }
    }
    
    func next() {
        self.currentFocusedViewIndex += 1
        self.validateNext()
    }
    
    func previous() {
        self.currentFocusedViewIndex -= 1
        self.validatePrevious()
    }
    
    private func validateNext() {
        if self.currentFocusedViewIndex == self.totalSize {
            self.currentFocusedViewIndex = 0
        }
    }
    
    private func validatePrevious() {
        if self.currentFocusedViewIndex < 0 {
            self.currentFocusedViewIndex = self.totalSize - 1
        }
    }
}
