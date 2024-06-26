//
//  Network.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import Foundation
import Alamofire

struct TMDBAPI {
    
    static let shared = TMDBAPI()
    private init() {}
    
    typealias TrendingHandler = ([Trending.Result]?, String?) -> Void
    typealias SuggestionHandler = ([MovieSuggestion.Result]?, String?) -> Void
    
    func requestSearch(api: TMDBRequest,
                       page: Int,
                       completion: @escaping (SearchedMovie) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   headers: api.header)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: SearchedMovie.self) { response in
            switch response.result {
            case .success(let value):
                completion(value)
                print("검색 성공\(api.endPoint)")
            case .failure(let error):
                print(error)
                print("검색 실패\(api.endPoint)")
            }
        }
    }
    
    func requestMovieSuggestion(api: TMDBRequest,
                                page: Int? = nil,
                                completion: @escaping SuggestionHandler) {
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   headers: api.header)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: MovieSuggestion.self) { response in
            switch response.result {
            case .success(let data):
                print(data.results)
                print("추천 성공\(api.endPoint)")
                completion(data.results, nil)
            case .failure(let error):
                completion(nil, "네트워크 오류발생")
                print(error)
                print("추천 실패\(api.endPoint)")
            }
        }
    }
    
    func requestTrending(api: TMDBRequest,
                         movieID: Int,
                         page: Int,
                         completion: @escaping TrendingHandler) {
        
        AF.request(api.endPoint,
                   method: api.method,
                   parameters: api.parameter,
                   headers: api.header)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Trending.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.results, nil)
            case .failure(let error):
                completion(nil, "네트워크 오류발생")
                print(error)
                print(api.endPoint)
            }
        }
    }
    
    func requestMoviePoster(api: TMDBRequest,
                            page: Int? = nil,
                            completion: @escaping ([MovieImage.Poster]) -> Void) {
        AF.request(api.endPoint,
                   method: api.method,
                   headers: api.header)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: MovieImage.self) { response in
            switch response.result {
            case .success(let data):
                print("사진 성공\(api.endPoint)")
                completion(data.posters)
            case .failure(let error):
                print("사진 실패\(api.endPoint)")
                print(error)
            }
        }
    }
}


