//
//  MovieImage.swift
//  MediaProjcet
//
//  Created by dopamint on 6/27/24.
//

import Foundation

struct MovieImage: Decodable {
    let posters: [MovieImage.Poster]?
    
    struct Poster: Decodable {
        let filePath: String?
        
        enum CodingKeys: String, CodingKey {
            case filePath = "file_path"
        }
    }
}

