//
//  TitleNode.swift
//  SwiftRacer
//
//  Created by jchutc0 on 10/4/23.
//

import SpriteKit

class TitleNode {
    static func get(_ scene: SKScene, position: CGPoint) {
        let title = SKLabelNode()
        title.position = position
        title.text = "SwiftRacer"
        title.fontSize = 72
        title.alpha = 0
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let newText = SKAction.run {
            title.fontSize = 48
            title.text = "Use the arrow keys to control your racer!"
        }
        let removeAction = SKAction.removeFromParent()
        let sequence = SKAction.sequence([fadeIn, fadeOut, newText, fadeIn, fadeOut, removeAction])
        title.run(sequence)
        scene.addChild(title)
    }
} // TitleNode
