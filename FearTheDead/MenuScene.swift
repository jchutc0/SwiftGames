/**
 * Copyright (c) 2017 Razeware LLC
 *
 * Permission is hereby granted, free of charge, to any person obtaining a copy
 * of this software and associated documentation files (the "Software"), to deal
 * in the Software without restriction, including without limitation the rights
 * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice shall be included in
 * all copies or substantial portions of the Software.
 *
 * Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
 * distribute, sublicense, create a derivative work, and/or sell copies of the
 * Software in any work that is designed, intended, or marketed for pedagogical or
 * instructional purposes related to programming, coding, application development,
 * or information technology.  Permission for such use, copying, modification,
 * merger, publication, distribution, sublicensing, creation of derivative works,
 * or sale is expressly withheld.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 * THE SOFTWARE.
 */

import SpriteKit

class MenuScene: SKScene {
    var didWin: Bool
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    init(size: CGSize, didWin: Bool) {
        self.didWin = didWin
        super.init(size: size)
        scaleMode = .aspectFill
    }
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(white: 0, alpha: 1)
        
        // Set up labels
        let text = didWin ? "You Won!!!" : "You lost :["
        let winLabel = SKLabelNode(text: text)
        winLabel.fontName = "AvenirNext-Bold"
        winLabel.fontSize = 65
        winLabel.fontColor = .white
        winLabel.position = CGPoint(x: frame.midX, y: frame.midY*1.5)
        addChild(winLabel)
        
        let label = SKLabelNode(text: "Press anywhere to play again!")
        label.fontName = "AvenirNext-Bold"
        label.fontSize = 55
        label.fontColor = .white
        label.position = CGPoint(x: frame.midX, y: frame.midY)
        addChild(label)
        
        // Play sound
        let soundToPlay = didWin ? "fear_win.mp3" : "fear_lose.mp3"
        run(SKAction.playSoundFileNamed(soundToPlay, waitForCompletion: false))
        
    }
    
    override func mouseDown(with event: NSEvent) {
        guard let gameScene = GameScene(fileNamed: "GameScene") else {
            fatalError("GameScene not found")
        }
        let transition = SKTransition.flipVertical(withDuration: 1.0)
        gameScene.scaleMode = .aspectFill
        view?.presentScene(gameScene, transition: transition)
    }
}
