//
//  Rock.swift
//  SpriteWalkthrough
//
//  Created by Dani on 25/04/16.
//  Copyright © 2016 Dani. All rights reserved.
//

import SpriteKit
import CoreGraphics

class Rock: SKSpriteNode {

  static var index = 1

  init(_ playfieldSize: CGSize) {
    super.init(texture: nil, color: SKColor.brownColor(), size: CGSizeMake(48, 48))

    self.position = CGPointMake(skRand(0, high: playfieldSize.width), playfieldSize.height - 50)
    self.physicsBody = SKPhysicsBody(rectangleOfSize: playfieldSize)
    self.physicsBody!.usesPreciseCollisionDetection = true

    self.name = "rock"
    print("created rock\(Rock.index)")
    Rock.index += 1
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func skRandf() -> CGFloat {
    return CGFloat(rand()) / CGFloat(RAND_MAX)
  }

  func skRand(low: CGFloat, high: CGFloat) -> CGFloat {
    return skRandf() * (high - low) + low;
  }
}