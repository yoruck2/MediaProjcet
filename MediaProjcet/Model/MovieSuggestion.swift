//
//  RecommendationDTO.swift
//  MediaProjcet
//
//  Created by dopamint on 6/25/24.
//

import Foundation

struct MovieSuggestion: Decodable {
    let results: [MovieSuggestion.Result]
    
    struct Result: Decodable {
        let posterPath: String?
        
        enum CodingKeys: String, CodingKey {
            case posterPath = "poster_path"
        }
    }
}

//struct RecommendationDTO: Codable {
//    let page: Int
//    var results: [ResultDTO]
//    let totalPages, totalResults: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case page, results
//        case totalPages = "total_pages"
//        case totalResults = "total_results"
//    }
//}
//
//// MARK: - Result
//struct ResultDTO: Codable {
//    let posterPath: String
//    //    let adult: Bool
//    //    let genreIDS: [Int]
//    //    let backdropPath: String
//    //    let id: Int
//    //    let originalLanguage: String
//    //    let originalTitle: String
//    //    let overview: String
//    //    let mediaType: String
//    //    let popularity: Double
//    //    let releaseDate: String
//    //    let title: String
//    //    let video: Bool
//    //    let voteAverage: Double
//    //    let voteCount: Int
//    
//    enum CodingKeys: String, CodingKey {
//        case posterPath = "poster_path"
//        //        case backdropPath = "backdrop_path"
//        //        case id
//        //        case originalTitle = "original_title"
//        //        case overview
//        //        case mediaType = "media_type"
//        //        case adult, title
//        //        case originalLanguage = "original_language"
//        //        case genreIDS = "genre_ids"
//        //        case popularity
//        //        case releaseDate = "release_date"
//        //        case video
//        //        case voteAverage = "vote_average"
//        //        case voteCount = "vote_count"
//    }
//}
