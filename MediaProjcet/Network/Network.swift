//
//  Network.swift
//  MediaProjcet
//
//  Created by dopamint on 6/11/24.
//

import Foundation
import Alamofire

struct Network {
    
    static func sendGetRequest(page: Int, with string: String, completion: @escaping (SearchedMovieDTO) -> Void) {
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
}
