//
//  DetailAPI.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import APIManager
import Foundation

protocol DetailAPIProtocol {
    func getCharacterDetail(with id: Int, callback: @escaping (Result<Marvel?, HttpError>) -> Void)
}

final class DetailAPI: DetailAPIProtocol {
    
    // MARK: - Enum Endpoints
    enum Endpoint: String {
        case marvelInfo = "/v1/public/characters"
    }
    
    // MARK: - Private Properties
    private var baseURL: URLComponents
    private var apimanager: APIManager = APIManager()
    
    // MARK: - Internal Init
    init(baseURL: URLComponents = EnvironmentURLHandler.variable(key: .baseURL)) {
        self.baseURL = baseURL
    }
    
    func getCharacterDetail(with id: Int, callback: @escaping (Result<Marvel?, HttpError>) -> Void) {
        baseURL.path = "\(Endpoint.marvelInfo.rawValue)/\(id)"
        baseURL.queryItems = [
            URLQueryItem(name: "apikey", value: MarvelConfig.shared.apiKey),
            URLQueryItem(name: "hash", value: MarvelConfig.shared.hash),
            URLQueryItem(name: "ts", value: MarvelConfig.shared.timestamp)
        ]
        guard
            let url: URL = baseURL.url
        else {
            fatalError("Error getting URL from URLComponent Function: \(#function)  -- code line: \(#line)")
        }
        apimanager.request(to: url, method: .get, completion: callback)
    }
}
