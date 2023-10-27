//
//  ViewController.swift
//  SwiftAdventure
//
//  Created by jchutc0 on 10/21/23.
//

import Cocoa
import SpriteKit
import GameplayKit

class ViewController: NSViewController {
    override func viewDidLoad() {
        view.frame.size = CGSize(width: 800, height: 600)
        let scene = GameScene(size: view.frame.size)
        let skView = view as! SKView
//        skView.showsFPS = true
//        skView.showsNodeCount = true
//        skView.showsPhysics = true
        skView.presentScene(scene)
    } // viewDidLoad
} // ViewController
