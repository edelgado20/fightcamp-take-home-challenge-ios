//
//  Layout.swift
//  FightCamp-Homework
//
//  Created by Alexandre Marcotte on 6/17/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import UIKit

// MARK: - Layout

extension CGFloat {

    /// CTA button height
    public static var buttonHeight: CGFloat { 40 }
    /// CTA button corner radius
    public static var buttonRadius: CGFloat { 4 }
    /// Radius of the outer corners of the package view
    public static var packageRadius: CGFloat { 12 }
    /// Spacing between each UI elements in the package view
    public static var packageSpacing: CGFloat { 24 }
    /// Spacing between each thumbnail image
    public static var thumbnailSpacing: CGFloat { 4 }
    /// Height of the `primary` thumbnail image
    public static var thumbnailHeight: CGFloat { 240 }
    /// Corner radius of `primary` and `secondary` thumbnail images
    public static var thumbnailRadius: CGFloat { 8 }
    /// Corner border width of secondary thumbnail images
    public static var thumbnailBorderWidth: CGFloat { 4 }
    /// Line height ratio between text with multiple lines
    public static var lineHeightMultiple: CGFloat { 1.3 }
}

extension UIView {
    
    /// Method that helps create anchors and constraints
    func anchor(top: NSLayoutYAxisAnchor?, left: NSLayoutXAxisAnchor?, bottom: NSLayoutYAxisAnchor?, right: NSLayoutXAxisAnchor?, paddingTop: CGFloat, paddingLeft: CGFloat, paddingBottom: CGFloat, paddingRight: CGFloat, width: CGFloat, height: CGFloat, enableInsets: Bool) {
        
        var topInset = CGFloat(0)
        var bottomInset = CGFloat(0)
        
        if #available(iOS 11, *), enableInsets {
            let insets = self.safeAreaInsets
            topInset = insets.top
            bottomInset = insets.bottom
            
            print("Top: \(topInset)")
            print("Bottom: \(bottomInset)")
        }
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            self.topAnchor.constraint(equalTo: top, constant: paddingTop+topInset).isActive = true
        }
        if let left = left {
            self.leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom-bottomInset).isActive = true
        }
        if height != 0 {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
        if width != 0 {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
    }
}
