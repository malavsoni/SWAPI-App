//
//  APIClient.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation

enum APIRouter {
    case getCharacters
    case character(id:String)
    case film(id:String)
    case url(url:String)
}


