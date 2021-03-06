//
//  GameScene.swift
//  DodgeDodge2
//
//  Created by Mark Muchane on 4/23/16.
//  Copyright (c) 2016 Mark Muchane. All rights reserved.
//

import SpriteKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate  {
    var dog = SKSpriteNode()
    var object = SKSpriteNode()
    var motionManager = CMMotionManager()
    var destX:CGFloat  = 0.0


 
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
            self.physicsWorld.contactDelegate = self
        
        NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: #selector(GameScene.spawnEnemy), userInfo: nil, repeats: true)

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
    
    
    func randomBetweenNumbers(firstNum: CGFloat, secondNum: CGFloat) -> CGFloat{
        return CGFloat(arc4random()) / CGFloat(UINT32_MAX) * abs(firstNum - secondNum) + min(firstNum, secondNum)
    }
    
    func spawnEnemy(){
        //supposed to pick random point within the screen width
        let xPos = randomBetweenNumbers(0, secondNum: frame.width )
        
        let enemy = SKSpriteNode(imageNamed: "doge") //create a new enemy each time
        enemy.position = CGPointMake(CGFloat(xPos), 720)
        enemy.physicsBody = SKPhysicsBody(circleOfRadius: 7)
        enemy.physicsBody?.affectedByGravity = true
        enemy.physicsBody?.categoryBitMask = 0
        enemy.physicsBody?.contactTestBitMask = 1
        addChild(enemy)
    }
    // 4
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        let action = SKAction.moveToX(destX, duration: 0.2)
        self.dog.runAction(action)
    }
}