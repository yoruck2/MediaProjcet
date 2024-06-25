//
//  TrendingDTO.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import Foundation

struct TrendingDTO: Codable {
    let page: Int
    let results: [TrendingResultDTO]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
//        case voteAverage
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

struct TrendingResultDTO: Codable {
    let backdropPath: String
    let id: Int
    let overview: String
    let posterPath: String
    let title: String
    let genreIDS: [Int]
    let releaseDate: String
//    let voteAverage: Double
    //    let originalLanguage: OriginalLanguage
    //    let popularity: Double
    //    let adult: Bool
    //    let video: Bool
    //    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id
        case overview
        case posterPath = "poster_path"
        case title
        case genreIDS = "genre_ids"
        case releaseDate = "release_date"
    }
}
//
//enum MediaType: String, Codable {
//    case movie = "movie"
//}
//
//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case fr = "fr"
//    case ja = "ja"
//}
