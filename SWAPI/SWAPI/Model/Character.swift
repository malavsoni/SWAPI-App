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
    var name, height, mass, hairColor: String
    var gender, skinColor, eyeColor, birthYear: String
    var homeworld: String
    var strFilmsUrl, species, vehicles, starships: [String]
    var films:[Film] = []
    var created, edited: String
    var url: String

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
        self.name = ""
        self.height = ""
        self.mass = ""
        self.hairColor = ""
        self.gender = ""
        self.skinColor = ""
        self.eyeColor = ""
        self.birthYear = ""
        self.homeworld = ""
        self.strFilmsUrl = []
        self.species = []
        self.vehicles = []
        self.starships = []
        self.created = ""
        self.edited = ""
        self.url = ""
    }
    
    static func sample() -> Character {
        var sample =  Character()
        sample.name = "Luke Skywalker"
        sample.height = "172"
        sample.mass = "77"
        sample.hairColor = "black"
        sample.gender = "male"
        sample.skinColor = "white"
        sample.eyeColor = "Black"
        sample.birthYear = "19BBY"
        sample.homeworld = "https://swapi.dev/api/planets/1/"
        sample.strFilmsUrl = [
            "https://swapi.dev/api/films/1/",
            "https://swapi.dev/api/films/2/",
            "https://swapi.dev/api/films/3/",
            "https://swapi.dev/api/films/4/"
        ]
        sample.species = [
            "https://swapi.dev/api/species/1/"
        ]
        sample.vehicles = [
            "https://swapi.dev/api/vehicles/14/"
        ]
        sample.starships = [
            "https://swapi.dev/api/starships/12/"
        ]
        sample.created = "2014-12-09T13:50:51.644000Z"
        sample.edited = "2014-12-20T21:17:56.891000Z"
        sample.url = "https://swapi.dev/api/people/1/"
        return sample
    }
}
