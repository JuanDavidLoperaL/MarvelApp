//
//  DetailViewModel.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import APIManager
import UIKit

final class DetailViewModel {
    
    // MARK: - Typealias
    typealias strings = AppText.Detail
    
    // MARK: - Private Properties
    private let characterId: Int
    private let api: DetailAPIProtocol
    private let downloadHundredPercent: CGFloat = 1.0
    private let downloadSixtyPercent: CGFloat = 0.6
    private let increaseDownloadInOnePercent: CGFloat = 0.01
    private var timer: Timer?
    private var trackValue: CGFloat = 0.0
    private var marvelInfo: Marvel?
    private(set) var httpError: HttpError?
    
    // MARK: - Delegate
    weak var delegate: DetailViewControllerDelegate?
    
    // MARK: - Internal Init
    init(characterId: Int, api: DetailAPIProtocol = DetailAPI()) {
        self.characterId = characterId
        self.api = api
    }
    
    // MARK: - Computed Properties
    var information: (image: URL, name: String, description: String, event: String) {
        guard let infoCharacter: Characters = marvelInfo?.information.results.first, let icon: URL = URL(string: "\(infoCharacter.thumbnail.path).\(infoCharacter.thumbnail.imageType.rawValue)") else {
            return (image: URL(fileURLWithPath: String()), name: String(), description: String(), event: String())
        }
        var description: String = String()
        if infoCharacter.description.isEmpty {
            description = "Not description available"
        } else {
        description = "\(strings.description)\n\(infoCharacter.description)"
        }
        let name: String = infoCharacter.name
        let event: String = "\(strings.event) \(infoCharacter.events.items.first?.name ?? String())"
        return (image: icon, name: name, description: description, event: event)
    }
}

// MARK: - Internal Function
extension DetailViewModel {
    func getCharacterDetail(callback: @escaping(Bool) -> Void) {
        api.getCharacterDetail(with: characterId) { [weak self] result in
            DispatchQueue.main.async {
                self?.timer?.invalidate()
                switch result {
                case .success(let marvel):
                    self?.httpError = nil
                    self?.marvelInfo = marvel
                    self?.delegate?.informationLoadedWithSucess()
                    callback(true)
                case .failure(let httpError):
                    self?.marvelInfo = nil
                    self?.httpError = httpError
                    self?.delegate?.errorLoadingInformation()
                    callback(false)
                }
            }
        }
    }
    
    func startPercentLoader() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.1, repeats: true, block: { _ in
            if self.trackValue >= self.downloadHundredPercent || self.trackValue >= self.downloadSixtyPercent {
                self.delegate?.setValueInLoader(track: self.trackValue)
                self.timer?.invalidate()
            } else {
                self.trackValue += self.increaseDownloadInOnePercent
                self.delegate?.setValueInLoader(track: self.trackValue)
            }
        })
    }
}
