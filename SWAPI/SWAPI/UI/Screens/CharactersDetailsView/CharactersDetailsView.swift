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
            Section(header: header("Details")) {
                KeyValueHStack(key: "Birth Year", value: self.viewModel.birthYear)
            }.accessibility(identifier: "Details")
            
            Section(header: header("Physical Attributes")) {
                KeyValueHStack(key: "Height", value: self.viewModel.height)
                KeyValueHStack(key: "Mass", value: self.viewModel.mass)
                KeyValueHStack(key: "Hair Color", value: self.viewModel.hairColor)
                KeyValueHStack(key: "Skin Color", value: self.viewModel.skinColor)
                KeyValueHStack(key: "Eye Color", value: self.viewModel.eyeColor)
                KeyValueHStack(key: "Gender", value: self.viewModel.gender)
            }.accessibility(identifier: "Physical Attributes")
            
            Section(header: header("Films")) {
                ForEach(self.viewModel.films) { film in
                    KeyValueVStack(key: film.title, value: "Opening Crawl: \(film.openingCrawl.count)")
                }
            }.accessibility(identifier: "Films")
        }
        .listStyle(GroupedListStyle())
        .navigationBarTitle(self.viewModel.name)
        .showAlert(isPresented: self.$viewModel.isErrorOccured, message: self.viewModel.errorMessage)
        .onAppear {
            self.viewModel.fetchFilm()
        }
        .accessibility(identifier: "CharactersDetailsView")
    }
    
    func header(_ text:String) -> some View {
        return Text(text).fontWeight(.bold).foregroundColor(.blue)
    }
}

struct CharactersDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersDetailsView(character: Character.sample())
    }
}
