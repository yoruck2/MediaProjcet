//
//  Video.swift
//  MediaProjcet
//
//  Created by dopamint on 7/2/24.
//

import Foundation

struct Video: Decodable {
    let id: Int
    let results: [Video.Result]
    struct Result: Decodable {
        let name, key: String
    //    let site: Site
    //    let size: Int
    //    let type: TypeEnum
    //    let official: Bool
    //    let puid: String

        enum CodingKeys: String, CodingKey {
            case name, key
    //        case id
        }
    }
}


