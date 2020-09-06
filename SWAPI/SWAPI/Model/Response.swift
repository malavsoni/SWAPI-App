//
//  Response.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation

struct Response: Codable {
    let count: Int
    let next, previous: String?
    let peoples: [Character]
    
    enum CodingKeys: String, CodingKey {
        case count,next,previous
        case peoples = "results"
    }
}
