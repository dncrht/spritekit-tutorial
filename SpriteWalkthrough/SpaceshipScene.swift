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

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    /*var point: CGPoint!
    for touch in touches {
      point = touch.locationInView(self.view)
    }*/
    var point = touches.first!.locationInView(self.view)
    debugPrint(point)
    point.y = self.frame.size.height - point.y

    let helloNode: SKNode = self.childNodeWithName("spaceship2")!
    let moveUp = SKAction.moveTo(point, duration: 0.75)
    helloNode.runAction(SKAction.sequence([moveUp]))
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
}
