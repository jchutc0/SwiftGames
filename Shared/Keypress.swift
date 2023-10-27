//
//  Keypress.swift
//  FearTheDead
//
//  Created by jchutc0 on 10/22/23.
//

import SpriteKit

class Keypress {
    
    enum WatchList {
        case arrowKeys
    }
    
    var arrowKeys: UInt8?
    
    let bitmaskLeftArrow    :UInt8 = 0b1
    let bitmaskRightArrow   :UInt8 = 0b10
    let bitmaskDownArrow    :UInt8 = 0b100
    let bitmaskUpArrow      :UInt8 = 0b1000

    init(watchList: [WatchList]) {
        if watchList.contains(.arrowKeys) { arrowKeys = 0x0 }
    } // init
    
    func keyDown(event: NSEvent) {
        if arrowKeys != nil {
            switch event.keyCode {
            case 0x7B: arrowKeys! |= bitmaskLeftArrow
            case 0x7C: arrowKeys! |= bitmaskRightArrow
            case 0x7D: arrowKeys! |= bitmaskDownArrow
            case 0x7E: arrowKeys! |= bitmaskUpArrow
            default: break
            } // switch
        } // if arrowKeys
    } // keyDown
    
    func keyUp(event: NSEvent) {
        if arrowKeys != nil {
            switch event.keyCode {
            case 0x7B: arrowKeys! &= ~bitmaskLeftArrow
            case 0x7C: arrowKeys! &= ~bitmaskRightArrow
            case 0x7D: arrowKeys! &= ~bitmaskDownArrow
            case 0x7E: arrowKeys! &= ~bitmaskUpArrow
            default: break
            } // switch
        } // if arrowKeys
    } // keyUp
    
    var arrowPressed: Bool { arrowMask != 0 }
    var leftArrow: Bool { arrowMask & bitmaskLeftArrow != 0 }
    var rightArrow: Bool { arrowMask & bitmaskRightArrow != 0 }
    var downArrow: Bool { arrowMask & bitmaskDownArrow != 0 }
    var upArrow: Bool { arrowMask & bitmaskUpArrow != 0 }
    var arrowMask: UInt8 { arrowKeys ?? 0 }
    
    static func arrowKeys() -> Keypress { Keypress(watchList: [.arrowKeys]) }
    
} // Keypress
