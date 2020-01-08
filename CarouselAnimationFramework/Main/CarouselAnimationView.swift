//
//  CarouselAnimationView.swift
//  CarouselAnimaionFramework
//
//  Created by Lion Erez on 07/10/2019.
//  Copyright © 2019 Lion Erez. All rights reserved.
//

import UIKit

public class CarouselAnimationView: UIView {
    private var views: [CarouselAnimationItemViewWrapper]?
    private var model: CarouselAnimationViewModel?
    private var contract: CarouselAnimationViewContract?
    private var valuesModel: CarouselAnimationValues?
    private var panHandler: CarouselAnimationPanDelegationHandler?
    private var isAnimationPlaying: Bool = false
    private var bottomShadowWrapper: CarouselAnimationBottomShadowWrapper?
    private var animationHandler: CarouselAnimationAnimationsHandler?
    private var movementHandler: CarouselAnimationMovementHandler?
    private var nextAnimationsWaiting: Int = 0
    private var previousAnimationsWaiting: Int = 0
    private var pager: CarouselAnimationPagingHandler?
    private var panGestureRecognizers: UIPanGestureRecognizer?
    private var overrideGesture: UIPanGestureRecognizer?
    
    //Initialize without bottom shadow
    public func initialize(model: CarouselAnimationViewModel, contract: CarouselAnimationViewContract) {
        self.model = model
        self.contract = contract
        self._initialize()
    }
    
    //Initialize with bottom shadow
    public func initialize(model: CarouselAnimationViewModel, bottomShadow: UIImageView, contract: CarouselAnimationViewContract) {
        self.model = model
        self.bottomShadowWrapper = CarouselAnimationBottomShadowWrapper(frame: bottomShadow.frame)
        self.bottomShadowWrapper?.initialize(child: bottomShadow)
        self.contract = contract
        self._initialize()
    }
    
    public func getFirstViewIndex() -> Int {
        return self.pager!.getCurrentFocusedViewIndex()
    }
    
    public func setGestureToOverride(overrideGesture: UIPanGestureRecognizer) {
        self.overrideGesture = overrideGesture
    }
    
    private func _initialize() {
        self.clearSubViewsIfNeeded()
        self.clipsToBounds = true
        self.views = Array()
        self.pager = CarouselAnimationPagingHandler(viewModel: self.model!)
        self.animationHandler = CarouselAnimationAnimationsHandler(contract: self)
        self.initializeCarousel()
        if self.bottomShadowWrapper != nil {
            self.createBottomShadow()
        }
        self.movementHandler = CarouselAnimationMovementHandler(maximumDistance: self.valuesModel!.maximumMovementDistance, listener: self)
    }
    
    private func clearSubViewsIfNeeded() {
        for view in self.subviews {
            view.removeFromSuperview()
        }
    }
    
    private func initializeCarousel() {
        self.createViews()
        self.initializeValuesModel()
        self.initializeViewsZPositions()
        self.setWrapperTransforms()
        self.setTapDelegtaion()
    }
    
    private func createViews() {
        for i in 0..<self.model!.numberOfVisibleViews {
            let view: UIView = self.contract!.bindView(index: i, view: UIView())
            let wrapper = CarouselAnimationItemViewWrapper(frame: view.frame)
            wrapper.initialize(child: view)
            self.views!.append(wrapper)
            self.addSubview(wrapper)
            self.setWrapperConstraints(wrapper: wrapper)
            wrapper.center.x = self.center.x
            wrapper.frame.origin.y = self.calcualteOriginYForWrapper(wrapper: wrapper)
            self.reOrderViewsOnScreen()
        }
        self.bringSubviewToFront(self.getFirstWrapper())
    }
    
    private func calcualteOriginYForWrapper(wrapper: CarouselAnimationItemViewWrapper) -> CGFloat {
        let itemDistanceHeight: CGFloat = CGFloat(wrapper.frame.height) * 0.1
        let wantedHeight = itemDistanceHeight * CGFloat(self.model!.numberOfVisibleViews)
        return wantedHeight
    }
        
