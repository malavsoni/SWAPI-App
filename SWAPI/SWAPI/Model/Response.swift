//
//  Response.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation

struct Response<ResultType:Decodable>: Decodable {
    let count: Int
    let next, previous: String?
    let results: [ResultType]
    
    enum CodingKeys: String, CodingKey {
        case count,next,previous,results
    }
}
