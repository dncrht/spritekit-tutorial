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
    let hero: SKNode = self.childNodeWithName("spaceship1")!

    let point = touchPoint2OpenGl(touches.first!)

    hero.removeAllActions()
    hero.runAction(SKAction.moveTo(point, duration: distance(point, node: hero) / heroSpeed))
  }

  func createSceneContents() {
    self.backgroundColor = SKColor.blackColor()
    let spaceship = SpaceShip()
    spaceship.position = CGPointMake(0, 0)
    self.addChild(spaceship)

    let makeRocks = SKAction.sequence([
      SKAction.performSelector(#selector(SpaceshipScene.addRock), onTarget: self),
      SKAction.waitForDuration(2, withRange: 2)
      ])
    runAction(SKAction.repeatActionForever(makeRocks))
  }

  func addRock() -> SKSpriteNode {
    let rock = Rock(self.size)
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

  override func didSimulatePhysics() {
    self.enumerateChildNodesWithName("rock", usingBlock: { (node: SKNode, stop: UnsafeMutablePointer<ObjCBool>) -> Void in
      if node.position.y < 0 {
        node.removeFromParent()
      }
    })
  }

}
