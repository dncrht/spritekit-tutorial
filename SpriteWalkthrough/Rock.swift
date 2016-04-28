//
//  Rock.swift
//  SpriteWalkthrough
//
//  Created by Dani on 25/04/16.
//  Copyright © 2016 Dani. All rights reserved.
//

import SpriteKit
import CoreGraphics
import Darwin

class Rock: SKSpriteNode {

  init(_ playfieldSize: CGSize) {
    super.init(texture: nil, color: SKColor.brownColor(), size: CGSizeMake(48, 48))

    let phi = skRand(high: 2 * CGFloat(M_PI))
    let radius = CGFloat(playfieldSize.height + 100)

    let from = self.point(radius, phi: phi)
    let to = CGPoint(x: -from.x, y: -from.y)
    self.position = from

    self.runAction(SKAction.moveTo(to, duration: 4), completion: {self.removeFromParent()})

    self.name = "rock"
  }

  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  func point(radius: CGFloat, phi: CGFloat, opposite: Bool = false) -> CGPoint {
    let factor = opposite ? CGFloat(-1) : CGFloat(1)
    return CGPoint(x: (cos(phi) * factor * radius), y: (sin(phi) * factor * radius))
  }

  func skRand(low: CGFloat = 0, high: CGFloat = 1) -> CGFloat {
    return CGFloat(drand48()) * (high - low) + low;
  }
}