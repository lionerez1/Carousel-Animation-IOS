//
//  CarouselAnimationBaseAnimationContract.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 04/11/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

protocol CarouselAnimationBaseAnimationContract {
    func startSecondaryAnimation(isNextAnimation: Bool)
    
    //Used to notift the carousel view when to ask new view in case of paging needed
    func notifyViewInvisible(isNextAnimation: Bool)
    
    func onAnimationDonePlaying(isNextAnimation: Bool)
}

