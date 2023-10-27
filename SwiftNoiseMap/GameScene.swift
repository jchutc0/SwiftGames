//
//  GameScene.swift
//  SwiftAdventure
//
//  Created by jchutc0 on 10/21/23.
//

import SpriteKit
import GameplayKit

class Contact {
    static let car      = UInt32(0x1)
    static let wall     = UInt32(0x10)
    static let finish   = UInt32(0x100)
    static let flag     = UInt32(0x1000)
}

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var keyPressed: Set<UInt16> = []
    let map = SKNode()
    
    override func didMove(to view: SKView) {
        physicsWorld.contactDelegate = self
        
        addChild(map)
        map.xScale = 0.2
        map.yScale = 0.2
        let tileSet = SKTileSet(named: "Sample Grid Tile Set")!
        let tileSize = CGSize(width: 128, height: 128)
        let columns = 128
        let rows = 128
        let waterTiles = tileSet.tileGroups.first { $0.name == "Water" }
        let grassTiles = tileSet.tileGroups.first { $0.name == "Grass" }
        let sandTiles = tileSet.tileGroups.first { $0.name == "Sand" }
        let bottomLayer = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
        bottomLayer.fill(with: sandTiles)
        map.addChild(bottomLayer)
        let noiseMap = makeNoiseMap(columns: columns, rows: rows)
        let topLayer = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: tileSize)
        topLayer.enableAutomapping = true
        map.addChild(topLayer)
        for column in 0 ..< columns {
            for row in 0 ..< rows {
                let location = vector2(Int32(row), Int32(column))
                let terrainHeight = noiseMap.value(at: location)
                
                if terrainHeight < 0 {
                    topLayer.setTileGroup(waterTiles, forColumn: column, row: row)
                } else {
                    topLayer.setTileGroup(grassTiles, forColumn: column, row: row)
                }
            }
        }

    } // didMove
    
    func makeNoiseMap(columns: Int, rows: Int) -> GKNoiseMap {
        let source = GKPerlinNoiseSource()
        source.persistence = 2
        let noise = GKNoise(source)
        let size = vector2(1.0, 1.0)
        let origin = vector2(0.0, 0.0)
        let sampleCount = vector2(Int32(columns), Int32(rows))
        
        return GKNoiseMap(noise, size: size, origin: origin, sampleCount: sampleCount, seamless: true)
    }
    
    /// Game over
    ///
    /// Removes the ball and closes the scene
    func gameOver() {
//        let scene = GameOver(size: self.size)
//        scene.scaleMode = .aspectFit
//        let transition = SKTransition.push(with: .up, duration: 1)
//        view?.presentScene(scene, transition: transition)
//        player?.node?.removeFromParent()
    }

    
    override func keyDown(with event: NSEvent) {
        keyPressed.insert(event.keyCode)
    }

    override func keyUp(with event: NSEvent) {
        keyPressed.remove(event.keyCode)
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        let collision: UInt32 = (
            contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        )
        switch collision {
        case Contact.car | Contact.finish:
            gameOver()
        default: break
        } // switch
    }

    override func update(_ currentTime: TimeInterval) {
//        if keyPressed.contains(0x7B) { player?.leftKey() } // left
//        if keyPressed.contains(0x7C) { player?.rightKey() } // right
//        if keyPressed.contains(0x7D) { player?.downKey() } // down
//        if keyPressed.contains(0x7E) { player?.upKey() } // up
    } // update
    
} // GameScene
