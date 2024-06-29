//
//  RecommendationDTO.swift
//  MediaProjcet
//
//  Created by dopamint on 6/25/24.
//

import Foundation

struct MovieSuggestion: Decodable {
    let results: [MovieSuggestion.Result]?
    
    struct Result: Decodable {
        let posterPath: String?
        
        enum CodingKeys: String, CodingKey {
            case posterPath = "poster_path"
        }
    }
}
