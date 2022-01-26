//
//  Comics.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import Foundation

struct Comics: Decodable {
    let available: Int
    let items: [CharacterItems]
}
