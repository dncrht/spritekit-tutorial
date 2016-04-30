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

  let x = 0
  let y = 0

  let map = [[1,1,1,1,1,1], [1,0,1,0,1,0], [0,1,0,1,0,1], [1,1,1,1,1,1]]

  func respondToSwipeGesture(gesture: UIGestureRecognizer) {

    if let swipeGesture = gesture as? UISwipeGestureRecognizer {

      switch swipeGesture.direction {
      case UISwipeGestureRecognizerDirection.Right:
        print("Swiped right")
      case UISwipeGestureRecognizerDirection.Down:
        print("Swiped down")
      case UISwipeGestureRecognizerDirection.Left:
        print("Swiped left")
      case UISwipeGestureRecognizerDirection.Up:
        print("Swiped up")
      default:
        break
      }
    }
  }

  override func didMoveToView(view: SKView) {
    if !self.contentCreated {
      createSceneContents()
      self.contentCreated = true
    }

    let directions: [UISwipeGestureRecognizerDirection] = [.Right, .Left, .Up, .Down]
    for direction in directions {
      let swipeGesture = UISwipeGestureRecognizer(target: self, action: #selector(SpaceshipScene.respondToSwipeGesture(_:)))
      swipeGesture.direction = direction
      view.addGestureRecognizer(swipeGesture)
    }
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let firstTouch = touches.first
    let point = (firstTouch?.locationInNode(self))!

    let camera = self.childNodeWithName("camera")!
    camera.removeAllActions()
    camera.runAction(SKAction.moveTo(point, duration: distance(point, node: camera) / heroSpeed))
  }

  func createSceneContents() {
    let camera = SKNode()
    camera.name = "camera"
    self.addChild(camera)

    let w = self.size.width / 2
    let h = self.size.height / 3

    for y in 0...3 {
      for x in 0...1 {
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

  func touchPoint2OpenGl(touch: UITouch) -> CGPoint {
    var point = touch.locationInView(self.view)
    debugPrint(point)
    point.y = self.frame.size.height - point.y
    point.y = point.y - self.frame.size.height / 2
    point.x = point.x - self.frame.size.width / 2
    return point
  }

}
