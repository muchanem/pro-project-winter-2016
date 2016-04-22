//
//  GameScene.swift
//  DogeDodge
//
//  Created by Mark Muchane on 4/16/16.
//  Copyright (c) 2016 Mark Muchane. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    var doge = SKSpriteNode()
    var motionManager = CMMotionManager()
    var destX:CGFloat  = 0.0
    var block = SKSpriteNode()
    var animator:UIDynamicAnimator? = nil;
    let gravity = UIGravityBehavior()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // 1
        block = SKSpriteNode(imageNamed: "doge")
        block.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        block.position = CGPoint(x: doge.position.x , y: 200)
        doge = SKSpriteNode(imageNamed: "doge")
        doge.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        self.addChild(doge)
        
        
        if motionManager.accelerometerAvailable == true {
            // 2 
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:{
                data, error in
                

                let currentX = self.doge.position.x
                
                // 3
                if data!.acceleration.x < 0 {
                    self.destX = currentX + CGFloat(data!.acceleration.x * 100)
                }
                    
                else if data!.acceleration.x > 0 {
                    self.destX = currentX + CGFloat(data!.acceleration.x * 100)
                }
                
            })
            
        }
        
       
    
    }
    
    // 4
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let action = SKAction.moveToX(destX, duration: 0.1)
        self.doge.runAction(action)
        block.position = CGPoint(x: doge.position.x , y: 200)
        
        self.addChild(block)
        
    }
    // 5
 
    
}