    private func setWrapperConstraints(wrapper: CarouselAnimationItemViewWrapper) {
        let horizontalConstraint = NSLayoutConstraint(item: wrapper, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
        let verticalConstraint = NSLayoutConstraint(item: wrapper, attribute: NSLayoutConstraint.Attribute.centerY, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self, attribute: NSLayoutConstraint.Attribute.centerY, multiplier: 1, constant: 0)
        self.addConstraints([horizontalConstraint, verticalConstraint])
    }
    
    private func reOrderViewsOnScreen() {
        if self.views!.count > 1 {
            for i in stride(from: self.views!.count - 1, to: 0, by: -1) {
                let view: CarouselAnimationItemViewWrapper = self.views![i]
                self.bringSubviewToFront(view)
            }
        }
    }
    
    private func initializeViewsZPositions() {
        for i in 0...self.views!.count - 1 {
            let wrapper: CarouselAnimationItemViewWrapper = self.views![i]
            let wrapperValues: CarouselAnimationWrapperValues = self.valuesModel!.getWrapperValuesByPosition(position: i)
            wrapper.layer.zPosition = wrapperValues.zPosition
        }
    }
    
    private func initializeValuesModel() {
        self.valuesModel = CarouselAnimationValues(firstWrapper: self.getFirstWrapper(), size: self.model!.numberOfVisibleViews)
    }
    
    private func setWrapperTransforms() {
        var index: Int = 0
        for wrapper in views! {
            wrapper.initializeViewTransforms(valuesModel: self.valuesModel!.getWrapperValuesByPosition(position: index))
            index += 1
        }
    }
    
    private func createBottomShadow() {
        self.addSubview(self.bottomShadowWrapper!)
        self.bottomShadowWrapper!.center = self.center
        self.bottomShadowWrapper!.center.y = self.getBottomShadowTopMargin()
    }
    
    private func getBottomShadowTopMargin() -> CGFloat {
        let margin: CGFloat = (self.valuesModel!.originalHeight / 2) + (self.valuesModel!.originalHeight * 0.1)
        return margin
    }
    
    private func getFirstWrapper() -> CarouselAnimationItemViewWrapper {
        return self.views![0]
    }
    
    private func getLastWrapper() -> CarouselAnimationItemViewWrapper {
        return self.views![self.views!.count - 1]
    }
    
    private func setTapDelegtaion() {
        self.panHandler = CarouselAnimationPanDelegationHandler()
        self.panGestureRecognizers = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_sender:)))
        self.panGestureRecognizers!.delegate = self
        self.addGestureRecognizer(self.panGestureRecognizers!)
    }
    
    private func resetWrappersTransforms(finalDistance: CGFloat) {
        if finalDistance < 0 {
            self.getFirstWrapper().resetMovementTransforms()
        } else {
            self.getLastWrapper().resetMovementTransforms()
        }
    }
    
    private func reOrderViewsAfterNext() {
        let lastItemIndex: Int = self.views!.count - 1
        let tempWrapper: CarouselAnimationItemViewWrapper = getFirstWrapper()
        for i in 0..<lastItemIndex {
            let nextViewIndex: Int = i + 1
            let nextView: CarouselAnimationItemViewWrapper = self.views![nextViewIndex]
            let nextViewValues: CarouselAnimationWrapperValues = self.valuesModel!.getWrapperValuesByPosition(position: i)
            nextView.setNewValuesModel(valuesModel: nextViewValues)
            self.views![i] = nextView
            if  nextViewIndex == lastItemIndex {
                self.views![nextViewIndex] = tempWrapper
                self.views![nextViewIndex].setNewValuesModel(valuesModel: self.valuesModel!.getLastWrapperValues())
            }
        }
    }
    
    private func reOrderViewsAfterPrevious() {
        let tempWrapper: CarouselAnimationItemViewWrapper = getLastWrapper()
        for i in stride(from: self.views!.count - 1, to: 0, by: -1) {
            let nextViewIndex: Int = i - 1
            let nextWrapper: CarouselAnimationItemViewWrapper = views![nextViewIndex]
            let nextWrapperValues: CarouselAnimationWrapperValues = valuesModel!.getWrapperValuesByPosition(position: i)
            views![i] = nextWrapper
            views![i].initializeViewTransforms(valuesModel: nextWrapperValues)
            if nextViewIndex == 0 {
                let firstWrapperValues: CarouselAnimationWrapperValues = valuesModel!.getFirstWrapperValues()
                views![nextViewIndex] = tempWrapper
                views![nextViewIndex].initializeViewTransforms(valuesModel: firstWrapperValues)
            }
        }
    }
    
    private func doesHaveWaitingAnimations() -> Bool {
        return self.nextAnimationsWaiting > 0 || self.previousAnimationsWaiting > 0
    }
    
    private func doesHaveNextWaitingAnimation() -> Bool {
        return self.nextAnimationsWaiting > 0
    }
    
    private func notifyNewFirstViewPosition() {
        self.contract!.onNewFocusedViewPosition(newPosition: self.pager!.getCurrentFocusedViewIndex())
    }
}

extension CarouselAnimationView : UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let gesture = self.overrideGesture {
            if gesture == self.panGestureRecognizers!, otherGestureRecognizer == gesture {
                return true
            }
        }
        return false
    }
    
    @IBAction func handlePan(_sender: UIPanGestureRecognizer) {
        switch _sender.state {
            case .changed:
                if self.panHandler!.isTracking() {
                    self.panHandler!.setLastDetectedPoint(point: _sender.translation(in: self))
                    self.handleMoveEvent()
                } else {
                }
            case .ended:
                self.handleMovementEnd()
                self.panHandler!.resetPoints()
            default:
                return
        }
    }
    
    private func handleMoveEvent() {
        if isAnimationPlaying {
            self.movementHandler!.handleMovementWhenAnimationPlaying(xDistance: self.panHandler!.getXDistance())
        } else {
            self.movementHandler!.handleMovementWhenAnimationNotPlaying(yDistance: self.panHandler!.getYDistance(), xDistance: self.panHandler!.getXDistance())
        }
    }
    
    private func handleMovementEnd() {
        self.panHandler!.enableTracking()
        if !self.isAnimationPlaying {
            self.resetWrappersTransforms(finalDistance: self.panHandler!.getYDistance())
        }
    }
}

