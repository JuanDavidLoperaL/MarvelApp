//
//  DetailAPIMock.swift
//  MarvelAppTests
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import APIManager
import Foundation
@testable import MarvelApp

final class DetailAPIMock: DetailAPIProtocol {
    
    var withError: Bool = false
    
    func getCharacterDetail(with id: Int, callback: @escaping (Result<Marvel?, HttpError>) -> Void) {
        if withError {
            callback(.failure(.genericError))
        } else {
            callback(.success(Marvel.getMock()))
        }
    }
}
