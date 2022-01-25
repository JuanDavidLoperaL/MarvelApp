//
//  Thumbnail.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import Foundation

struct Thumbnail: Decodable {
    let path: String
    let imageType: ImageType

    enum CodingKeys: String, CodingKey {
        case path
        case imageType = "extension"
    }
}
