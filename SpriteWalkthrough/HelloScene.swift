//
//  HelloScene.swift
//  SpriteWalkthrough
//
//  Created by Dani on 11/04/16.
//  Copyright © 2016 Dani. All rights reserved.
//

import SpriteKit
import CoreGraphics

class HelloScene: SKScene {

  var contentCreated = false

  override func didMoveToView(view: SKView) {
    if !self.contentCreated {
      createSceneContents()
      self.contentCreated = true
    }
  }

  func createSceneContents() {
    self.backgroundColor = SKColor.blueColor()
    //self.scaleMode = SKSceneScaleModeAspectFit
    self.addChild(self.newHelloNode())
  }

  func newHelloNode() -> SKNode {
    let helloNode = SKLabelNode(fontNamed: "Chalkduster")
    helloNode.text = "Hello, World!"
    helloNode.name = "helloNode"
    helloNode.fontSize = 42
    helloNode.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
    return helloNode
  }

  override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    let helloNode: SKNode? = self.childNodeWithName("helloNode")
    if helloNode != nil {
      helloNode!.name = nil
      let moveUp = SKAction.moveByX(0, y: 100.0, duration: 0.5)
      let zoom = SKAction.scaleTo(2.0, duration: 0.25)
      let pause = SKAction.waitForDuration(0.5)
      let fadeAway = SKAction.fadeOutWithDuration(0.25)
      let remove = SKAction.removeFromParent()
      let moveSequence = SKAction.sequence([moveUp, zoom, pause, fadeAway, remove])
      helloNode!.runAction(moveSequence, completion: {
        let spaceshipScene = SpaceshipScene(size: self.size)
        let doors = SKTransition.doorsOpenVerticalWithDuration(0.5)
        self.view!.presentScene(spaceshipScene, transition:doors);
      })
    }
  }
}
