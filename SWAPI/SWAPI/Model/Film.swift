//
//  Film.swift
//  SWAPI
//
//  Created by Malav Soni on 06/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import Foundation

// MARK: - Film
struct Film: Codable, Hashable, Identifiable {
    let id = UUID()
    let title: String
    let episodeID: Int
    let openingCrawl, director, producer, releaseDate: String
    var charactersUrl: [String]
    let planets, starships, vehicles: [String]
    var characters:[Character] = []
    let species: [String]
    let created, edited: String
    let url: String

    enum CodingKeys: String, CodingKey {
        case title
        case episodeID = "episode_id"
        case openingCrawl = "opening_crawl"
        case director, producer
        case releaseDate = "release_date"
        case charactersUrl = "characters"
        case planets, starships, vehicles, species, created, edited, url
    }
}
