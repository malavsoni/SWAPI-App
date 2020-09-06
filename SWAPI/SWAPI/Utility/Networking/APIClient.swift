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

class APIClient: NSObject {
    static let shared:APIClient = APIClient()
    
    /// Check for internet connection status
    static var isInternetAvailable: Bool {
        return NetworkReachabilityManager()?.isReachable ?? false
    }
    
    /// API Call Request
    /// - Parameters:
    ///   - apiUrl: API Url
    ///   - method: API Method
    ///   - parameters: Parameters
    ///   - successClass: Decodable Class
    ///   - completion: Completion Handler
    private func request<Success: Decodable>(_ apiUrl: String, method: HTTPMethod = .get, parameters: Parameters = [:], successClass: Success.Type, onCompletion completion: ((Result<Success, Error>) -> Void)?) {
        
        // Check for internet connection
        guard APIClient.isInternetAvailable else {
            completion?(.failure(SWError.internetNotAvailable))
            return
        }
        
        // Validate URL
        guard let serverURL = URL.init(string: apiUrl) else {
            completion?(.failure(SWError.badRequest))
            return
        }
        
        // Make Request
        AF.request(serverURL, method: method, parameters: parameters).responseJSON { (dataResponse) in
            guard dataResponse.error == nil else {
                completion?(.failure(dataResponse.error!))
                return
            }
            
            // Parse Response
            if let data = dataResponse.data {
                do {
                    #if DEBUG
                    debugPrint("API Response", String.init(data: data, encoding: .utf8) ?? "")
                    #endif
                    let decoder = JSONDecoder()
                    completion?(.success(try decoder.decode(successClass.self, from: data)))
                } catch let error {
                    #if DEBUG
                    debugPrint("Failed to parse response with Error : \(error)")
                    debugPrint("Response : \(String(describing: String.init(data: dataResponse.data ?? Data(), encoding: .utf8)))")
                    #endif
                    completion?(.failure(SWError.failedToParseResponse))
                }
            } else {
                completion?(.failure(SWError.badRequest))
            }
        }
    }
}

extension APIClient {
    func loadCharactersList(withURL url:String = APIRouter.getCharacters.endpoint, completion:((Result<Response,Error>) -> Void)?) {
        self.request(url, successClass: Response.self, onCompletion: completion)
    }
}
