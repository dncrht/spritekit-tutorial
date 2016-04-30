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
  let myWorld = SKNode()
  let cam = SKNode()//SKCameraNode()

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

  /*override func didFinishUpdate() {
    let cameraPositionInScene = cam.scene!.convertPoint(cam.position, fromNode: cam.parent!)
    //cam.parent!.position = CGPointMake(cam.parent!.position.x - cameraPositionInScene.x, cam.parent!.position.y - cameraPositionInScene.y)
  }*/

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
    /*
    let hero: SKNode = self.childNodeWithName("spaceship")!

    let point = touchPoint2OpenGl(touches.first!)
    print("POS \(point.x), \(point.y)")
    hero.removeAllActions()
    hero.runAction(SKAction.moveTo(point, duration: distance(point, node: hero) / heroSpeed))
 */
    let firstTouch = touches.first
    let location = (firstTouch?.locationInNode(self))!
    cam.position = location
  }

  func createSceneContents() {
    addChild(myWorld)

    //cam.scaleAsPoint = CGPoint(x: 0.25, y: 0.25) //the scale sets the zoom level of the camera on the given position

    //self.camera = cam //set the scene's camera to reference cam
    self.addChild(cam) //make the cam a childElement of the scene itself.

    //position the camera on the gamescene.
    cam.position = CGPoint(x: 0, y: 0) //x: CGRectGetMidX(self.frame), y: CGRectGetMidY(self.frame))

    let w = self.size.width / 2
    let h = self.size.height / 3

    for y in 0...3 {
      for x in 0...1 {
        if map[y][x] > 0 {
          let node = SKSpriteNode(color: SKColor.redColor(), size: CGSizeMake(w, h))
          node.position = CGPoint(x: CGFloat(x) * w, y: CGFloat(y) * h)
          cam.addChild(node)
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
    cam.addChild(rock)
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
