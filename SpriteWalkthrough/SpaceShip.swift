//
//  SpaceShip.swift
//  SpriteWalkthrough
//
//  Created by Dani on 23/04/16.
//  Copyright © 2016 Dani. All rights reserved.
//

import SpriteKit
import CoreGraphics

class SpaceShip: SKSpriteNode {

  static var index = 1

  init(action: Bool = true) {
    super.init(texture: nil, color: SKColor.grayColor(), size: CGSizeMake(64,32))
    /*super.init()
    self.color = SKColor.grayColor()
    self.size = CGSizeMake(32, 64)*/

    self.name = "spaceship\(SpaceShip.index)"
    SpaceShip.index += 1
    print("created \(self.name)")

    let light1 = newLight()
    light1.position = CGPointMake(-28.0, 6.0)
    self.addChild(light1)

    let light2 = newLight()
    light2.position = CGPointMake(28.0, 6.0)
    self.addChild(light2)

    self.physicsBody = SKPhysicsBody(rectangleOfSize: self.size) // añade gravedad!!
    self.physicsBody!.dynamic = false

    if action {
      let hover = SKAction.sequence([
        SKAction.waitForDuration(1.0),
        SKAction.moveByX(100, y: 50.0, duration: 1.0),
        SKAction.waitForDuration(1.0),
        SKAction.moveByX(-100.0, y: -50, duration: 1.0)
        ])
      self.runAction(SKAction.repeatActionForever(hover))
    }
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func newLight() -> SKSpriteNode {
    let light = SKSpriteNode(color: SKColor.yellowColor(), size:CGSizeMake(8,8))

    let blink = SKAction.sequence([
      SKAction.fadeOutWithDuration(0.25),
      SKAction.fadeInWithDuration(0.25)
      ])
    let blinkForever = SKAction.repeatActionForever(blink)
    light.runAction(blinkForever)

    return light;
  }
}