extension CarouselAnimationView : CarouselAnimationMovementHandlerContract {

    func handleNextMovement(distance: CGFloat) {
        self.getFirstWrapper().handleNextMovement(distance: distance)
        if self.bottomShadowWrapper != nil {
            self.bottomShadowWrapper!.handleMovement(distance: distance)
        }
    }
    
    func handlePreviousMovement(distance: CGFloat) {
        self.getLastWrapper().handlePreviousMovement(distance: distance)
    }
    
    func playNextAnimation() {
        self.animationHandler!.playNextAnimation(wrapper: getFirstWrapper(), toValues: valuesModel!.getLastWrapperValues())
    }
    
    func playPreviousAnimation() {
           self.animationHandler!.playPreviousAnimation(wrapper: getLastWrapper(), toValues: valuesModel!.getFirstWrapperValues(), currentValues: valuesModel!.getLastWrapperValues())
    }
    
    func addNextAnimationToStack() {
        self.panHandler!.disableTracking()
        self.nextAnimationsWaiting += 1
    }
    
    func addPreviousAnimationToStack() {
        self.panHandler!.disableTracking()
        self.previousAnimationsWaiting += 1
    }
}

extension CarouselAnimationView : CarouselAnimationAnimationsHandlerContract {

    func onAnimationStartPlaying(isNext: Bool) {
        self.panHandler!.disableTracking()
        self.isAnimationPlaying = true
        if isNext && self.bottomShadowWrapper != nil {
        self.animationHandler!.hideBottomShadowAnimation(bottomShadowWrapper: self.bottomShadowWrapper!)
        }
    }
    
    func preaperNextSecondaryAnimation() {
        for i in stride(from: self.views!.count - 1, to: 0, by: -1) {
            let wrapper: CarouselAnimationItemViewWrapper = self.views![i]
            let nextItemIndex: Int = i - 1
            let nextValuesModel: CarouselAnimationWrapperValues = self.valuesModel!.getWrapperValuesByPosition(position: nextItemIndex)
            self.animationHandler!.playViewsNextSecondaryAnimation(wrapper: wrapper, toValues: nextValuesModel)
            self.bringSubviewToFront(wrapper)
        }
        if bottomShadowWrapper != nil {
            self.animationHandler!.showBottomShadowAnimation(bottomShadowWrapper: self.bottomShadowWrapper!)
        }
    }
    
    func preaperPreviousSecondaryAnimations() {
                let lastWrapper: CarouselAnimationItemViewWrapper = getLastWrapper()
                for i in stride(from: self.views!.count - 2, to: -1, by: -1) {
                    let wrapper: CarouselAnimationItemViewWrapper = self.views![i]
                    var nextItemIndex: Int = i + 1
                    if nextItemIndex >= views!.count {
                        nextItemIndex = nextItemIndex - views!.count
                    }
                    let nextValuesModel: CarouselAnimationWrapperValues = self.valuesModel!.getWrapperValuesByPosition(position: nextItemIndex)
                    self.animationHandler!.playViewsPreviousSecondaryAnimation(wrapper: wrapper, toValues: nextValuesModel)
                    self.bringSubviewToFront(wrapper)
                }
                self.bringSubviewToFront(lastWrapper)
    }
    
    func notifyViewInvisible(isNext: Bool) {
        if isNext {
            self.handleNextPaging()
        } else {
            self.handlePreviousPaging()
        }
    }
    
    func onNextAnimationDonePlaying() {
        if self.doesHaveWaitingAnimations() {
            if self.doesHaveNextWaitingAnimation() {
                self.nextAnimationsWaiting -= 1
                self.playNextAnimation()
            } else {
                self.previousAnimationsWaiting -= 1
                self.playPreviousAnimation()
            }
        } else {
            self.isAnimationPlaying = false
            self.notifyNewFirstViewPosition()
        }
    }
    
    func onPreviousAnimationDonePlaying() {
        self.reOrderViewsAfterPrevious()
        if self.doesHaveWaitingAnimations() {
            if self.doesHaveNextWaitingAnimation() {
                self.nextAnimationsWaiting -= 1
                self.playNextAnimation()
            } else {
                self.previousAnimationsWaiting -= 1
                self.playPreviousAnimation()
            }
        } else {
            self.isAnimationPlaying = false
            self.notifyNewFirstViewPosition()
        }
    }
    
    private func handleNextPaging() {
        self.pager!.next()
        self.reOrderViewsAfterNext()
        if self.pager!.isNeedPaging {
            let newView: UIView = self.contract!.bindView(index: self.pager!.getLastVisibleItemIndex(), view: getLastWrapper().child!)
            getLastWrapper().setNewChild(newChild: newView)
            
        }
    }
    
    private func handlePreviousPaging() {
        self.pager!.previous()
        if  self.pager!.isNeedPaging {
            let newView: UIView = self.contract!.bindView(index: self.pager!.getCurrentFocusedViewIndex(), view: getLastWrapper().child!)
            getLastWrapper().setNewChild(newChild: newView)
        }
    }
}
