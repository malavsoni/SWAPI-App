//
//  APIRouter.swift
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
    
    static let baseUrl:String = "https://swapi.dev/api/"
    
    var endpoint:String {
        switch self {
        case .getCharacters:
            return "\(APIRouter.baseUrl)people/"
        case .character(id: let userId):
            return "\(APIRouter.getCharacters.endpoint)\(userId)/"
        case .film(id: let filmId):
            return "\(APIRouter.baseUrl)film/\(filmId)"
        case.url(url: let url):
            return url
        }
    }
}

enum SWError: LocalizedError {
    case badRequest
    case failedToParseResponse
    case internetNotAvailable
    
    var localizedDescription: String {
        switch self {
        case .badRequest:
            return "Bad Request"
        case .failedToParseResponse:
            return "Unexpected values found in response"
        case .internetNotAvailable:
            return "No internet connection found."
        }
    }
}

protocol SWErrorHandling {
    var isErrorOccured:Bool { get set }
    var errorMessage:String { get set }
}
