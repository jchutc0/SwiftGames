//
//  Track.swift
//  SwiftRacer
//
//  Created by jchutc0 on 10/2/23.
//

import SpriteKit

class Track {
    static let tileSize = CGSize(width: 40, height: 40)
    static let columns = 20
    static let rows = 15
    
    var cars: [Car] = []
    var player: Car? { cars.first }
    var flags: [SKShapeNode] = []
    
    static func draw(_ scene: SKScene, origin: CGPoint, level: [Int]) -> Car? {
        var pointer = CGPoint(
            x: origin.x + tileSize.width/2,
            y: origin.y + (CGFloat(rows) - 0.5 ) * tileSize.height
        )
        var cars: [Car] = []
        let rect = CGRect(origin: CGPoint(x: -tileSize.width/2, y: -tileSize.height/2), size: tileSize)
                
        var colCount = Int(0)
        for tile in level {
            let node = SKShapeNode(rect: rect)
            node.fillColor = .gray
            node.lineWidth = 0
            switch(tile) {
            case 1:
                makeBarrier(node: node, textureFile: "wall")
            case 2:
                node.fillTexture = SKTexture(imageNamed: "road")
                let carFile = cars.isEmpty ? "playerCar" : "greenCar"
                let car = Car(
                    scene: scene, 
                    fileName: carFile,
                    position: pointer,
                    rotation: CGFloat.pi/2
                )
                cars.append(car)
            case 3:
                makeBarrier(node: node, textureFile: "finishLine")
                node.physicsBody?.categoryBitMask = Contact.finish
                node.physicsBody?.collisionBitMask = 0x0
                node.physicsBody?.contactTestBitMask = Contact.car
            case 4:
                makeBarrier(node: node, textureFile: "trees")
            case 5:
                makeBarrier(node: node, textureFile: "flag")
                node.physicsBody?.categoryBitMask = Contact.flag
                node.physicsBody?.collisionBitMask = 0x0
                node.physicsBody?.contactTestBitMask = Contact.car
            default:
                 node.fillTexture = SKTexture(imageNamed: "road")
            } // switch
            node.zPosition = -1
            node.position = pointer
            scene.addChild(node)
            pointer.x += tileSize.width
            colCount += 1
            if colCount >= columns {
                pointer.x = origin.x + tileSize.width/2
                pointer.y -= tileSize.height
                colCount = 0
            }
        }
        return cars.first
    } // draw
    
    static func makeBarrier(node: SKShapeNode, textureFile: String) {
        node.physicsBody = SKPhysicsBody(rectangleOf: Track.tileSize)
        node.physicsBody?.categoryBitMask = Contact.wall
        node.physicsBody?.contactTestBitMask = Contact.car
        node.physicsBody?.collisionBitMask = Contact.car
        node.physicsBody?.affectedByGravity = false
        node.physicsBody?.isDynamic = false
        node.physicsBody?.allowsRotation = false
        node.fillTexture = SKTexture(imageNamed: textureFile)
    }
}
