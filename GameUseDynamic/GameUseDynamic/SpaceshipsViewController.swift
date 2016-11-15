//
//  SpaceshipsViewController.swift
//  GameUseDynamic
//
//  Created by CongTruong on 11/15/16.
//  Copyright © 2016 congtruong. All rights reserved.
//

import UIKit

class SpaceshipsViewController: UIViewController {
    
    var animator: UIDynamicAnimator!
    var gravityBehavior: UIGravityBehavior!
    var collisionBehavior: UICollisionBehavior!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.animator = UIDynamicAnimator(referenceView: self.view)
        
        self.gravityBehavior = UIGravityBehavior()
        self.animator.addBehavior(gravityBehavior)
        
        self.collisionBehavior = UICollisionBehavior()
        self.animator.addBehavior(collisionBehavior)
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(SpaceshipsViewController.createRandomSpace), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createRandomSpace() {
        let spaceShipImageView = UIImageView(frame: CGRect(x: Int(arc4random_uniform(UInt32(self.view.frame.size.width))), y: 0, width: 50, height: 50))
        spaceShipImageView.image = UIImage(named: "spaceShip")
        self.view.addSubview(spaceShipImageView)
        
        self.gravityBehavior.addItem(spaceShipImageView)
        self.collisionBehavior.addItem(spaceShipImageView)
    }
}
