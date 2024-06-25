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
        AF.request("\(APIURL.searchMovieURL)&query=\(string)&page=\(page)&language=ko-KR")
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
                               completion: @escaping ([Result]) -> Void) {
        let baseURL = APIURL.baseURL + "/\(TMDBAPI.movies.category)" + "/\(movieID)" + "/recommendations"
        let parameters: Parameters = [
            "language": "ko-KR",
            "page": page
        ]
        let headers: HTTPHeaders = [
            "accept" : "application/json",
            "Authorization": APIKey.TMDB_Token
        ]
        AF.request(baseURL,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let data):
                print(data.results)
                completion(data.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestSimilarMovie(movieID: Int,
                             page: Int,
                             completion: @escaping ([Result]) -> Void) {
        let baseURL = APIURL.baseURL + "/\(TMDBAPI.movies.category)" + "/\(movieID)" + "/similar"
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
        .responseDecodable(of: Movie.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.results)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func requestMoviePoster(movieID: Int,
                             page: Int,
                             completion: @escaping ([Poster]) -> Void) {
        let baseURL = APIURL.baseURL + "/\(TMDBAPI.movies.category)" + "/\(movieID)" + "/images"
        let parameters: Parameters = [
            "page": page,
            "include_image_language": "en,null"
        ]
        let headers: HTTPHeaders = [
            "Authorization": APIKey.TMDB_Token
        ]
        AF.request(baseURL,
                   method: .get,
                   parameters: parameters,
                   headers: headers)
        .validate(statusCode: 200..<300)
        .responseDecodable(of: Posters.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.posters)
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


