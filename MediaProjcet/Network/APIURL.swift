//
//  APIURL.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import Foundation

enum TMDBAPI {
    case movies
    case search
    case trending
    
    var category: String {
        switch self {
        case .movies:
            return "movie"
        case .search:
            return "search"
        case .trending:
            return "trending"
        }
    }
    
    enum Movies: String {
        case recommendation
        case similar
    }
}

struct APIURL {
    static let trendingURL = "https://api.themoviedb.org/3/trending/all/day?api_key=\(APIType.TMDB_API.APIkey)"
    static let searchMovieURL = "https://api.themoviedb.org/3/search/movie?api_key=\(APIKey.TMDB_Key)"
    static let baseURL = "https://api.themoviedb.org/3"
}





// TODO: configuration의 key를 찾지 못하는 이유..?
enum APIType {
    case TMDB_API

    var APIkey: String {
        let keyName: String
        
        switch self {
        case .TMDB_API:
            keyName = "TMDB_API_KEY"
        }
        guard let key = Bundle.main.object(forInfoDictionaryKey: keyName) as? String else {
            print("API_KEY를 찾을 수 없음")
            return ""
        }
        return key
    }
}

