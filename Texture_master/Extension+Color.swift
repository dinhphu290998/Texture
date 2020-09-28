//
//  Extension+Color.swift
//  Texture_master
//
//  Created by NDPhu on 9/22/20.
//  Copyright © 2020 ios. All rights reserved.
//

import UIKit

public extension UIColor {
    @objc convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    @objc convenience init(r: Int, g: Int, b: Int, a: Int) {
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(a) / 255.0)
    }
    
    @objc static func rgb(_ rgb: Int) -> UIColor {
        return UIColor(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    @objc static func rgba(_ rgba: Int) -> UIColor { //A-R-G-B
        return UIColor(
            r: (rgba >> 16) & 0xFF,
            g: (rgba >> 8) & 0xFF,
            b: rgba & 0xFF,
            a: (rgba >> 24) & 0xFF
        )
    }
    
    @objc static func color(hexString: String?) -> UIColor {
        guard let hexString = hexString else {
            return .black
        }
        var rgbaValue: UInt64 = 0
        let scanner = Scanner(string: hexString)
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        scanner.scanHexInt64(&rgbaValue)
        return hexString.count > 7 ? UIColor.rgba(Int(rgbaValue)) : UIColor.rgb(Int(rgbaValue))
    }
}

public extension UIColor {
    func darker(by percent: CGFloat = 0.2) -> UIColor {
        var h: CGFloat = 0,
        s: CGFloat = 0,
        b: CGFloat = 0,
        a: CGFloat = 0
        
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }
    
        return UIColor(hue: h,
                       saturation: s,
                       brightness: b * (1 - percent),
                       alpha: a)
    }
    
    func lighter(by percent: CGFloat = 0.2) -> UIColor {
        var h: CGFloat = 0,
        s: CGFloat = 0,
        b: CGFloat = 0,
        a: CGFloat = 0
        
        guard getHue(&h, saturation: &s, brightness: &b, alpha: &a) else { return self }
        
        return UIColor(hue: h,
                       saturation: s,
                       brightness: b * (1 + percent) <= 1 ? b * (1 + percent) : 1,
                       alpha: a)
    }
}

