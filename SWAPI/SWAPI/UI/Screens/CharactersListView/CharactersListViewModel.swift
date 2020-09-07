//
//  CharactersListViewModel.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation

/// CharactersList ViewModel
class CharactersListViewModel:ObservableObject, SWErrorHandling {
    @Published var characters:[Character] = []
    @Published var isLoading:Bool = false
    
    // SWErrorHandling
    @Published var isErrorOccured: Bool = false
    @Published var errorMessage: String = ""
    
    private var nextPageUrl:String?
    
    init() {
        
    }
}

// MARK: - Accesible Methods
extension CharactersListViewModel {
    /// Load Characters
    /// - Parameter item: Last Character Object
    /// - Returns: Bool indicating API call initiated or ignored
    @discardableResult
    func loadCharacters(fromLastItem item:Character? = nil) -> Bool {
        guard isLoading == false else {
            return false
        }
        // When User Reaches Last Row, Load Further Content
        if let lastItem = characters.last, let item = item, let nextPageUrl = nextPageUrl {
            guard lastItem == item else {
                return false
            }
            self.setLoadingStatus(true)
            APIClient.shared.fetchCharacters(fromURL: nextPageUrl, completion: self.handlePeopleResponse(result:))
        } else {
            self.setLoadingStatus(true)
            
            // If data and next page url is available then load next page
            if let nextPageUrl = self.nextPageUrl, self.characters.count > 0 {
                APIClient.shared.fetchCharacters(fromURL: nextPageUrl, completion: self.handlePeopleResponse(result:))
            } else {
                // Else load first page
                APIClient.shared.fetchCharacters(completion: self.handlePeopleResponse(result:))
            }
        }
        return true
    }
}

// MARK: - Private Helpers
private extension CharactersListViewModel {
    /// Handle response of Characters API
    /// - Parameter result: Contains Characters Or Error Incase of API Failure
    func handlePeopleResponse(result:Result<Response<Character>,Error>) {
        switch result {
        case .success(let response):
            self.nextPageUrl = response.next
            if self.characters.count == 0 {
                self.characters = response.results
            } else {
                self.characters.append(contentsOf: response.results)
            }
            self.setLoadingStatus(false)
        case .failure(let error):
            self.setLoadingStatus(false)
            if error.localizedDescription.count > 0 {
                self.errorMessage = error.localizedDescription
                self.isErrorOccured = true
            }
        }
    }
    
    func setLoadingStatus(_ status:Bool) {
        self.isLoading = status
    }
}

// MARK: - TestCase Helpers
extension CharactersListViewModel {
    var nextPageUrlValue:String {
        self.nextPageUrl ?? ""
    }
}
