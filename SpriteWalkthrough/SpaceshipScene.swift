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

  let heroSpeed = 480.0

  override func didMoveToView(view: SKView) {
    if !self.contentCreated {
      createSceneContents()
      self.contentCreated = true
    }
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let hero: SKNode = self.childNodeWithName("spaceship2")!

    let point = touchPoint2OpenGl(touches.first!)

    hero.removeAllActions()
    hero.runAction(SKAction.moveTo(point, duration: distance(point, node: hero) / heroSpeed))
  }

  func createSceneContents() {
    self.backgroundColor = SKColor.blackColor()
    let spaceship = SpaceShip()
    spaceship.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidX(self.frame) - 150)
    self.addChild(spaceship)

    let spaceship2 = SpaceShip(action: false)
    spaceship2.position = CGPointMake(0, 0)
    self.addChild(spaceship2)

    /*let makeRocks = SKAction.sequence([
      SKAction.performSelector(addRock, onTarget: self),
      SKAction.waitForDuration(0.10, withRange: 0.15)
      ])
    runAction(SKAction.repeatActionForever(makeRocks))*/
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

  func distance(point: CGPoint, node: SKNode) -> Double {
    return Double(sqrtf(
      pow(Float(point.x) - Float(node.position.x), 2) +
        pow(Float(point.y) - Float(node.position.y), 2)
      ))
  }

  func touchPoint2OpenGl(touch: UITouch) -> CGPoint {
    var point = touch.locationInView(self.view)
    debugPrint(point)
    point.y = self.frame.size.height - point.y
    return point
  }

}
