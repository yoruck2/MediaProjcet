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
    
//    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
    }
}

struct ResultDTO: Codable {
    let adult: Bool
    let backdrop_path: String?
    let genre_ids: [Int]
    let id: Int
    let original_language, original_title, overview: String
    let popularity: Double
    let poster_path: String?
    let release_date, title: String
    let video: Bool
    let vote_average: Double
    let vote_count: Int
}
