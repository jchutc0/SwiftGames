//
//  ViewController.swift
//  SwiftBreakout
//
//  Created by jchutc0 on 10/1/23.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {
    override func viewDidLoad() {
        view.frame.size = CGSize(width: 1024, height: 768)
        let scene = GameScene(size: view.frame.size)
        let skView = view as! SKView
        skView.presentScene(scene)
    }
}

