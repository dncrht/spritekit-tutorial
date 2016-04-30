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

  let heroSpeed = 680.0

  var cameraPosition = CGPointMake(0, 0)

  let map = [[1,1,1,1,1,1], [1,0,1,0,1,0], [0,1,0,1,0,1], [1,1,1,1,1,1]]

  override func didMoveToView(view: SKView) {
    if !self.contentCreated {
      createSceneContents()
      self.contentCreated = true
    }
  }

  override func touchesEnded(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let camera = self.childNodeWithName("camera")!
    camera.physicsBody!.velocity = CGVectorMake(0, 0)
  }

  override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let firstTouch = touches.first
    let point = (firstTouch?.locationInNode(self))!

    print("moved \(point.x) \(point.y)")
    let camera = self.childNodeWithName("camera")!
    camera.physicsBody!.velocity = CGVectorMake(-point.x, -point.y)
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let firstTouch = touches.first
    let point = (firstTouch?.locationInNode(self))!

    print("started \(point.x) \(point.y)")
    let camera = self.childNodeWithName("camera")!
    camera.physicsBody!.velocity = CGVectorMake(-point.x, -point.y)
  }

  func createSceneContents() {
    let camera = SKNode()
    camera.physicsBody = SKPhysicsBody()
    camera.physicsBody!.affectedByGravity = false
    camera.name = "camera"
    camera.position = cameraPosition
    self.addChild(camera)

    let w = self.size.width / 2
    let h = self.size.height / 3

    for y in 0...3 {
      for x in 0...5 {
        if map[y][x] > 0 {
          let node = SKSpriteNode(color: SKColor.redColor(), size: CGSizeMake(w, h))
          node.position = CGPoint(x: CGFloat(x) * w, y: CGFloat(y) * h)
          camera.addChild(node)
        }
      }
    }

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
    let camera = self.childNodeWithName("camera")!
    camera.addChild(rock)
    return rock
  }

  func distance(point: CGPoint, node: SKNode) -> Double {
    return Double(sqrtf(
      pow(Float(point.x) - Float(node.position.x), 2) +
        pow(Float(point.y) - Float(node.position.y), 2)
      ))
  }

  func distance(origin: CGPoint, destination: CGPoint) -> Double {
    return Double(sqrtf(
      pow(Float(origin.x) - Float(destination.x), 2) +
        pow(Float(origin.y) - Float(destination.y), 2)
      ))
  }

  func touchPoint2OpenGl(touch: UITouch) -> CGPoint {
    var point = touch.locationInView(self.view)
    debugPrint(point)
    point.y = self.frame.size.height - point.y
    point.y = point.y - self.frame.size.height / 2
    point.x = point.x - self.frame.size.width / 2
    return point
  }

}
