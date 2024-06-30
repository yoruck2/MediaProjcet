//
//  MovieGenre.swift
//  MediaProjcet
//
//  Created by dopamint on 6/30/24.
//

import Foundation

struct MovieGenre: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
