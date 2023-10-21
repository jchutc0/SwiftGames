//
//  ViewController.swift
//  SwiftTennis
//
//  Created by jchutc0 on 9/30/23.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {
    override func viewDidLoad() {
        let scene = GameScene(size: view.frame.size)
        let skView = view as! SKView
        skView.presentScene(scene)
    }
}

