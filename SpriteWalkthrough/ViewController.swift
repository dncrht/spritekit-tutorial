//
//  ViewController.swift
//  SpriteWalkthrough
//
//  Created by Dani on 11/04/16.
//  Copyright © 2016 Dani. All rights reserved.
//

import UIKit
import SpriteKit

class ViewController: UIViewController {

  override func loadView() {
    self.view = SKView(frame: UIScreen.mainScreen().bounds)
  }

  override func viewDidLoad() {
    srand48(Int(NSDate().timeIntervalSinceReferenceDate))

    super.viewDidLoad()
    let skView = view as! SKView
    skView.showsDrawCount = true
    skView.showsNodeCount = true
    skView.showsFPS = true

    let scene = SpaceshipScene(size: view.bounds.size)//HelloScene(size: view.bounds.size)
    scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
    skView.presentScene(scene)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

}

