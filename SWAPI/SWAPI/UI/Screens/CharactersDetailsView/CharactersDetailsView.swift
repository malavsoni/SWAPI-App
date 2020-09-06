//
//  CharactersDetailsView.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import SwiftUI

struct CharactersDetailsView: View {
    
    @ObservedObject private var viewModel:CharactersDetailsViewModel
    
    init(character:Character) {
        self.viewModel = CharactersDetailsViewModel(withModel: character)
    }
    
    var body: some View {
        List {
            Section(header: Text("Details").fontWeight(.bold)) {
                KeyValueHStack(key: "Birth Year", value: self.viewModel.birthYear)
            }
            
            Section(header: Text("Physical Attributes").fontWeight(.bold)) {
                KeyValueHStack(key: "Height", value: self.viewModel.height)
                KeyValueHStack(key: "Mass", value: self.viewModel.mass)
                KeyValueHStack(key: "Hair Color", value: self.viewModel.hairColor)
                KeyValueHStack(key: "Skin Color", value: self.viewModel.skinColor)
                KeyValueHStack(key: "Eye Color", value: self.viewModel.eyeColor)
                KeyValueHStack(key: "Gender", value: self.viewModel.gender)
            }
            
            Section(header: Text("Films").fontWeight(.bold)) {
                ForEach(self.viewModel.films) { film in
                    KeyValueVStack(key: film.title, value: "Opening Crawl: \(film.openingCrawl.count)")
                        .animation(.easeInOut)
                }
            }
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(self.viewModel.name)
        .onAppear {
            self.viewModel.fetchFilm()
        }
    }
}

struct CharactersDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersDetailsView(character: Character())
    }
}
