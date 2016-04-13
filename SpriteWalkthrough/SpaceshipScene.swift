//
//  SpaceshipScene.swift
//  SpriteWalkthrough
//
//  Created by Dani on 12/04/16.
//  Copyright © 2016 Dani. All rights reserved.
//

import SpriteKit
import CoreGraphics

class SpaceshipScene: SKScene {

  var contentCreated = false

  override func didMoveToView(view: SKView) {
    if !self.contentCreated {
      createSceneContents()
      self.contentCreated = true
    }
  }

  func createSceneContents() {
    self.backgroundColor = SKColor.blackColor()
    let spaceship = newSpaceship()
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidX(self.frame) - 150)
    self.addChild(spaceship)

    let makeRocks = SKAction.sequence([
      SKAction.performSelector(addRock, onTarget: self),
      SKAction.waitForDuration(0.10, withRange: 0.15)
      ])
    runAction(SKAction.repeatActionForever(makeRocks))
  }

  func skRandf() -> CGFloat {
    return CGFloat(rand()) / CGFloat(RAND_MAX)
  }

  func skRand(low: CGFloat, high: CGFloat) -> CGFloat {
    return skRandf() * (high - low) + low;
  }

  func addRock() -> SKSpriteNode {
    let rock = SKSpriteNode(color: SKColor.brownColor(), size:CGSizeMake(8,8))
    rock.position = CGPointMake(skRand(0, high: self.size.width), self.size.height-50)
    rock.name = "rock"
    rock.physicsBody = SKPhysicsBody(rectangleOfSize: rock.size)
    rock.physicsBody!.usesPreciseCollisionDetection = true
    addChild(rock)
    return rock
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

  func newSpaceship() -> SKSpriteNode {
    let hull = SKSpriteNode(color: SKColor.grayColor(), size: CGSizeMake(64,32))

    let light1 = newLight()
    light1.position = CGPointMake(-28.0, 6.0)
    hull.addChild(light1)

    let light2 = newLight()
    light2.position = CGPointMake(28.0, 6.0)
    hull.addChild(light2)

    hull.physicsBody = SKPhysicsBody(rectangleOfSize: hull.size) // añade gravedad!!
    hull.physicsBody!.dynamic = false

    let hover = SKAction.sequence([
      SKAction.waitForDuration(1.0),
      SKAction.moveByX(100, y: 50.0, duration: 1.0),
      SKAction.waitForDuration(1.0),
      SKAction.moveByX(-100.0, y: -50, duration: 1.0)
      ])
    hull.runAction(SKAction.repeatActionForever(hover))

    return hull
  }
}
