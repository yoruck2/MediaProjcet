//
//  searchedMovieDTO.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import Foundation

struct SearchedMovieDTO: Codable {
    let page: Int
    let results: [SearchResultDTO]
    let total_pages, total_results: Int
}

struct SearchResultDTO: Codable {
    let posterPath: String?
    let backdropPath: String?
    let title: String
    let id: Int
//    let adult: Bool
//    let genreIDS: [Int]
//    let originalLanguage: OriginalLanguage
//    let originalTitle, overview: String
//    let popularity: Double
//    let releaseDate: String
//    let video: Bool
//    let voteAverage: Double
//    let voteCount: Int

    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case title
        case id
//        case video
//        case adult
//        case genreIDS = "genre_ids"
//        case originalLanguage = "original_language"
//        case originalTitle = "original_title"
//        case overview, popularity
//        case releaseDate = "release_date"
//        case voteAverage = "vote_average"
//        case voteCount = "vote_count"
    }
}
