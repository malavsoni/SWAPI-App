//
//  CharactersListViewModel.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation

class CharactersListViewModel:ObservableObject {
    @Published var characters:[Character] = []
    @Published var isLoading:Bool = false
    private var nextPageUrl:String?
    init() {
        
    }
}

extension CharactersListViewModel {
    func loadCharacters(fromLastItem item:Character? = nil) {
        guard isLoading == false else {
            return
        }
        if let lastItem = characters.last, let item = item, let nextPageUrl = nextPageUrl {
            guard lastItem == item else {
                return
            }
            self.setLoadingStatus(true)
            APIClient.shared.fetchCharacters(fromURL: nextPageUrl, completion: self.handlePeopleResponse(result:))
        } else {
            self.setLoadingStatus(true)
            APIClient.shared.fetchCharacters(completion: self.handlePeopleResponse(result:))
        }
    }
}

private extension CharactersListViewModel {
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
            debugPrint("API Failure : \(error.localizedDescription)")
            self.setLoadingStatus(false)
        }
    }
    
    func setLoadingStatus(_ status:Bool) {
        self.isLoading = status
    }
}
