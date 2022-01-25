//
//  MarvelConfig.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import Foundation

final class MarvelConfig {
    
    // MARK: - Static Properties
    static let shared: MarvelConfig = MarvelConfig()
    
    // MARK: - Properties
    var apiKey: String = "03f08d687f0874b409d2f606ad8f34ab"
    var hash: String = "befeaa3bd836904f8f5d1eb9c17a1c2d"
    var timestamp: String = "1"
    
    // MARK: - Private Init
    private init() {}
}
