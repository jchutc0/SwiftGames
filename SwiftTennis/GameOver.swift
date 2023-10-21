//
//  GameOver.swift
//  SwiftTennis
//
//  Created by jchutc0 on 10/1/23.
//

import SpriteKit
import GameplayKit

class GameOver: SKScene {
    
    var winString = String("")
    let label = SKLabelNode()

    // MARK: - Draw Scene
    override func didMove(to view: SKView) {
        label.position = CGPoint(x: self.frame.width / 2, y: self.frame.height * 0.85)
        label.text = winString
        label.fontSize = 24
        label.fontName = "Helvetica-Bold"
        self.addChild(label)
    } // didMove
    
    func closeScene() {
        let scene = GameScene(size: self.size)
        scene.scaleMode = .aspectFit
        let transition = SKTransition.push(with: .down, duration: 1)
        self.view?.presentScene(scene, transition: transition)
    } // closeScene
    

    
    // MARK: - Controls
    override func keyDown(with event: NSEvent) {
        closeScene()
    }
    
    override func mouseDown(with event: NSEvent) {
        closeScene()
    }
    
    override func update(_ currentTime: TimeInterval) { } // update
    
}
