//
//  GameScene.swift
//  SwiftTennis
//
//  Created by jchutc0 on 9/30/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let ballCategory: UInt32 = 0x1
    let paddle1Category: UInt32 = 0x10
    let paddle2Category: UInt32 = 0x100

    let scoreLabel1 = SKLabelNode()
    let scoreLabel2 = SKLabelNode()
    let titleLabel = SKLabelNode()
    let paddle1 = SKShapeNode()
    let paddle2 = SKShapeNode()
    let ball = SKShapeNode()
    let labelText1 = "Player 1 Score: "
    let labelText2 = "Player 2 Score: "
    let paddleWidth = CGFloat(10)
    let paddleHeight = CGFloat(100)
    let maxScore = Int(3)
    let ballRadius = CGFloat(10)
    var score1 = Int(0)
    var score2 = Int(0)
    var keyStateUp = Bool(false)
    var keyStateDown = Bool(false)

    // MARK: - Draw Scene
    override func didMove(to view: SKView) {
        self.physicsWorld.contactDelegate = self
        drawTitle()
        drawNet()
        makeLabels(scoreLabel1, scoreLabel2)
        makePaddles()
        makeBall()
    }
    
    func drawTitle() {
        titleLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        titleLabel.text = "SwiftTennis"
        titleLabel.fontSize = 72
        titleLabel.fontName = "Helvetica"
        titleLabel.alpha = 0
        let fadeIn = SKAction.fadeIn(withDuration: 2)
        let fadeOut = SKAction.fadeOut(withDuration: 2)
        let sequence = SKAction.sequence([fadeIn, fadeOut])
        titleLabel.run(sequence)
        self.addChild(titleLabel)
    }
    
    func drawNet() {
        let path = CGMutablePath()
        path.move(to: CGPoint(x: self.frame.midX, y: self.frame.height))
        path.addLine(to: CGPoint(x: self.frame.midX, y: 0))
        let line = SKShapeNode(path: path.copy(dashingWithPhase: 0, lengths: [25.0, 10.0]))
        line.strokeColor = .white
        line.lineWidth = 5
        self.addChild(line)
    } // drawNet
    
    func makeLabels(_ labelA: SKLabelNode, _ labelB: SKLabelNode) {
        labelA.position = CGPoint(x: self.frame.width * 0.25, y: self.frame.height * 0.85)
        labelA.text = "\(labelText1)\(score1)"
        labelA.fontSize = 24
        labelA.fontName = "Helvetica-Bold"
        self.addChild(labelA)
        labelB.position = CGPoint(x: self.frame.width * 0.75, y: self.frame.height * 0.85)
        labelB.text = "\(labelText2)\(score2)"
        labelB.fontSize = 24
        labelB.fontName = "Helvetica-Bold"
        self.addChild(labelB)
    } // makeLabels
    
    func makePaddles() {
        let positionA = CGPoint(x: paddleWidth/2, y: self.frame.midY)
        let positionB = CGPoint(x: self.frame.width - paddleWidth/2, y: self.frame.midY)
        makePaddle(paddle1, position: positionA, category: paddle1Category)
        makePaddle(paddle2, position: positionB, category: paddle2Category)
    } // makePaddles
    
    func makePaddle(_ paddle: SKShapeNode, position: CGPoint, category: UInt32) {
        let roundedRect = SKShapeNode(rect: CGRect(x: -paddleWidth/2, y: -paddleHeight/2, width: paddleWidth, height: paddleHeight), cornerRadius: 5)
        paddle.path = roundedRect.path
        paddle.position = position
        paddle.fillColor = .white
        paddle.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: paddleWidth, height: paddleHeight))
        paddle.physicsBody?.categoryBitMask = category
        paddle.physicsBody?.contactTestBitMask = ballCategory
        paddle.physicsBody?.collisionBitMask = ballCategory
        paddle.physicsBody?.affectedByGravity = false
        paddle.physicsBody?.isDynamic = false
        paddle.physicsBody?.allowsRotation = false
        self.addChild(paddle)
    } // makePaddles
    
    func makeBall() {
        let circle = SKShapeNode(circleOfRadius: ballRadius)
        let color = NSColor(red: 223/255, green: 255/255, blue: 0.0, alpha: 1.0)
        ball.path = circle.path
        ball.fillColor = color
        ball.strokeColor = color
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ballRadius)
        ball.physicsBody?.isResting = false
        ball.physicsBody?.categoryBitMask = ballCategory
        ball.physicsBody?.contactTestBitMask = paddle1Category | paddle2Category
        ball.physicsBody?.collisionBitMask = paddle1Category | paddle2Category
        ball.physicsBody?.affectedByGravity = false
        ball.physicsBody?.allowsRotation = false
        ball.physicsBody?.friction = 0
        ball.physicsBody?.linearDamping = 0
        self.addChild(ball)
        resetBall()
    } // makeBall
    
    func resetBall() {
        ball.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
        let randomDx = Int.random(in: 1...10)
        let randomDy = Int.random(in: 1...10)
        let xDirection = Int.random(in: 0...1) == 0 ? 1 : -1
        let yDirection = Int.random(in: 0...1) == 0 ? 1 : -1
        let impulse = CGVector(dx: randomDx * xDirection, dy: randomDy * yDirection)
        ball.physicsBody?.applyImpulse(impulse)
    }
    
    func winGame(winString: String) {
        let scene = GameOver(size: self.size)
        scene.winString = winString
        scene.scaleMode = .aspectFit
        let transition = SKTransition.push(with: .up, duration: 1)
        self.view?.presentScene(scene, transition: transition)
    }
    
    // MARK: - Controls
