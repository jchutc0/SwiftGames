//
//  GameScene.swift
//  SwiftLabelPlaying
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

class GameScene: SKScene {
    let label = SKLabelNode(text: "I Love Cristy")
    let labelSpeed = CGFloat(4)
    var keyState = KeyState()
    
    // scene setup
    override func didMove(to view: SKView) {
        // label details
        label.position = CGPoint(x: view.frame.width / 2, y: view.frame.height / 2)
        label.fontSize = 45
        label.fontColor = SKColor.systemTeal
        label.fontName = "Avenir"
        
        addChild(label)
    } // didMove
    
    // moves the label to the point where the mouse clicked with moveTo
    func moveTo(location: CGPoint) {
        let moveToAction = SKAction.move(to: location, duration: 1)
        label.run(moveToAction)
    } // moveTo
    
    // moves the label to the point where the mouse clicked with moveBy
    func moveBy(location: CGPoint) {
        let moveByAction = SKAction.moveBy(x: location.x - label.position.x, y: location.y - label.position.y, duration: 1)
        label.run(moveByAction)
    } // moveBy

    // does the same as moveBy but reverses the action at the end
    // this is the reason to use moveBy instead of moveTo if you want to do that
    func moveSequence(location: CGPoint) {
        let moveByAction = SKAction.moveBy(x: location.x - label.position.x, y: location.y - label.position.y, duration: 1)
        let moveByReversedAction = moveByAction.reversed()
        let moveByActions = [moveByAction, moveByReversedAction]
        let moveSequence = SKAction.sequence(moveByActions)
        label.run(moveSequence)
    } // moveSequence
    
    // repeats the move sequence 3 times
    func moveRepeatSequence(location: CGPoint) {
        let moveByAction = SKAction.moveBy(x: location.x - label.position.x, y: location.y - label.position.y, duration: 1)
        let moveByReversedAction = moveByAction.reversed()
        let moveByActions = [moveByAction, moveByReversedAction]
        let moveSequence = SKAction.sequence(moveByActions)

        let moveRepeatSequence = SKAction.repeat(moveSequence, count: 3)
        label.run(moveRepeatSequence)
    } // moveRepeatSequence

    // repeats the move sequence forever (until quit)
    func moveRepeatForever(location: CGPoint) {
        let moveByAction = SKAction.moveBy(x: location.x - label.position.x, y: location.y - label.position.y, duration: 1)
        let moveByReversedAction = moveByAction.reversed()
        let moveByActions = [moveByAction, moveByReversedAction]
        let moveSequence = SKAction.sequence(moveByActions)

        let moveRepeatSequence = SKAction.repeatForever(moveSequence)
        label.run(moveRepeatSequence)
    } // moveRepeatForever
    
    // shrinks the label to half its size
    func shrinkLabel() {
        let scaleAction = SKAction.scale(to: 0.5, duration: 1)
        label.run(scaleAction)
    }

    // shrinks the label to half its size if click is on the label (method 1)
    func scaleLocation1(location: CGPoint) {
        if atPoint(location) == label {
            let scale = SKAction.scale(to: 0.5, duration: 1)
            label.run(scale)
        }
    } // scaleLocation1

    // shrinks the label to half its size if click is on the label (method 2)
    func scaleLocation2(location: CGPoint) {
        if label.contains(location) {
            let scale = SKAction.scale(to: 0.5, duration: 1)
            label.run(scale)
        }
    } // scaleLocation2

    // shrinks the label to half its size if click is on the label (method 3)
    func scaleLocation3(location: CGPoint) {
        let sceneNodes = nodes(at: location)
        
        for node in sceneNodes {
            if node == label {
                let scale = SKAction.scale(to: 0.5, duration: 1)
                label.run(scale)
                break
            }
        }
    } // scaleLocation3

    // shrinks the label to half its size on the x axis
    func scaleLocationX(location: CGPoint) {
        if label.contains(location) {
            let scale = SKAction.scaleX(to: 0.5, duration: 1)
            label.run(scale)
        }
    } // scaleLocationX

