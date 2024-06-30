//
//  MovieCredits.swift
//  MediaProjcet
//
//  Created by dopamint on 6/30/24.
//

import Foundation

struct MovieCredits: Codable {
    let id: Int
    let cast, crew: [MovieCredits.Result]?
    
    struct Result: Codable {
        let id: Int
        let name: String
        let character: String?
        let job: String?
        let profilePath: String?
        let creditID: String
        let order: Int?
        let department: String?

        enum CodingKeys: String, CodingKey {
            case id
            case name
            case character
            case job
            case profilePath = "profile_path"
            case creditID = "credit_id"
            case department
            case order
        }
    }
}
