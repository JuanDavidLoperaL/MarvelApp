//
//  Marvel.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import Foundation

struct Marvel: Decodable {
    let code: Int
    let status: String
    let information: Information
    
    enum CodingKeys: String, CodingKey {
        case code
        case status
        case information = "data"
    }
}
