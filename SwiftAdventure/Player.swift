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
    
    func move(keypress: Keypress, map: SKTileMapNode?) {
        guard let node, let map, keypress.arrowPressed else { return }
        

        let lowerLeft = node.frame.origin.translate(x: charPadding, y: charPadding)
        let lowerRight = lowerLeft.translate(x: node.frame.width - 2 * charPadding, y: 0)
        let upperRight = lowerRight.translate(x: 0, y: node.frame.height - 2 * charPadding)
        let upperLeft = CGPoint(x: lowerLeft.x, y: upperRight.y)

        if keypress.leftArrow {
            move(upperLeft, lowerLeft, translate: CGPoint(x: -speed, y: 0), map: map)
        } // left
        if keypress.rightArrow {
            move(upperRight, lowerRight, translate: CGPoint(x: speed, y: 0), map: map)
        } // right
        if keypress.downArrow {
            move(lowerLeft, lowerRight, translate: CGPoint(x: 0, y: -speed), map: map)
        } // down
        if keypress.upArrow {
            move(upperLeft, upperRight, translate: CGPoint(x: 0, y: speed), map: map)
        } // up
    } // move
    
    func move(_ p1: CGPoint, _ p2: CGPoint, translate: CGPoint, map: SKTileMapNode) {
        guard let node else { return }
        if (
            validPointMove(p1, translate: translate, map: map) &&
            validPointMove(p2, translate: translate, map: map)
        ) {
            self.node?.position = CGPoint(x: CGFloat(Int(node.position.x + translate.x)), y: CGFloat(Int(node.position.y + translate.y)))
        }
    }
    
    func validPointMove(_ p: CGPoint, translate: CGPoint, map: SKTileMapNode) -> Bool {
        let newPoint = p.translate(translate)
        let x = map.tileColumnIndex(fromPosition: newPoint)
        let y = map.tileRowIndex(fromPosition: newPoint)
        let tile = map.tileDefinition(atColumn: x, row: y)
        return tile?.userData?["passable"] as? Bool ?? true

    } // validPointMove
    
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

extension CGPoint {
    func translate(x: CGFloat, y: CGFloat) -> CGPoint {
        CGPoint(x: self.x + x, y: self.y + y)
    } // translate
    
    func translate(_ p: CGPoint) -> CGPoint {
        CGPoint(x: self.x + p.x, y: self.y + p.y)
    } // translate
} // CGPoint
