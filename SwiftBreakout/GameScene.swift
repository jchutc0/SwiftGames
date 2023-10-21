//
//  GameScene.swift
//  SwiftBreakout
//
//  Created by jchutc0 on 10/1/23.
//

import SpriteKit
import GameplayKit

struct Collision {
    static let ball     = UInt32(0x1)
    static let paddle   = UInt32(0x10)
    static let wall     = UInt32(0x10)
    static let floor    = UInt32(0x100)
    static let tile     = UInt32(0x1000)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    /// Paddle Node
    ///
    /// Holds the paddle shape node, setup functions, and constants.
    let paddle = PaddleNode()
    let ball = BallNode()
    
    var pause = Bool(true)
    
    var keyStateLeft = Bool(false)
    var keyStateRight = Bool(false)

    var viewCenter: CGPoint { CGPoint(x: self.frame.midX, y: self.frame.midY) }
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        paddle.add(self, position: CGPoint(x: frame.midX, y: paddle.paddleHeight/2))
        WallNode.add(self)
        TileNode.makeGrid(self, center: CGPoint(x: self.frame.midX, y: self.frame.maxY * 0.7))
        TitleNode.get(self, position: viewCenter)
    }
    
    // MARK: - Controls
    override func mouseDragged(with event: NSEvent) {
        paddle.moveTo(value: event.location(in: self).x, frame: frame)
    }
    
    override func mouseDown(with event: NSEvent) {
        if pause { beginGame() }
    }
    
    override func keyDown(with event: NSEvent) {
        if pause { beginGame() }
        switch event.keyCode {
        case 0x7B: keyStateLeft = true
        case 0x7C: keyStateRight = true
        default: break
        } // switch keyCode
    }
    
    override func keyUp(with event: NSEvent) {
        switch event.keyCode {
        case 0x7B: keyStateLeft = false
        case 0x7C: keyStateRight = false
        default: break
        } // switch keyCode
    }
    
    override func update(_ currentTime: TimeInterval) {
        if keyStateLeft { paddle.move(left: true, frame: frame) }
        if keyStateRight { paddle.move(left: false, frame: frame) }
        if !keyStateLeft && !keyStateRight { paddle.stop() }
    }
    
    func beginGame() {
        pause.toggle()
        let newPosition = CGPoint(
            x: paddle.position.x,
            y: paddle.position.y + paddle.paddleHeight/2 + ball.radius
        )
        ball.add(self, position: newPosition)
    }
    
    /// Game over
    ///
    /// Removes the ball and closes the scene
    func gameOver() {
        let scene = GameOver(size: self.size)
        scene.scaleMode = .aspectFit
        let transition = SKTransition.push(with: .down, duration: 1)
        self.view?.presentScene(scene, transition: transition)
        ball.node?.removeFromParent()
        pause = true
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        if collision == Collision.floor | Collision.ball {
            gameOver()
        } else if collision == Collision.ball | Collision.tile {
            if contact.bodyA.categoryBitMask == Collision.ball {
                contact.bodyB.node?.removeFromParent()
            } else {
                contact.bodyA.node?.removeFromParent()
            }
        }
    }
}
