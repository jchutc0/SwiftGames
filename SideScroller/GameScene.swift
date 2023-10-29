//
//  GameScene.swift
//  SideScroller
//
//  Created by jchutc0 on 10/27/23.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var keypress = Keypress.arrowKeys()
    var player: SKSpriteNode?
    var map: SKTileMapNode?
    let cameraBoundry = CGPoint(x: 250, y: 150)
    let playerSpeed = CGFloat(5)
        
    override func didMove(to view: SKView) {
        player = childNode(withName: "player") as? SKSpriteNode
        map = SKTileMapNode
            .createInvisibleNodes(scene: self, tileMapName: "Walls")
        if let player {
            camera?.position = player.position
        }
    } // didMove
    
    override func keyUp(with event: NSEvent) { keypress.keyUp(event) }
    override func keyDown(with event: NSEvent) { keypress.keyDown(event) }
    override func update(_ currentTime: TimeInterval) {
        if let pos = player?.position, let camera = camera {
            if keypress.arrowPressed {
                if keypress.leftArrow {
                    player?.position.x = pos.x - playerSpeed
                    if pos.x < camera.frame.origin.x - cameraBoundry.x {
                        self.camera?.position.x = camera.position.x - playerSpeed
                    }
                    player?.zRotation = CGFloat.pi / 2
                }
                if keypress.rightArrow {
                    player?.position.x = pos.x + playerSpeed
                    if pos.x > camera.frame.origin.x + cameraBoundry.x {
                        self.camera?.position.x = camera.position.x + playerSpeed
                    }
                    player?.zRotation = CGFloat.pi * 1.5
                }
                if keypress.downArrow {
                    player?.position.y = pos.y - playerSpeed
                    if pos.y < camera.frame.origin.y - cameraBoundry.y {
                        self.camera?.position.y = camera.position.y - playerSpeed
                    }
                    player?.zRotation = CGFloat.pi
                }
                if keypress.upArrow {
                    player?.position.y = pos.y + playerSpeed
                    if pos.y > camera.frame.origin.y + cameraBoundry.y {
                        self.camera?.position.y = camera.position.y + playerSpeed
                    }
                    player?.zRotation = 0
                }
            } // arrowPressed
        }
    }

}
