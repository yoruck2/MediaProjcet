//
//  APIURL.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import Foundation
import Alamofire

enum TMDBRequest {
    case trending(type: TrendingType, language: Language)
    case searchMovie(query: String, page: Int?)
    case movieSuggestion(type: SuggestionType, movieId: Int, page: Int)
    case movieImage(movieId: Int)
    
    enum TrendingType: String {
        case TV = "tv"
        case Movie = "movie"
    }
    enum SuggestionType: String {
        case similarMovie = "similar"
        case recommandationMovie = "recommendations"
    }
    enum Language: String {
        case korean = "ko-KR"
        case english = "en-US" // default
    }
    
    // MARK: URL components -
    private var baseURL: String {
        return "https://api.themoviedb.org/3/"
    }
    
    var header: HTTPHeaders {
        return ["Authorization": APIAuth.accessToken.header]
    }
    
    var endPoint: URL {
        switch self {
        case .trending(let type, _):
            return URL.make(with: baseURL + "trending/\(type.rawValue)/day")
        case .searchMovie:
            return URL.make(with: baseURL + "search/movie")
        case .movieSuggestion(let type, let id,_):
            return URL.make(with: baseURL + "movie/\(id)/\(type.rawValue)")
        case .movieImage(let id):
            return URL.make(with: baseURL + "movie/\(id)/images")
        }
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters {
        switch self {
        case .trending(_, let language):
            return ["language": language.rawValue]
        case .searchMovie(let query, let page):
            return ["query": query, 
                    "page": page]
        case .movieSuggestion(_, _, let page):
            return ["page": page]
        case .movieImage:
            return ["include_image_language": ""]
        }
    }
}


