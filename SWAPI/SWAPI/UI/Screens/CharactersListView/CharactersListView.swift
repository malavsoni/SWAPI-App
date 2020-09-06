//
//  CharactersListView.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import SwiftUI

struct CharactersListView: View {
    @ObservedObject var viewModel = CharactersListViewModel()
    var body: some View {
        NavigationView {
            List {
                ForEach(self.viewModel.characters, id: \.self) { people in
                    NavigationLink(destination: CharactersDetailsView(character: people)) {
                        Text(people.name)
                    }
                    .onAppear {
                        self.viewModel.loadCharacters(fromLastItem: people)
                    }
                }
            }
        .navigationBarTitle("Star Wars Characters")
        }.onAppear {
            if self.viewModel.characters.count == 0 {
                self.viewModel.loadCharacters()
            }
        }.loadingIndicator(self.$viewModel.isLoading)
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
