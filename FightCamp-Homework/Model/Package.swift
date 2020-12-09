//
//  Package.swift
//  FightCamp-Homework
//
//  Created by Edgar Delgado on 12/4/20.
//  Copyright © 2020 Alexandre Marcotte. All rights reserved.
//

import Foundation

struct Package: Codable {
    let title, desc: String
    let thumbnailUrls: [String]
    let included: [String]
    let excluded: [String]?
    let payment: String
    let price: Int
    let action: String
    let headline: String?

    enum CodingKeys: String, CodingKey {
        case title, desc
        case thumbnailUrls = "thumbnail_urls"
        case included, excluded, payment, price, action, headline
    }
}

/// Retreives the packages from the JSON file
func loadJSON() -> [Package]? {
    let decoder = JSONDecoder()
    
    guard let url = Bundle.main.url(forResource: "packages", withExtension: "json"),
        let data = try? Data(contentsOf: url),
        let packages = try? decoder.decode([Package].self, from: data)
    else {
        return nil
    }
    
    return packages
}
