//
//  Movie.swift
//  ThingsApp
//
//  Created by Naveen Kumawat on 31/07/22.
//

import Foundation

struct MoviesArray: Codable {
    var results: [Movie]?
    enum CodingKeys: String, CodingKey {
        case results = "results"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        results = try values.decodeIfPresent([Movie].self, forKey: .results)
    }
}

struct Movie: Identifiable, Codable {
    var id: Int64
    var title: String
}
