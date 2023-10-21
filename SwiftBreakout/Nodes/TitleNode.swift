//
//  TitleNode.swift
//  SwiftBreakout
//
//  Created by jchutc0 on 10/1/23.
//

import SpriteKit

class TitleNode {
    static func get(_ scene: SKScene, position: CGPoint) {
        let title = SKLabelNode()
        title.position = position
        title.text = "SwiftBreakout"
        title.fontSize = 72
        title.alpha = 0
        let fadeIn = SKAction.fadeIn(withDuration: 1)
        let fadeOut = SKAction.fadeOut(withDuration: 1)
        let newText = SKAction.run {
            title.fontSize = 48
            title.text = "Click or press any key to begin"
        }
        let sequence = SKAction.sequence([fadeIn, fadeOut, newText, fadeIn, fadeOut])
        title.run(sequence)
        scene.addChild(title)
    }
} // TitleNode
