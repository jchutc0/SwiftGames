//
//  Car.swift
//  SwiftRacer
//
//  Created by jchutc0 on 10/2/23.
//

import SpriteKit

class Car {
    static let size = CGSize(width: 41, height: 14)
    var node: SKSpriteNode?
    private var _Rotation = CGFloat(0)
    private var _Speed = CGFloat(0)
    
    private let acceleration = CGFloat(5)
    private let turnRadius = CGFloat(0.06)

    var speed: CGFloat {
        get { _Speed }
        set { 
            _Speed = newValue
            setVelocity()
        }
    } // speed
    
    var rotation: CGFloat {
        get { _Rotation }
        set { 
            _Rotation = newValue
            setVelocity()
        }
    } // rotation
    
    init(scene:SKScene, fileName: String, position: CGPoint, rotation: CGFloat) {
        _Rotation = rotation
        node = SKSpriteNode(texture: SKTexture(imageNamed: fileName))
        if let node {
            node.physicsBody = SKPhysicsBody(rectangleOf: Car.size)
            node.physicsBody?.categoryBitMask = Contact.car
            node.physicsBody?.contactTestBitMask = Contact.finish | Contact.flag
            node.physicsBody?.collisionBitMask = Contact.wall | Contact.car
            node.physicsBody?.affectedByGravity = false
            node.physicsBody?.isDynamic = true
            node.physicsBody?.allowsRotation = true
            node.zRotation = rotation
            node.position = position
            scene.addChild(node)
        } // let node
    } // init
    
    func setVelocity() {
        let dx = cos(_Rotation) * _Speed
        let dy = sin(_Rotation) * _Speed
        node?.physicsBody?.velocity = CGVector(dx: dx, dy: dy)
        node?.zRotation = _Rotation
    } // setVelocity
    
    func leftKey() { 
        _Rotation = node?.zRotation ?? _Rotation
        if abs(_Speed) > 0 { rotation += turnRadius }
    }
    
    func rightKey() { 
        _Rotation = node?.zRotation ?? _Rotation
        if abs(_Speed) > 0 { rotation -= turnRadius }
    }
    
    func downKey() { speed -= acceleration }
    
    func upKey() { speed += acceleration }
    
    func bonk() {
        speed = 0
    }

} // Car
