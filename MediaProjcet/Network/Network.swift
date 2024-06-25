//
//  Network.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import Foundation
import Alamofire

struct NetworkManager {
    
    static let shared = NetworkManager()
    private init() {}
    
    // TODO: 제네릭으로 통합
    func requestSearch(page: Int, with string: String, completion: @escaping (SearchedMovieDTO) -> Void) {
        AF.request("\(APIURL.searchMovieURL)&query=\(string)&page=\(page)")
            .validate(statusCode: 200..<300)
            .responseDecodable(of: SearchedMovieDTO.self) { response in
                switch response.result {
                case .success(let value):
                    completion(value)
                case .failure(let error):
                    print(error)
                }
            }
    }
    
    func requestRecommandMovie(movieID: Int,
                               page: Int,
                               completion: @escaping (RecommendationDTO) -> Void) {
        let baseURL = APIURL.baseURL + "\(movieID)" + TMDBAPI.movies.category
        let parameters: Parameters = [
            "language": "ko-KR",
            "page": page
        ]
        let headers: HTTPHeaders = [
            "Authorization": APIKey.TMDB_Token
        ]
        AF.request(baseURL,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: RecommendationDTO.self) { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    func requestSimilarMovie(movieID: Int,
                             page: Int,
                             completion: @escaping (SimilarDTO) -> Void) {
        let baseURL = APIURL.baseURL + "\(movieID)" + TMDBAPI.movies.category
        let parameters: Parameters = [
            "language": "ko-KR",
            "page": page
        ]
        let headers: HTTPHeaders = [
            "Authorization": APIKey.TMDB_Token
        ]
        AF.request(baseURL,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: SimilarDTO.self) { response in
            switch response.result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    //    func requestMovie<T: Codable>(movieID: Int,
    //                                  page: Int,
    //                                  DTO: T.Type,
    //                                  completion: @escaping (T.Type) -> Void) {
    //        let baseURL = APIURL.baseURL + "\(movieID)" + TMDBAPI.movies.category
    //        let parameters: Parameters = [
    //            "language": "ko-KR",
    //            "page": page
    //        ]
    //        let headers: HTTPHeaders = [
    //            "Authorization": APIKey.TMDB_Token
    //        ]
    //        AF.request(baseURL,
    //                   method: .get,
    //                   parameters: parameters,
    //                   headers: headers)
    //        .validate(statusCode: 200..<300)
    //        .responseDecodable(of: T.self) { response in
    //            switch response.result {
    //            case .success(let data):
    //                completion(data as! T.Type)
    //            case .failure(let error):
    //                print(error)
    //            }
    //        }
    //    }
}


