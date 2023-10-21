//
//  GameScene.swift
//  SwiftRacer
//
//  Created by jchutc0 on 10/2/23.
//

import SpriteKit
import GameplayKit

class Contact {
    static let car      = UInt32(0x1)
    static let wall     = UInt32(0x10)
    static let finish   = UInt32(0x100)
    static let flag     = UInt32(0x1000)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var player: Car?
    var keyPressed: Set<UInt16> = []
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        let level = [
            4, 4, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 4, // 0
            4, 4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, // 1
            4, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, // 2
            1, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, // 3
            1, 0, 0, 0, 1, 1, 1, 4, 4, 4, 4, 1, 1, 1, 1, 1, 1, 0, 0, 1, // 4
            1, 0, 0, 1, 1, 0, 0, 1, 4, 4, 1, 1, 0, 0, 0, 0, 1, 0, 0, 1, // 5
            1, 0, 0, 1, 0, 0, 0, 0, 1, 4, 1, 0, 0, 0, 0, 0, 1, 0, 0, 1, // 6
            1, 0, 0, 1, 0, 0, 0, 0, 0, 1, 1, 0, 0, 5, 0, 0, 1, 0, 0, 1, // 7
            1, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 1, 0, 0, 1, 0, 0, 1, // 8
            1, 0, 0, 1, 0, 0, 5, 0, 0, 0, 5, 0, 0, 1, 0, 0, 1, 0, 0, 1, // 9
            1, 2, 2, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 5, 0, 0, 1, // 10
            1, 1, 1, 1, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 1, // 11
            0, 3, 0, 0, 0, 0, 1, 4, 1, 0, 0, 0, 1, 1, 0, 0, 0, 0, 0, 1, // 12
            0, 3, 0, 0, 0, 0, 1, 4, 4, 1, 1, 1, 1, 1, 1, 0, 0, 0, 1, 1, // 13
            1, 1, 1, 1, 1, 1, 1, 4, 4, 4, 4, 4, 4, 1, 1, 1, 1, 1, 1, 4  // 14
        ]
        player = Track.draw(self, origin: CGPoint.zero, level: level)
        TitleNode.get(self, position: CGPoint(x: frame.midX, y: frame.midY))
    } // didMove
    
    /// Game over
    ///
    /// Removes the ball and closes the scene
    func gameOver() {
        let scene = GameOver(size: self.size)
        scene.scaleMode = .aspectFit
        let transition = SKTransition.push(with: .up, duration: 1)
        view?.presentScene(scene, transition: transition)
        player?.node?.removeFromParent()
    }

    
    override func keyDown(with event: NSEvent) {
        keyPressed.insert(event.keyCode)
    }

    override func keyUp(with event: NSEvent) {
        keyPressed.remove(event.keyCode)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = (
            contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        )
        switch collision {
        case Contact.car | Contact.finish:
            gameOver()
        case Contact.car | Contact.wall, Contact.car:
            player?.bonk()
//        case Contact.car | Contact.flag:
//            // TODO: AI driver stuff
//            break
        default: break
        } // switch
    }

    override func update(_ currentTime: TimeInterval) { 
        if keyPressed.contains(0x7B) { player?.leftKey() } // left
        if keyPressed.contains(0x7C) { player?.rightKey() } // right
        if keyPressed.contains(0x7D) { player?.downKey() } // down
        if keyPressed.contains(0x7E) { player?.upKey() } // up
    }
    
} // GameScene