//    func touchDown(atPoint pos : CGPoint) { }
//    
//    func touchMoved(toPoint pos : CGPoint) { }
//    
//    func touchUp(atPoint pos : CGPoint) { }
//    
//    override func mouseDown(with event: NSEvent) { }
//    
    override func mouseDragged(with event: NSEvent) { 
        paddle1.position.y = event.location(in: self).y
    }
//    
//    override func mouseUp(with event: NSEvent) { }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x7D: keyStateDown = true
        case 0x7E: keyStateUp = true
        default: break
        } // switch keyCode
    }
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 0x7D: keyStateDown = false
        case 0x7E: keyStateUp = false
        default: break
        } // switch keyCode
    }
        
    override func update(_ currentTime: TimeInterval) {
        if ball.position.y <= ballRadius ||
            ball.position.y >= self.frame.maxY - ballRadius {
            ball.physicsBody?.velocity.dy *= -1
        }
        if ball.position.x <= self.frame.minX {
            score2 += 1
            scoreLabel2.text = "\(labelText2)\(score2)"
            if score2 >= 3 { winGame(winString: "Better Luck Next Time") }
            resetBall()
        } else if ball.position.x >= self.frame.maxX {
            score1 += 1
            scoreLabel1.text = "\(labelText1)\(score1)"
            if score1 >= 3 { winGame(winString: "You Win!!!") }
            resetBall()
        }
        if paddle2.position.y < ball.position.y - 35 {
            paddle2.position.y += 5
        } else if paddle2.position.y > ball.position.y + 35 {
            paddle2.position.y -= 5
        }
        if keyStateUp && paddle1.position.y < self.frame.maxY - paddleHeight/2 {
            paddle1.position.y += 30
        }
        if keyStateDown && paddle1.position.y > self.frame.minY + paddleHeight/2 {
            paddle1.position.y -= 30
        }
        if let velocity = ball.physicsBody?.velocity.dx {
            if (velocity > -20 && velocity < 0) || (velocity > 0 && velocity < 20) {
                ball.physicsBody?.velocity.dx *= 10
            }
        }
    } // update
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == ballCategory | paddle1Category {
            let dy = ball.position.y - (paddle1.position.y + paddleHeight / 4)
            ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: dy/2))
        } else if collision == ballCategory | paddle2Category {
            let dy = ball.position.y - (paddle2.position.y + paddleHeight / 4)
            ball.physicsBody?.applyImpulse(CGVector(dx: -10, dy: dy/2))
        }
    } // didBegin
}
