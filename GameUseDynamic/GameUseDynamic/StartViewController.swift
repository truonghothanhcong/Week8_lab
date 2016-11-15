//
//  StartViewController.swift
//  GameUseDynamic
//
//  Created by CongTruong on 11/15/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

class StartViewController: UIViewController, UICollisionBehaviorDelegate {
    
    var animator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var collisionBehavior: UICollisionBehavior!
    
    var animatorForMissile: UIDynamicAnimator!
    var pushBehavior: UIPushBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.animator = UIDynamicAnimator(referenceView: self.view)
        
        self.gravityBehavior = UIGravityBehavior()
        self.gravityBehavior.magnitude = 0.1
        self.animator.addBehavior(gravityBehavior)
        
        self.collisionBehavior = UICollisionBehavior()
        self.collisionBehavior.collisionDelegate = self
        self.animator.addBehavior(collisionBehavior)
        
        self.animatorForMissile = UIDynamicAnimator(referenceView: self.view)
        
        self.pushBehavior = UIPushBehavior(items: [], mode: .instantaneous)
        self.pushBehavior.pushDirection = CGVector(dx: 0, dy: -5)
        self.pushBehavior.magnitude = 0.1
        self.animatorForMissile.addBehavior(pushBehavior)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SpaceshipsViewController.createRandomSpace), userInfo: nil, repeats: true)
    }
    
    func createRandomSpace() {
        let spaceShipImageView = UIImageView(frame: CGRect(x: Int(arc4random_uniform(UInt32(self.view.frame.size.width))), y: -80, width: 80, height: 80))
        spaceShipImageView.image = UIImage(named: "spaceShip")
        self.view.addSubview(spaceShipImageView)
        
        self.gravityBehavior.addItem(spaceShipImageView)
        self.collisionBehavior.addItem(spaceShipImageView)
    }
    
    @IBAction func fireMissile(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: self.view)
        
        let missile = UIView(frame: CGRect(x: location.x, y: location.y, width: 10, height: 10))
        missile.backgroundColor = UIColor.black
        self.view.addSubview(missile)
        
        pushBehavior.addItem(missile)
        self.pushBehavior.active = true
        
        collisionBehavior.addItem(missile)
    }
    
    func collisionBehavior(_ behavior: UICollisionBehavior, beganContactFor item1: UIDynamicItem, with item2: UIDynamicItem, at p: CGPoint) {
        let view1 = item1 as! UIView
        let view2 = item2 as! UIView
        
        gravityBehavior.removeItem(view1)
        gravityBehavior.removeItem(view2)
        collisionBehavior.removeItem(view1)
        collisionBehavior.removeItem(view2)
        pushBehavior.removeItem(view1)
        pushBehavior.removeItem(view2)
        
        view1.removeFromSuperview()
        view2.removeFromSuperview()
    }
}
