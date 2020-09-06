//
//  CharactersDetailsViewModel.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation

class CharactersDetailsViewModel:ObservableObject {
    
    @Published private var model:Character
    @Published var isLoading:Bool = false
    
    init(withModel model:Character) {
        self.model = model
    }
}

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

extension CharactersDetailsViewModel {
    func fetchFilm(fromUrl url:String? = nil) {
        debugPrint("Fetching Film")
        guard isLoading == false else {
            return
        }
        if let url = url {
            self.isLoading = true
            APIClient.shared.fetchFilm(fromURL: url, completion: self.handleFilmResponse(result:))
        } else if let lastUrl = self.model.strFilmsUrl.last {
            self.isLoading = true
            APIClient.shared.fetchFilm(fromURL: lastUrl, completion: self.handleFilmResponse(result:))
        }
    }
    
    private func handleFilmResponse(result:Result<Film,Error>) {
        switch result {
        case .success(let film):
            if self.model.films.count == 0 {
                self.model.films = [film]
            } else {
                self.model.films.insert(film, at: 0)
            }
            self.model.strFilmsUrl.removeLast()
            self.isLoading = false
            if let lastUrl = self.model.strFilmsUrl.last {
                self.fetchFilm(fromUrl: lastUrl)
            }
        case .failure(let error):
            self.isLoading = false
            debugPrint("Failed to fetch films : \(error)")
            
        }
    }
}
