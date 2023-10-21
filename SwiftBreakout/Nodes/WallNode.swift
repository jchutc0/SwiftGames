//
//  WallNode.swift
//  SwiftBreakout
//
//  Created by jchutc0 on 10/1/23.
//

import SpriteKit

class WallNode {
    
    static func add(_ scene: SKScene) {
        let verticalRect = CGRect(x: -1, y: -scene.frame.height/2, width: 3, height: scene.frame.height)
        let horizontalRect = CGRect(x: -scene.frame.width/2, y: -1, width: scene.frame.width, height: 3)

        let leftNode = getNode(
            position: CGPoint(x: scene.frame.minX, y: scene.frame.midY),
            rect: verticalRect
        )
        scene.addChild(leftNode)
        
        let rightNode = getNode(
            position: CGPoint(x: scene.frame.maxX, y: scene.frame.midY),
            rect: verticalRect
        )
        scene.addChild(rightNode)
        
        let topNode = getNode(
            position: CGPoint(x: scene.frame.midX, y: scene.frame.maxY),
            rect: horizontalRect
        )
        topNode.physicsBody?.contactTestBitMask = Collision.ball
        scene.addChild(topNode)
        
        let bottomNode = getNode(
            position: CGPoint(x: scene.frame.midX, y: scene.frame.minY),
            rect: horizontalRect
        )
        bottomNode.physicsBody?.categoryBitMask = Collision.floor
        bottomNode.physicsBody?.contactTestBitMask = Collision.ball
        scene.addChild(bottomNode)
        
    } // add
    
    static func getNode(
        position: CGPoint,
        rect: CGRect
    ) -> SKShapeNode {
        let node = SKShapeNode(rect: rect)
        node.strokeColor = .clear
        node.position = position
        node.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: rect.width, height: rect.height))
        node.physicsBody?.categoryBitMask = Collision.wall
        node.physicsBody?.contactTestBitMask = Collision.ball | Collision.paddle
        node.physicsBody?.collisionBitMask = Collision.ball | Collision.paddle
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.physicsBody?.allowsRotation = false
        node.physicsBody?.restitution = 1

        return node
    }
    
    
}
