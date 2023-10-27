//
//  GameOver.swift
//  SwiftAdventure
//
//  Created by jchutc0 on 10/26/23.
//

import SpriteKit
import GameplayKit

class GameOver: SKScene {
    
    override func didMove(to view: SKView) {
        let label1 = SKLabelNode(text: "Game Over")
        label1.position = CGPoint(x: frame.midX, y: frame.maxY * 0.75)
        addChild(label1)
        let label3 = SKLabelNode(text: "Click or press any key to play again")
        label3.position = CGPoint(x: frame.midX, y: frame.maxY * 0.25)
        addChild(label3)
    }
    
    func playAgain() {
        // Load the SKScene from 'GameScene.sks'
        if let scene = SKScene(fileNamed: "GameScene") {
            // Set the scale mode to scale to fit the window
            scene.scaleMode = .aspectFill
            let transition = SKTransition.push(with: .down, duration: 1)
            
            // Present the scene
            self.view?.presentScene(scene, transition: transition)
        } // let scene
    } // playAgain
    
    // MARK: - Controls
    override func mouseDown(with event: NSEvent) {
        playAgain()
    }

    override func keyDown(with event: NSEvent) {
        playAgain()
    }
}
