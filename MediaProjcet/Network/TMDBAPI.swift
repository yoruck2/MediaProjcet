//
//  Network.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case error
}

struct TMDBAPI {
    
    static let shared = TMDBAPI()
    private init() {}
    
    typealias TrendingHandler = ([Trending.Result]?, NetworkError?) -> Void
    
    func request<T: Decodable>(api: TMDBRequest,
                                     page: Int? = nil,
                                     model: T.Type,
                                     completion: @escaping (T?, Error?) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   headers: api.header)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: T.self) { response in
            switch response.result {
            case .success(let value):
                completion(value, nil)
                print("성공\(api.endPoint)")
            case .failure(let error):
                completion(nil, error)
                print("실패\(api.endPoint)")
                print(error)
                print("-=-=--=-=-=--")
                print(response.response?.statusCode)
                print(response.response?.url)
                
            }
        }
    }
}


