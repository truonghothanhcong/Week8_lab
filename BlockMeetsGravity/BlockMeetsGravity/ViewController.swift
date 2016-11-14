//
//  ViewController.swift
//  BlockMeetsGravity
//
//  Created by CongTruong on 11/14/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollisionBehaviorDelegate {

    @IBOutlet weak var square1: UIImageView!
    
    var animator: UIDynamicAnimator?
    var collisionBehavior: UICollisionBehavior!
    var gravityBehavior: UIGravityBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // set image to change tinColor
        square1.image = square1.image?.withRenderingMode(UIImageRenderingMode.alwaysTemplate)
        square1.tintColor = UIColor.darkGray
        
        let animator = UIDynamicAnimator(referenceView: self.view)
        
        // create behavior for gravity
        let gravityBehavior = UIGravityBehavior(items: [self.square1])
        animator.addBehavior(gravityBehavior)
        
        // create behavior for collision
        let collisionBehavior = UICollisionBehavior(items: [self.square1])
        collisionBehavior.translatesReferenceBoundsIntoBoundary = true
        collisionBehavior.collisionDelegate = self
        animator.addBehavior(collisionBehavior)
        
        self.collisionBehavior = collisionBehavior
        self.gravityBehavior = gravityBehavior
        self.animator = animator
    }
    
    @IBAction func reset(_ sender: UITapGestureRecognizer) {
        self.animator?.removeAllBehaviors()
        square1.center = CGPoint(x: sender.location(in: self.view).x, y: sender.location(in: self.view).y)
        
        self.animator?.addBehavior(gravityBehavior)
        self.animator?.addBehavior(collisionBehavior)
    }
    
    
    // MARK: delegate for change tinColor when collision
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?, at p: CGPoint) {
        square1.tintColor = UIColor.lightGray
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, endedContactFor item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying?) {
        square1.tintColor = UIColor.darkGray
    }
}

