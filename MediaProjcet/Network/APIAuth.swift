//
//  APIAuth.swift
//  MediaProjcet
//
//  Created by dopamint on 6/27/24.
//

import Foundation

enum APIAuth {
    case APIKey
    case accessToken
    
    var keyName: String {
        switch self {
        case .APIKey:
            return "TMDB_API_KEY"
        case .accessToken:
            return "TMDB_Token"
        }
    }
    
    var header: String {
        guard let key = Bundle.main.object(forInfoDictionaryKey: keyName) as? String else {
            print("API_KEY를 찾을 수 없음")
            return ""
        }
        return key
    }
}
