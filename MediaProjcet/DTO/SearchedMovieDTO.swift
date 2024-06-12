//
//  searchedMovieDTO.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import Foundation

struct SearchedMovieDTO: Codable {
    let page: Int
    let results: [ResultDTO]
    let total_pages, total_results: Int
}

struct ResultDTO: Codable {
    
    let posterPath: String?
    let backdropPath: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
    }
//    let adult: Bool
//    let genre_ids: [Int]
//    let id: Int
//    let original_language, original_title, overview: String
//    let popularity: Double
//    let release_date, title: String
//    let video: Bool
//    let vote_average: Double
//    let vote_count: Int
}
