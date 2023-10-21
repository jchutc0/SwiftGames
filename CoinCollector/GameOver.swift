//
//  GameOver.swift
//  CoinCollector
//
//  Created by jchutc0 on 9/30/23.
//

import SpriteKit
import GameplayKit

class GameOver: SKScene {
    
    public var win = true

    override func didMove(to view: SKView) {
        let label = self.childNode(withName: "//label") as? SKLabelNode
        if !win { label?.text = "Better Luck Next Time" }

    } // didMove
    
    override func mouseDown(with event: NSEvent) { 
        let scene = GameScene(fileNamed: "GameScene")
        scene!.scaleMode = .aspectFit
        self.view?.presentScene(scene)
    }
    
} // GameOver
