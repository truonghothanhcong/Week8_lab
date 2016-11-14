//
//  FallingSnowViewController.swift
//  BlockMeetsGravity
//
//  Created by CongTruong on 11/14/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

class FallingSnowViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var animator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var collisionBehavior: UICollisionBehavior!
    
    override func viewWillAppear(_ animated: Bool) {
        let animator = UIDynamicAnimator(referenceView: self.view)
        
        let gravityBehavior = UIGravityBehavior()
        animator.addBehavior(gravityBehavior)
        self.gravityBehavior = gravityBehavior
        
        let collisionBehavior = UICollisionBehavior()
        // add boundary below
        collisionBehavior.addBoundary(withIdentifier: "below" as NSCopying, from: CGPoint(x: 0, y: self.view.frame.size.height - 50), to: CGPoint(x: self.view.frame.size.width, y: self.view.frame.size.height - 50))
        // add boundary shelter
        collisionBehavior.addBoundary(withIdentifier: "shelter" as NSCopying, from: CGPoint(x: 0, y: 300), to: CGPoint(x: 200, y: 350))
        collisionBehavior.collisionDelegate = self
        animator.addBehavior(collisionBehavior)
        self.collisionBehavior = collisionBehavior
        
        self.animator = animator
        
        Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(FallingSnowViewController.createRandomSnow), userInfo: nil, repeats: true)
    }

    func createRandomSnow() {
        let newSnow = UIView(frame: CGRect(x: Int(arc4random_uniform(UInt32(self.view.frame.size.width))), y: 0, width: 5, height: 5))
        newSnow.backgroundColor = UIColor.white
        self.view.addSubview(newSnow)
        
        
        gravityBehavior.addItem(newSnow)
        collisionBehavior.addItem(newSnow)
    }
    
    func meltSnow(snowView: UIView) {
        gravityBehavior.removeItem(snowView)
        collisionBehavior.removeItem(snowView)
        
        snowView.removeFromSuperview()
    }
    
    func run(after wait: TimeInterval, closure: @escaping () -> Void) {
        let queue = DispatchQueue.main
        queue.asyncAfter(deadline: DispatchTime.now() + wait, execute: closure)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        
        // You have to convert the identifier to a string
        let boundary = identifier as? String
        
        // The view that collided with the boundary has to be converted to a view
        let view = item as? UIView
        
        if boundary == "shelter" {
            // Detected collision with a boundary called "shelf"
        } else if boundary == "below" {
            run(after: 0.5, closure: {
                self.meltSnow(snowView: view!)
            })
        }
    }
}
