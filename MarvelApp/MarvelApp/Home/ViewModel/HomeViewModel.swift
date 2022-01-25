//
//  HomeViewModel.swift
//  MarvelApp
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import APIManager
import UIKit

final class HomeViewModel {
    
    // MARK: - Typealias
    typealias strings = AppText.Home
    
    // MARK: - Private Properties
    private let api: HomeAPIProtocol
    private let downloadHundredPercent: CGFloat = 1.0
    private let downloadSixtyPercent: CGFloat = 0.6
    private let increaseDownloadInOnePercent: CGFloat = 0.01
    private var timer : Timer?
    private var trackValue: CGFloat = 0.0
    private var marvelInfo: Marvel?
    private(set) var httpError: HttpError?
    
    // MARK: - Internal Properties
    var currentCell: Int = 0
    var cellSelected: Int = 0 {
        didSet {
            guard let id: Int = marvelInfo?.information.results[cellSelected].id else {
                return
            }
            delegate?.characterSelected(with: id)
        }
    }
    
    // MARK: - Delegate
    weak var delegate: HomeViewControllerDelegate?
    
    // MARK: - Internal Init
    init(api: HomeAPIProtocol = HomeAPI()) {
        self.api = api
    }
    
    // MARK: - Computed Properties
    var numberOfRowInTable: Int {
        guard let numberOrRows: Int = marvelInfo?.information.results.count else {
            return 0
        }
        return numberOrRows
    }
    
    var title: String {
        return strings.title
    }
    
    var information: (icon: URL, description: String, comics: String, series: String) {
        guard let infoCharacter: Characters = marvelInfo?.information.results[currentCell], let icon: URL = URL(string: "\(infoCharacter.thumbnail.path).\(infoCharacter.thumbnail.imageType.rawValue)") else {
            return (icon: URL(fileURLWithPath: String()), description: String(), comics: String(), series: String())
        }
        var description: String = String()
        if infoCharacter.description.isEmpty {
            description = "Not description available"
        } else {
        description = "\(strings.description)\n\(infoCharacter.description)"
        }
        let comics: String = "\(strings.comics) \(infoCharacter.comics.available)"
        let series: String = "\(strings.series) \(infoCharacter.series.available)"
        return (icon: icon, description: description, comics: comics, series: series)
    }
}

// MARK: - Internal Function
extension HomeViewModel {
    func getMarvelInfo(callback: @escaping(Bool) -> Void) {
        api.getMarvelInfo { [weak self] result in
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
