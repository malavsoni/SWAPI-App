//
//  People.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation

// MARK: - People
struct Character: Codable, Hashable, Identifiable {
    let id = UUID()
    let name, height, mass, hairColor: String
    let gender, skinColor, eyeColor, birthYear: String
    let homeworld: String
    var strFilmsUrl, species, vehicles, starships: [String]
    var films:[Film] = []
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case name, height, mass
        case hairColor = "hair_color"
        case skinColor = "skin_color"
        case eyeColor = "eye_color"
        case birthYear = "birth_year"
        case strFilmsUrl = "films"
        case gender, homeworld, species, vehicles, starships, created, edited, url
    }
    
    init() {
        self.name = "Luke Skywalker"
        self.height = "172"
        self.mass = "77"
        self.hairColor = "black"
        self.gender = "male"
        self.skinColor = "white"
        self.eyeColor = "Black"
        self.birthYear = "19BBY"
        self.homeworld = "https://swapi.dev/api/planets/1/"
        self.strFilmsUrl = [
            "https://swapi.dev/api/films/2/",
            "https://swapi.dev/api/films/6/"
        ]
        self.species = [
            "https://swapi.dev/api/species/1/"
        ]
        self.vehicles = [
            "https://swapi.dev/api/vehicles/14/"
        ]
        self.starships = [
            "https://swapi.dev/api/starships/12/"
        ]
        self.created = "2014-12-09T13:50:51.644000Z"
        self.edited = "2014-12-20T21:17:56.891000Z"
        self.url = "https://swapi.dev/api/people/1/"
    }
}
