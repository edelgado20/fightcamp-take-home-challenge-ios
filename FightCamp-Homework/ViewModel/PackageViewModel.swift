//
//  PackageViewModel.swift
//  FightCamp-Homework
//
//  Created by Edgar Delgado on 12/7/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation
import UIKit

class PackageViewModel {
    
    let package: Package
    
    let title: String
    let description: String
    let thumbnailUrls: [String]
    let included: [String]
    let excluded: [String]?
    let payment: String
    let price: Int
    let action: String
    var imageSelected: String
    
    init(withPackage package: Package) {
        self.package = package
        
        self.title = package.title
        self.description = package.desc
        self.thumbnailUrls = package.thumbnailUrls
        self.included = package.included
        self.excluded = package.excluded
        self.payment = package.payment
        self.price = package.price
        self.action = package.action
        self.imageSelected = package.thumbnailUrls[0]
    }

    func createStrykeThroughString(with name: String) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: name)
        attributedString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSMakeRange(0, attributedString.length))
        return attributedString
    }
    
    /// Returns a UIImage from the url string
    func createImage(from url: String) -> UIImage? {
        if let url = URL(string: url) {
            if let data = try? Data(contentsOf: url) {
                return UIImage(data: data)
            }
        }
        return nil
    }
}