    // expands the label to double its size on the y axis
    func scaleLocationY(location: CGPoint) {
        if label.contains(location) {
            let scale = SKAction.scaleY(to: 2, duration: 1)
            label.run(scale)
        }
    } // scaleLocationY

    // expands the label to double its size on the y axis and
    // shrinks the label to half its size on the x axis
    func scaleLocationXY(location: CGPoint) {
        if label.contains(location) {
            let scale = SKAction.scaleX(to: 0.5, y: 2, duration: 1)
            label.run(scale)
        }
    } // scaleLocationXY
    
    // scales the label and reverses the action
    func scalingsequence(location: CGPoint) {
        if label.contains(location) {
            let scale = SKAction.scale(by: 2, duration: 1)
            let reverseScale = scale.reversed()
            let actions = [scale, reverseScale]
            let sequence = SKAction.sequence(actions)
            label.run(sequence)
        }
    } // scalingsequence

    // scales the label and reverses the action along x and y axes
    func scalingsequenceXY(location: CGPoint) {
        if label.contains(location) {
            let scale = SKAction.scaleX(by: 0.5, y:2, duration: 1)
            let reverseScale = scale.reversed()
            let actions = [scale, reverseScale]
            let sequence = SKAction.sequence(actions)
            label.run(sequence)
        }
    } // scalingsequence

    // scales the label and reverses the action 3 times
    func scalingRepeatSequence(location: CGPoint) {
        if label.contains(location) {
            let scale = SKAction.scale(by: 2, duration: 1)
            let reverseScale = scale.reversed()
            let actions = [scale, reverseScale]
            let sequence = SKAction.sequence(actions)
            let repeatSequence = SKAction.repeat(sequence, count: 3)
            label.run(repeatSequence)
        }
    } // scalingRepeatSequence

    // moves then scales the label with scale to
    func moveScaleTo(location: CGPoint) {
        let move = SKAction.move(to: location, duration: 1)
        let scale = SKAction.scaleX(to: 0.5, y:2, duration: 1)
        let actions = [move, scale]
        let sequence = SKAction.sequence(actions)

        label.run(sequence)
    } // moveScaleTo
    
    // moves then scales the label with scale by
    func moveScaleBy(location: CGPoint) {
        let move = SKAction.move(to: location, duration: 1)
        let scale = SKAction.scaleX(by: 0.5, y:2, duration: 1)
        let actions = [move, scale]
        let sequence = SKAction.sequence(actions)

        label.run(sequence)
    } // moveScaleBy
    
    // moves then scales the label and reverses the action
    func moveScaleBySequence(location: CGPoint) {
        let vector = CGVector(
            dx: location.x - label.position.x,
            dy: location.y - label.position.y
        )
        let move = SKAction.move(by: vector, duration: 1)
        let scale = SKAction.scaleX(by: 0.5, y: 2, duration: 1)
        let sequence = SKAction.sequence([move, scale, scale.reversed(), move.reversed()])

        label.run(sequence)
    }

    // captures mouse clicks for interaction
    override func mouseDown(with event: NSEvent) {
        let location = event.location(in: self)
        moveScaleBySequence(location: location)
    }
        
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case 0x31:
            // spacebar
            let fadeOut = SKAction.fadeOut(withDuration: 1)
            let sequence = SKAction.sequence([fadeOut, fadeOut.reversed()])
            label.run(sequence)
        case 0x7B: keyState.left = true
        case 0x7C: keyState.right = true
        case 0x7D: keyState.down = true
        case 0x7E: keyState.up = true
        default: break
//            print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
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
    
    override func update(_ currentTime: TimeInterval) {
        if keyState.left { label.position.x -= labelSpeed }
        if keyState.right { label.position.x += labelSpeed }
        if keyState.down { label.position.y -= labelSpeed }
        if keyState.up { label.position.y += labelSpeed }
    } // update
    
} // GameScene
