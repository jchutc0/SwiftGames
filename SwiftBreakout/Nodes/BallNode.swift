//
//  BallNode.swift
//  SwiftBreakout
//
//  Created by jchutc0 on 10/1/23.
//

import SpriteKit

class BallNode {
    var node: SKShapeNode?
    let radius = CGFloat(10)
    var contactV: CGVector?

    init() {
        node = SKShapeNode(circleOfRadius: radius)
        let color = NSColor(red: 223/255, green: 255/255, blue: 0.0, alpha: 1.0)
        if let node {
            let contactMask = Collision.paddle | Collision.wall | Collision.floor | Collision.tile
            node.fillColor = color
            node.strokeColor = color
            node.physicsBody = SKPhysicsBody(circleOfRadius: radius)
            node.physicsBody?.isResting = false
            node.physicsBody?.categoryBitMask = Collision.ball
            node.physicsBody?.contactTestBitMask = contactMask
            node.physicsBody?.collisionBitMask = contactMask
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.allowsRotation = false
            node.physicsBody?.friction = 0
            node.physicsBody?.restitution = 1
            node.physicsBody?.linearDamping = 0
        }
    }
    
    func add(_ scene: SKScene, position: CGPoint) {
        if let node {
            node.position = position
            node.physicsBody?.velocity = CGVector(dx: 200, dy: 200)
            scene.addChild(node)
        }
    }
    
}
