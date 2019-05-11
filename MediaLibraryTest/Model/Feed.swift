//
//  Feed.swift
//  MediaLibraryTest
//
//  Created by Rish on 5/11/19.
//  Copyright © 2019 Rishil. All rights reserved.
//

import Foundation

struct FeedRoot : Codable {
    
    let feed : Feed?
    
    enum CodingKeys: String, CodingKey {
        case feed = "feed"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        feed = try values.decodeIfPresent(Feed.self, forKey: .feed)
    }
    
}


struct Feed : Codable {
    
    
    let results : [Result]?
    
    
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([Result].self, forKey: .results)
    }
    
}

struct Result : Codable {
    
    let artistId : String?
    let artistName : String?
    let artistUrl : String?
    let artworkUrl100 : String?
    let contentAdvisoryRating : String?
    let copyright : String?
    let genres : [Genre]?
    let id : String?
    let kind : String?
    let name : String?
    let releaseDate : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        case artistId = "artistId"
        case artistName = "artistName"
        case artistUrl = "artistUrl"
        case artworkUrl100 = "artworkUrl100"
        case contentAdvisoryRating = "contentAdvisoryRating"
        case copyright = "copyright"
        case genres = "genres"
        case id = "id"
        case kind = "kind"
        case name = "name"
        case releaseDate = "releaseDate"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        artistId = try values.decodeIfPresent(String.self, forKey: .artistId)
        artistName = try values.decodeIfPresent(String.self, forKey: .artistName)
        artistUrl = try values.decodeIfPresent(String.self, forKey: .artistUrl)
        artworkUrl100 = try values.decodeIfPresent(String.self, forKey: .artworkUrl100)
        contentAdvisoryRating = try values.decodeIfPresent(String.self, forKey: .contentAdvisoryRating)
        copyright = try values.decodeIfPresent(String.self, forKey: .copyright)
        genres = try values.decodeIfPresent([Genre].self, forKey: .genres)
        id = try values.decodeIfPresent(String.self, forKey: .id)
        kind = try values.decodeIfPresent(String.self, forKey: .kind)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        releaseDate = try values.decodeIfPresent(String.self, forKey: .releaseDate)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
}


struct Genre : Codable {
    
    let genreId : String?
    let name : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        case genreId = "genreId"
        case name = "name"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        genreId = try values.decodeIfPresent(String.self, forKey: .genreId)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
}
