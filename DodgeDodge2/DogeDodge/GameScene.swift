//
//  GameScene.swift
//  DodgeDodge2
//
//  Created by Mark Muchane on 4/23/16.
//  Copyright (c) 2016 Mark Muchane. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene {
    var dog = SKSpriteNode()
    var object = SKSpriteNode()
    var motionManager = CMMotionManager()
    var destX:CGFloat  = 0.0


 
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
 
        // 1
        dog = SKSpriteNode(imageNamed: "doge")
        dog.position = CGPointMake(frame.size.width/2, frame.size.height/2)
        
        self.addChild(dog)
        

        
        if motionManager.accelerometerAvailable == true {
            // 2
            motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.currentQueue()!, withHandler:{
                data, error in
                
                let currentX = self.dog.position.x
                
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
        let action = SKAction.moveToX(destX, duration: 1)
        self.dog.runAction(action)
    }
}