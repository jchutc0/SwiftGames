//
//  PaddleNode.swift
//  SwiftBreakout
//
//  Created by jchutc0 on 10/1/23.
//

import SpriteKit

class PaddleNode {
    let node = SKShapeNode()
    let paddleWidth = CGFloat(100)
    let paddleHeight = CGFloat(10)
    let paddleSpeed = CGFloat(300)
    var position: CGPoint { node.position }

    init() {
        let roundedRect = SKShapeNode(rect: CGRect(x: -paddleWidth/2, y: -paddleHeight/2, width: paddleWidth, height: paddleHeight), cornerRadius: 5)
        let bitmasks = (
            Collision.ball |
            Collision.wall |
            Collision.floor
        )
        node.path = roundedRect.path
        node.fillColor = .white
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: paddleWidth, height: paddleHeight))
        node.physicsBody?.categoryBitMask = Collision.paddle
        node.physicsBody?.contactTestBitMask = bitmasks
        node.physicsBody?.collisionBitMask = bitmasks
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = true
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.linearDamping = 1.0
        node.physicsBody?.friction = 1.0
        node.physicsBody?.restitution = 1.0
    }
    
    func add(_ scene: SKScene, position: CGPoint) {
        node.position = position
        scene.addChild(node)
    }
    
    func moveTo(value: CGFloat, frame: CGRect) {
        if value > frame.minX + paddleWidth/2 && value < frame.maxX - paddleWidth/2 {
            node.position.x = value
        }
    }
    
    func move(left: Bool, frame: CGRect) {
        if left {
            node.physicsBody?.velocity.dx = -paddleSpeed
        } else {
            node.physicsBody?.velocity.dx = paddleSpeed
        }
    }
    
    func stop() {
        node.physicsBody?.velocity.dx = 0
        node.physicsBody?.velocity.dy = 0
    }
}
