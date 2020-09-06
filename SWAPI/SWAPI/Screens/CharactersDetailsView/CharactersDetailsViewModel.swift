//
//  CharactersDetailsViewModel.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation

class CharactersDetailsViewModel:ObservableObject {
    @Published var model:Character
    
    init(withModel model:Character) {
        self.model = model
    }
}
