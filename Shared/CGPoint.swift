//
//  CGPoint.swift
//
//  Created by jchutc0 on 10/28/23.
//

import Foundation

extension CGPoint {
    
    /// translate
    ///
    /// creates  a CG point based on another CGPoint moved by a
    /// certain amount in the x and y directions
    /// takes:
    /// x and y: amounts to move the new CGPoint
    func translate(x: CGFloat, y: CGFloat) -> CGPoint {
        CGPoint(x: self.x + x, y: self.y + y)
    } // translate
    
    /// translate
    ///
    /// creates  a CG point based on another CGPoint moved by a
    /// certain amount in the x and y directions
    /// takes:
    /// p: a CGPoint composed of x and y values to move the new CGPoint
    func translate(_ p: CGPoint) -> CGPoint {
        CGPoint(x: self.x + p.x, y: self.y + p.y)
    } // translate
    
} // CGPoint
