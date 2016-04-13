//
//  ViewController.swift
//  SpriteWalkthrough
//
//  Created by Dani on 11/04/16.
//  Copyright © 2016 Dani. All rights reserved.
//

import UIKit
import SpriteKit
import CoreGraphics

class ViewController: UIViewController {

  override func loadView() {
    self.view = SKView(frame: UIScreen.mainScreen().bounds)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    let spriteView = view as! SKView // casting
    spriteView.showsDrawCount = true
    spriteView.showsNodeCount = true
    spriteView.showsFPS = true
  }

  override func viewWillAppear(animated: Bool) {
    let hello = HelloScene(size: CGSizeMake(768,1024)) // view.bounds.size
    let spriteView = view as! SKView // casting
    spriteView.presentScene(hello)
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

