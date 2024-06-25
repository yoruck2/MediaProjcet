//
//  SimilarDTO.swift
//  MediaProjcet
//
//  Created by dopamint on 6/25/24.
//

import Foundation

struct SimilarDTO: Codable {
    let page: Int
    var results: [SimilarResultDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SimilarResultDTO: Codable {
    let posterPath: String
//    let adult: Bool
//    let backdropPath: String?
//    let genreIDS: [Int]
//    let id: Int
//    let originalLanguage, originalTitle, overview: String
//    let popularity: Double
//    let releaseDate: String
//    let title: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
//        case adult
//        case backdropPath = "backdrop_path"
//        case genreIDS = "genre_ids"
//        case id
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
//        case releaseDate = "release_date"
//        case title, video
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
    }
}
