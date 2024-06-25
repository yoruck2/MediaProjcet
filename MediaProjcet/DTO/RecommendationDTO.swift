//
//  RecommendationDTO.swift
//  MediaProjcet
//
//  Created by dopamint on 6/25/24.
//

import Foundation

struct RecommendationDTO: Codable {
    let page: Int
    let results: [RecommendationResultDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct RecommendationResultDTO: Codable {
    let posterPath: String
//    let backdropPath: String
//    let id: Int
//    let originalTitle: String
//    let overview: String
//    let mediaType: String
//    let adult: Bool
//    let title, originalLanguage: String
//    let genreIDS: [Int]
//    let popularity: Double
//    let releaseDate: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
//        case backdropPath = "backdrop_path"
//        case id
//        case originalTitle = "original_title"
//        case overview
//        case mediaType = "media_type"
//        case adult, title
//        case originalLanguage = "original_language"
//        case genreIDS = "genre_ids"
//        case popularity
//        case releaseDate = "release_date"
//        case video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
    }
}
