//
//  GameScene.swift
//  SwiftAdventure
//
//  Created by jchutc0 on 10/23/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var keypress = Keypress.arrowKeys()
    var player = Player()
    var map: SKTileMapNode?
    var debug: SKLabelNode?
    static var levels = [
        "Level02",
        "Level03",
        "Level04®"
    ]
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        player.node = childNode(withName: "player")
        map = childNode(withName: "Walls") as? SKTileMapNode
    }
    
    override func keyDown(with event: NSEvent) { keypress.keyDown(event: event) }
    override func keyUp(with event: NSEvent) { keypress.keyUp(event: event) }
    
    override func update(_ currentTime: TimeInterval) {
        player.move(keypress: keypress, map: map)
    } // update
    
} // GameScene

extension GameScene: SKPhysicsContactDelegate {
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        player.contact(contact, collision: collision)

        if collision == Bitmask.player | Bitmask.goal {
            loadLevel()
        } // player/goal collision
    } // didBegin
    
    func loadLevel() {
        if let nextLevel = GameScene.levels.first, let scene = SKScene(fileNamed: nextLevel) {
            GameScene.levels.removeFirst()
            scene.scaleMode = .aspectFill
            let transition = SKTransition.push(with: .down, duration: 1)
            view?.presentScene(scene, transition: transition)
        } else {
            let scene = GameOver(size: self.size)
            scene.scaleMode = .aspectFit
            let transition = SKTransition.push(with: .up, duration: 1)
            view?.presentScene(scene, transition: transition)
        } // let scene
    } // loadLevel
} // SKPhysicsContactDelegate extension
