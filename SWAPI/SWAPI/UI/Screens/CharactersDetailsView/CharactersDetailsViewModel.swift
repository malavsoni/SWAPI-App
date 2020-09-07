//
//  CharactersDetailsViewModel.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation

/// CharactersDetails ViewModel
class CharactersDetailsViewModel:ObservableObject, SWErrorHandling {
    
    @Published private var model:Character
    @Published var isLoading:Bool = false
    
    // SWErrorHandling
    @Published var isErrorOccured: Bool = false
    @Published var errorMessage: String = ""
    
    /// Init with character model
    /// - Parameter model: character model
    init(withModel model:Character) {
        self.model = model
    }
}

// MARK: - Accesible Variables
extension CharactersDetailsViewModel {
    var name:String {
        self.model.name
    }
    var birthYear:String {
        self.model.birthYear
    }
    var height:String {
        self.model.height
    }
    var mass:String {
        self.model.mass
    }
    var hairColor:String {
        self.model.hairColor.capitalized
    }
    var eyeColor:String {
        self.model.eyeColor.capitalized
    }
    var skinColor:String {
        self.model.skinColor.capitalized
    }
    var gender:String {
        self.model.gender.capitalized
    }
    var films:[Film] {
        self.model.films
    }
}

// MARK: - Accesible Methods
extension CharactersDetailsViewModel {
    
    /// Fetch films in background
    /// - Parameter url: URL of Film
    /// - Returns: Bool indicating API Call initiated orr ignored
    @discardableResult
    func fetchFilm(fromUrl url:String? = nil) -> Bool {
        debugPrint("Fetching Film")
        guard isLoading == false else {
            return false
        }
        if let url = url {
            self.isLoading = true
            APIClient.shared.fetchFilm(fromURL: url, completion: self.handleFilmResponse(result:))
        } else if let lastUrl = self.model.strFilmsUrl.last {
            self.isLoading = true
            APIClient.shared.fetchFilm(fromURL: lastUrl, completion: self.handleFilmResponse(result:))
        } else {
            return false
        }
        
        return true
    }
}

// MARK: - Private Helpers
private extension CharactersDetailsViewModel {
    /// Handle the response from server
    /// - Parameter result: Contains Film Model or Error if API Call fails
    func handleFilmResponse(result:Result<Film,Error>) {
        switch result {
        case .success(let film):
            
            // Insert Fetched Film In Array
            self.model.films.insert(film, at: 0)
            
            // Remove Last URL from List
            self.model.strFilmsUrl.removeLast()
            
            // Set Loading Status to False
            self.isLoading = false
            
            // Load Next Film if available
            if let lastUrl = self.model.strFilmsUrl.last {
                self.fetchFilm(fromUrl: lastUrl)
            }
        case .failure(let error):
            self.isLoading = false
            if error.localizedDescription.count > 0 {
                self.errorMessage = error.localizedDescription
                self.isErrorOccured = true
            }
        }
    }
}

// MARK: - TestCase Helpers
extension CharactersDetailsViewModel {
    var totalFilms:Int {
        self.model.strFilmsUrl.count
    }
}
