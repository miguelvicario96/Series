//
//  Episode.swift
//  Series
//
//  Created by Miguel Vicario on 2/17/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import Foundation

struct Episode: Codable {
    
    let name: String
    let summary: String?
    let imageURL: ImageURL?
    let number: Int
    let season: Int
    
    enum CodingKeys: String, CodingKey {
        case name
        case summary
        case imageURL = "image"
        case number
        case season
    }
}
