//
//  UIView+Animation.swift
//  LoginDemo
//
//  Created by Matt Tian on 13/03/2018.
//  Copyright © 2018 TTSY. All rights reserved.
//

import UIKit

public struct Animation {
    public let duration: TimeInterval
    public let delay: TimeInterval
    public let closure: (UIView) -> Void
    
    public init(duration: TimeInterval, delay: TimeInterval, closure: @escaping (UIView) -> Void) {
        self.duration = duration
        self.delay = delay
        self.closure = closure
    }
}

extension Animation {

    static func fadeIn(duration: TimeInterval = 0.4, delay: TimeInterval = 0.4) -> Animation {
        return Animation(duration: duration, delay: delay, closure: { $0.alpha = 1 })
    }
    
    static func fadeOut(duration: TimeInterval = 0.4, delay: TimeInterval = 0.4) -> Animation {
        return Animation(duration: duration, delay: delay, closure: { $0.alpha = 0 })
    }
    
}

extension UIView {
    
    func animate(_ animations: Animation...) {
        animate(animations)
    }
    
    func animate(_ animations: [Animation]) {
        guard !animations.isEmpty else {
            return
        }
        
        var animations = animations
        let animation = animations.removeFirst()
        
        UIView.animate(withDuration: animation.duration, delay: animation.delay, options: UIViewAnimationOptions(), animations: {
            animation.closure(self)
        }, completion: { _ in
            self.animate(animations)
        })
    }
    
    func animate(inParallel animations: Animation...) {
        animate(inParallel: animations)
    }
    
    func animate(inParallel animations: [Animation]) {
        for animation in animations {
            UIView.animate(withDuration: animation.duration, delay: animation.delay, options: UIViewAnimationOptions(), animations: {
                animation.closure(self)
            }, completion: nil)
        }
    }
    
}

