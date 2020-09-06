//
//  APIClient.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation
import Alamofire

enum APIRouter {
    case getCharacters
    case character(id:String)
    case film(id:String)
    case url(url:String)
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

class APIClient: NSObject {
    static let shared:APIClient = APIClient()
    
    static var isInternetAvailable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    func request<Success: Decodable>(_ apiUrl: String, method: HTTPMethod = .get, parameters: Parameters = [:], successClass: Success.Type, onCompletion completion: ((Result<Success, Error>) -> Void)?) {
        
        // Check for internet connection
        guard APIClient.isInternetAvailable else {
            completion?(.failure(SWError.internetNotAvailable))
            return
        }
        
        guard let serverURL = URL.init(string: apiUrl) else {
            completion?(.failure(SWError.badRequest))
            return
        }
        
        AF.request(serverURL, method: method, parameters: parameters).responseJSON { (dataResponse) in
            guard dataResponse.error == nil else {
                completion?(.failure(dataResponse.error!))
                return
            }
            
        }
    }
}
