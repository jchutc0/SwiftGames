//
//  CGPoint.swift
//  SwiftAdventure
//
//  Created by jchutc0 on 10/28/23.
//

import Foundation

extension CGPoint {
    func translate(x: CGFloat, y: CGFloat) -> CGPoint {
        CGPoint(x: self.x + x, y: self.y + y)
    } // translate
    
    func translate(_ p: CGPoint) -> CGPoint {
        CGPoint(x: self.x + p.x, y: self.y + p.y)
    } // translate
} // CGPoint
