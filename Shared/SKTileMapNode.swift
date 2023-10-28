//
//  SKTileMapNode.swift
//
//  Created by jchutc0 on 10/28/23.
//

import SpriteKit


extension SKTileMapNode {
    
    /// createInvisibleNodes
    ///
    /// creates invisible map nodes to let tiles interact with physics
    /// takes:
    /// scene (probably self)
    /// tileMapName - the name of the tileMap to search for tiles
    /// userDataVariable - the name of the userData variable (default: "edgeTile")
    static func createInvisibleNodes(
        scene: SKScene,
        tileMapName: String,
        userDataVariable: String = "edgeTile"
    ) -> SKTileMapNode {
        let tileMap = scene.childNode(withName: tileMapName) as? SKTileMapNode
        guard let tileMap else { fatalError("Missing tile map for the level") }

        let tileSize = tileMap.tileSize
        let halfWidth = CGFloat(tileMap.numberOfColumns) / 2.0 * tileSize.width
        let halfHeight = CGFloat(tileMap.numberOfRows) / 2.0 * tileSize.height

        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row)
                let isEdgeTile = tileDefinition?.userData?[userDataVariable] as? Bool
                if (isEdgeTile ?? false) {
                    let x = CGFloat(col) * tileSize.width - halfWidth
                    let y = CGFloat(row) * tileSize.height - halfHeight
                    let rect = CGRect(x: 0, y: 0, width: tileSize.width, height: tileSize.height)
                    let tileNode = SKShapeNode(rect: rect)
                    tileNode.position = CGPoint(x: x, y: y)
                    tileNode.physicsBody = SKPhysicsBody.init(rectangleOf: tileSize, center: CGPoint(x: tileSize.width / 2.0, y: tileSize.height / 2.0))
                    tileNode.physicsBody?.isDynamic = false
                    tileNode.isHidden = true
                    tileMap.addChild(tileNode)
                } // if isEdgeTile
            } // for row
        } // for col
        return tileMap
    } // createInvisibleNodes
    
} // SKTileMapNode
