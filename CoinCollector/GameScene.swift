//
//  GameScene.swift
//  CoinCollector
//
//  Created by jchutc0 on 9/30/23.
//

import SpriteKit
import GameplayKit

struct KeyState {
    var up = Bool(false)
    var down = Bool(false)
    var left = Bool(false)
    var right = Bool(false)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let anvilCategory: UInt32 = 0x1         // 0000 0001 (1)
    let coinCategory: UInt32 = 0x10         // 0000 0010 (2)
    let characterCategory: UInt32 = 0x100   // 0000 0100 (4)
    let groundCategory: UInt32 = 0x1000     // 0000 1000 (8)

    private var label : SKLabelNode?
    private var character = SKSpriteNode()
    
    private var numberOfObjects = 0
    private var maxObjects = 5
    private var coinsColleced = 0
    private var maxCoins = 10
    private var keyState = KeyState()
        
    override func didMove(to view: SKView) {
        
        self.physicsWorld.contactDelegate = self

        self.label = self.childNode(withName: "//label") as? SKLabelNode

        character = buildCharacter()
        addChild(character)
        
        let ground = self.childNode(withName: "//ground") as? SKSpriteNode
        ground?.physicsBody?.categoryBitMask = groundCategory
        ground?.physicsBody?.contactTestBitMask = coinCategory | anvilCategory
        ground?.physicsBody?.collisionBitMask = coinCategory | anvilCategory
        
        physicsWorld.gravity = CGVector(dx: 0, dy: -0.8)

    } // didMove
    
    func buildCharacter() -> SKSpriteNode {
        let char = SKSpriteNode()
        char.size = CGSize(width: 100, height: 100)
        char.position = CGPoint(x: 0, y: -self.size.height / 2 + 100 + 50)
        char.physicsBody = SKPhysicsBody(circleOfRadius: 50)
        char.physicsBody?.categoryBitMask = characterCategory
        char.physicsBody?.contactTestBitMask = characterCategory
        char.physicsBody?.affectedByGravity = true
        char.physicsBody?.isDynamic = true
        char.physicsBody?.allowsRotation = false
        let characterTextures = [
            SKTexture(imageNamed: "frame1"),
            SKTexture(imageNamed: "frame2")
        ]
        let animation = SKAction.animate(with: characterTextures, timePerFrame: 0.1)
        let animationRepeat = SKAction.repeatForever(animation)
        char.run(animationRepeat)
        return char
    }
        
    func dropObject() {
        // randomly select what to drop and where to position it
        let frameWidth = Int(self.size.width / 2)
        let frameHeight = Int(self.size.height / 2)
        let random = Int.random(in: 1...2)
        let randomX = Int.random(in: -frameWidth...frameWidth)
        let randomY = Int.random(in: frameHeight + 75...frameHeight + 400)
        
        let object = SKSpriteNode(imageNamed: "goldCoin")
        object.position = CGPoint(x: randomX, y: randomY)
        object.size = CGSize(width: 150, height: 150)
        object.name = "coin"
        object.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        object.physicsBody?.categoryBitMask = coinCategory
        object.physicsBody?.contactTestBitMask = groundCategory | characterCategory
        object.physicsBody?.allowsRotation = false
        addChild(object)
        
        if random == 1 {
            object.name = "anvil"
            object.texture = SKTexture(imageNamed: "anvil")
            object.physicsBody?.categoryBitMask = anvilCategory
        }
        numberOfObjects += 1
    } // dropObject
    
    override func mouseDown(with event: NSEvent) { 
        let location = event.location(in: self)
        if location.x > character.position.x {
            character.position.x += 50
        } else if location.x < character.position.x {
            character.position.x -= 50
        }
    } // mouseDown
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x7B: keyState.left = true
        case 0x7C: keyState.right = true
        case 0x7D: keyState.down = true
        case 0x7E: keyState.up = true
        default: break
        } // switch keyCode
    } // keyDown
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 0x7B: keyState.left = false
        case 0x7C: keyState.right = false
        case 0x7D: keyState.down = false
        case 0x7E: keyState.up = false
        default: break
        } // switch
    } // keyUp

    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
                
        if collision == anvilCategory | groundCategory || collision == coinCategory | groundCategory {
            numberOfObjects -= 1
            if contact.bodyA.categoryBitMask == groundCategory { contact.bodyB.node?.removeFromParent() }
            else { contact.bodyA.node?.removeFromParent() }
        }
        
        if collision == characterCategory | coinCategory {
            coinsColleced += 1
            numberOfObjects -= 1
            label?.text = "Coins Collected: \(coinsColleced)"
            if contact.bodyA.categoryBitMask == coinCategory { contact.bodyA.node?.removeFromParent() }
            else { contact.bodyB.node?.removeFromParent() }
            if coinsColleced >= maxCoins {
                let scene = GameOver(fileNamed: "GameOver")!
                scene.scaleMode = .aspectFit
                let transition = SKTransition.push(with: .up, duration: 3)
                self.view?.presentScene(scene, transition: transition)
            }
        } else if collision == characterCategory | anvilCategory {
            character.texture = SKTexture(imageNamed: "hit")
            let scene = GameOver(fileNamed: "GameOver")
            scene!.win = false
            scene!.scaleMode = .aspectFit
            let transition = SKTransition.push(with: .up, duration: 3)
            self.view?.presentScene(scene!, transition: transition)
        }
        
    } // didBegin
    
    override func update(_ currentTime: TimeInterval) {
        if numberOfObjects < maxObjects { dropObject() }
        if keyState.left && character.position.x > -self.size.width / 2 {
            character.position.x -= 10
        }
        if keyState.right && character.position.x < self.size.width / 2 {
            character.position.x += 10
        }
    } // update
}
