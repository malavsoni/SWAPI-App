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
            Group {
                if self.viewModel.isInternetAvailable {
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
                } else {
                    VStack {
                        NoInternetConnectionView(onRetry: {
                            self.viewModel.loadCharacters()
                        })
                    }
                }
            }
            .navigationBarTitle("Star Wars Characters")
        }
        .onAppear {
            if self.viewModel.characters.count == 0 {
                self.viewModel.loadCharacters()
            }
        }
        .loadingIndicator(self.$viewModel.isLoading)
        .showAlert(isPresented: self.$viewModel.isErrorOccured, message: self.viewModel.errorMessage)
    }
}

struct CharactersListView_Previews: PreviewProvider {
    static var previews: some View {
        CharactersListView()
    }
}
