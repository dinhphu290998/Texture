//
//  Extension+ASDisplay.swift
//  Texture_master
//
//  Created by NDPhu on 9/22/20.
//  Copyright © 2020 ios. All rights reserved.
//

import UIKit
import AsyncDisplayKit

extension ASDisplayNode {
    public func corner(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: .square(radius))
        let shape = CAShapeLayer()
        shape.path = path.cgPath
        
        DispatchQueue.main.async {
            self.layer.mask = shape
        }
    }
}

public extension CGSize {
    static func square(_ edge: CGFloat) -> CGSize {
        return CGSize(width: edge, height: edge)
    }
    
    func scaled(_ factor: CGFloat) -> CGSize {
        return CGSize(
            width: width * factor,
            height: height * factor
        )
    }
    
    var aspectRatio: CGFloat {
        if self.height == 0 { return CGFloat.infinity }
        return width / height
    }
}
