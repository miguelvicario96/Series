//
//  Serie.swift
//  Series
//
//  Created by Miguel Vicario on 2/17/19.
//  Copyright © 2019 Miguel Vicario. All rights reserved.
//

import Foundation

struct Serie: Codable {
    
    let id: Int
    let imageURL: ImageURL?
    let name: String
    let summary: String
    let schedule: Schedule
    let network: Network?
    let officialSite: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "image"
        case name
        case summary
        case network
        case schedule
        case officialSite
    } 
}

struct Network: Codable {
    let name: String
}

struct ImageURL: Codable {
    let medium: String
    let original: String
}

struct Schedule: Codable {
    let days: [String]
    let time: String
}

struct SerieIntermediate: Codable {
    let serie: Serie
    enum CodingKeys: String, CodingKey {
        case serie = "show"
    }
}
