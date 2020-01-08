//
//  CarouselAnimationContract.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

public protocol CarouselAnimationViewContract {
    func bindView(index: Int, view: UIView) -> UIView
    
    func onNewFocusedViewPosition(newPosition: Int)
}

