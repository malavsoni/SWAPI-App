//
//  APIClient.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation
import Alamofire

class APIClient: NSObject {
    /// Singleton Instance
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
    func fetchCharacters(fromURL url:String = APIRouter.getCharacters.endpoint, completion:((Result<Response<Character>,Error>) -> Void)?) {
        self.request(url, successClass: Response.self, onCompletion: completion)
    }
    
    func fetchFilm(fromURL url:String, completion:((Result<Film,Error>) -> Void)?) {
        self.request(url, successClass: Film.self, onCompletion: completion)
    }
}
