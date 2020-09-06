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
                Section {
                    KeyValueHStack(key: "Birth Year", value: self.viewModel.model.birthYear)
                }
                
                Section(header: Text("Physical Attributes").fontWeight(.bold)) {
                    KeyValueHStack(key: "Height", value: self.viewModel.model.height)
                    KeyValueHStack(key: "Mass", value: self.viewModel.model.mass)
                    KeyValueHStack(key: "Hair Color", value: self.viewModel.model.hairColor.capitalized)
                    KeyValueHStack(key: "Skin Color", value: self.viewModel.model.skinColor.capitalized)
                    KeyValueHStack(key: "Eye Color", value: self.viewModel.model.eyeColor.capitalized)
                    KeyValueHStack(key: "Gender", value: self.viewModel.model.gender.capitalized)
                }
            }
            .listStyle(GroupedListStyle())
            .navigationBarTitle(self.viewModel.model.name)
    }
}

struct KeyValueHStack:View {
    let key:String
    let value:String
    var body: some View {
        HStack {
            Text(key)
            Spacer()
            Text(value)
        }
    }
}

struct CharactersDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersDetailsView(character: Character())
    }
}
