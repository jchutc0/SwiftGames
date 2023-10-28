//
//  Player.swift
//  SwiftAdventure
//
//  Created by jchutc0 on 10/23/23.
//

import SpriteKit

struct Bitmask {
    static let player   = UInt32(0b1)
    static let key      = UInt32(0b10)
    static let door     = UInt32(0b100)
    static let goal     = UInt32(0b1000)
    static let wall     = UInt32(0b10000)
} // Bitmask

class Player {
    
    var keysCollected = Int(0)
    let speed = CGFloat(5.0)
    var node: SKNode?
    let charPadding = CGFloat(5)
    
    func reset() {
        keysCollected = 0
        node = nil
    }
    
    func move(_ keypress: Keypress) {
        guard let node, keypress.arrowPressed else { return }

        if keypress.leftArrow {
            self.node?.position = node.position.translate(x: -speed, y: 0)
        } // left
        if keypress.rightArrow {
            self.node?.position = node.position.translate(x: speed, y: 0)
        } // right
        if keypress.downArrow {
            self.node?.position = node.position.translate(x: 0, y: -speed)
        } // down
        if keypress.upArrow {
            self.node?.position = node.position.translate(x: 0, y: speed)
        } // up
    } // move
        
    func contact(_ contact: SKPhysicsContact, collision: UInt32) {
        // MARK: Collect key
        if collision == Bitmask.player | Bitmask.key {
            keysCollected += 1
            if contact.bodyA.categoryBitMask == Bitmask.player {
                contact.bodyB.node?.removeFromParent()
            } else {
                contact.bodyA.node?.removeFromParent()
            }
        } // player/key collision
        
        // MARK: Open door
        if collision == Bitmask.player | Bitmask.door {
            if keysCollected > 0 {
                keysCollected -= 1
                if contact.bodyA.categoryBitMask == Bitmask.player {
                    contact.bodyB.node?.removeFromParent()
                } else {
                    contact.bodyA.node?.removeFromParent()
                }
            } // if > 0 keys
        } // player/door collision
    } // contact

} // Player
