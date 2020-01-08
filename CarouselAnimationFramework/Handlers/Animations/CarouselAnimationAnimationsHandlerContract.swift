//
//  CarouselAnimationMainAnimationsHandlerContract.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

protocol CarouselAnimationAnimationsHandlerContract {
    func onAnimationStartPlaying(isNext: Bool)
    
    func preaperNextSecondaryAnimation()
    
    func preaperPreviousSecondaryAnimations()
    
    func notifyViewInvisible(isNext: Bool)
    
    func onNextAnimationDonePlaying()
    
    func onPreviousAnimationDonePlaying()
}
