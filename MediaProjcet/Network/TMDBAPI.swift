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
//    ([SearchedMovie.Result], NetworkError?)
    typealias TrendingHandler = ([Trending.Result]?, NetworkError?) -> Void
    typealias SuggestionHandler = ([MovieSuggestion.Result]?, NetworkError?) -> Void
    typealias ImageHandler = ([[MovieImage.Poster]]?, NetworkError?) -> Void
    
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
    
//    func requestMovieSuggestion(api: TMDBRequest,
//                                page: Int? = nil,
//                                completion: @escaping (T?, Error?) -> Void)) {
//        AF.request(api.endPoint,
//                   method: api.method,
//                   parameters: api.parameter,
//                   headers: api.header)
//        .validate(statusCode: 200..<300)
//        .responseDecodable(of: MovieSuggestion.self) { response in
//            switch response.result {
//            case .success(let data):
//                print(data.results)
//                print("추천 성공\(api.endPoint)")
//                completion(data.results, nil)
//            case .failure(let error):
//                completion(nil, "네트워크 오류발생")
//                print(error)
//                print("추천 실패\(api.endPoint)")
//            }
//        }
//    }
//    
//    func requestTrending(api: TMDBRequest,
//                         movieID: Int,
//                         page: Int,
//                         completion: @escaping TrendingHandler) {
//        
//        AF.request(api.endPoint,
//                   method: api.method,
//                   parameters: api.parameter,
//                   headers: api.header)
//        .validate(statusCode: 200..<300)
//        .responseDecodable(of: Trending.self) { response in
//            switch response.result {
//            case .success(let data):
//                completion(data.results, nil)
//            case .failure(let error):
//                completion(nil, "네트워크 오류발생")
//                print(error)
//                print(api.endPoint)
//            }
//        }
//    }
//    
//    func requestMoviePoster(api: TMDBRequest,
//                            page: Int? = nil,
//                            completion: @escaping ([MovieImage.Poster]) -> Void) {
//        AF.request(api.endPoint,
//                   method: api.method,
//                   headers: api.header)
//        .validate(statusCode: 200..<300)
//        .responseDecodable(of: MovieImage.self) { response in
//            switch response.result {
//            case .success(let data):
//                print("사진 성공\(api.endPoint)")
//                completion(data.posters)
//            case .failure(let error):
//                print("사진 실패\(api.endPoint)")
//                print(error)
//            }
//        }
//    }
}


