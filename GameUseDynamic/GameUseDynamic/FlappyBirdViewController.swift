//
//  FlappyBirdViewController.swift
//  GameUseDynamic
//
//  Created by CongTruong on 11/15/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

class FlappyBirdViewController: UIViewController {

    @IBOutlet weak var birdImageView: UIImageView!
    
    var animator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        animator = UIDynamicAnimator(referenceView: self.view)
        
        // set gravity behavior for bird image view
        gravityBehavior = UIGravityBehavior(items: [self.birdImageView])
        
        // add behavior for animator
        animator.addBehavior(gravityBehavior)
    }

    @IBAction func tapGestureAction(_ sender: UITapGestureRecognizer) {
        let pushBehavior = UIPushBehavior(items: [self.birdImageView], mode: .instantaneous)
        pushBehavior.pushDirection = CGVector(dx: 0, dy: -1)
        pushBehavior.magnitude = 5
        pushBehavior.active = true
        
        animator.addBehavior(pushBehavior)
        
        let a = UIDynamicItemBehavior(items: [self.birdImageView])
    }
}
