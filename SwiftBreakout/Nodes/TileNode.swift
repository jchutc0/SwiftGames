//
//  TileNode.swift
//  SwiftBreakout
//
//  Created by jchutc0 on 10/2/23.
//

import SpriteKit

class TileNode {
    static let size = CGSize(width: 80, height: 20)
    static let gap = CGSize(width: 4, height: 4)
    static let cols = CGFloat(10)
    static let rows = CGFloat(14)
    
    static func makeGrid(_ scene: SKScene, center: CGPoint) {
        let rowLength = CGFloat(cols) * size.width + CGFloat(cols - 1) * gap.width
        let colHeight = rows * size.height + (rows - 1) * gap.height
        let startCenterX = center.x - rowLength / 2 - size.width / 2
        let endCenterX = center.x + rowLength / 2 + size.width / 2
        let startCenterY = center.y - colHeight / 2 - size.height / 2
        let endCenterY = center.y + colHeight / 2 + size.height / 2
//        let physicsSize = CGSize(width: size.width, height: size.height - 10)
        for j in stride(from: startCenterY, through: endCenterY, by: size.height + gap.height) {
            for i in stride(from: startCenterX, through: endCenterX, by: size.width + gap.width) {
                let node = SKShapeNode(rect: CGRect(origin: CGPoint.zero, size: size), cornerRadius: 5)
                node.position = CGPoint(x: i, y: j)
                node.fillColor = .blue
                node.strokeColor = .blue
                node.physicsBody = SKPhysicsBody(rectangleOf: size, center: CGPoint(x: size.width/2, y: size.height/2))
                node.physicsBody?.categoryBitMask = Collision.tile
                node.physicsBody?.contactTestBitMask = Collision.ball
                node.physicsBody?.collisionBitMask = Collision.ball
                node.physicsBody?.affectedByGravity = false
                node.physicsBody?.isDynamic = false
                node.physicsBody?.allowsRotation = false
                node.physicsBody?.restitution = 1
                scene.addChild(node)
            }
        }

    }
}
