//
//  APIURL.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import Foundation

struct APIURL {
    static let trendingURL = "https://api.themoviedb.org/3/trending/all/day?api_key=\(APIType.TMDB_API.APIkey)"
    static let searchMovieURL = "https://api.themoviedb.org/3/search/movie?api_key=\(APIKey.TMDB_Key)"
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
        print("--mmmmm------------------------")
        print(key)
        print("--mmmmm------------------------")
        print(keyName)
        print("--mmmmm------------------------")
        return key
    }
}

