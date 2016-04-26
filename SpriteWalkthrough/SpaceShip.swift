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

  init(action: Bool = true) {
    super.init(texture: nil, color: SKColor.grayColor(), size: CGSizeMake(64, 32))
    self.name = "spaceship"

    let light1 = newLight()
    light1.position = CGPointMake(-28.0, 6.0)
    self.addChild(light1)

    let light2 = newLight()
    light2.position = CGPointMake(28.0, 6.0)
    self.addChild(light2)
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