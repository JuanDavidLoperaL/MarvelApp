//
//  MarvelMock.swift
//  MarvelAppTests
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import Foundation
@testable import MarvelApp

extension Marvel {
    static func getMock() -> Marvel {
        let items: [CharacterItems] = [CharacterItems(name: "iOS Event")]
        let comics: Comics = Comics(available: 1, items: items)
        let thumbnail: Thumbnail = Thumbnail(path: "path", imageType: .jpg)
        let result: [Characters] = [Characters(id: 0, name: "Juan", description: "iOS Developer", thumbnail: thumbnail, comics: comics, series: comics, events: comics)]
        let info: Information = Information(results: result)
        return Marvel(code: 200, status: "OK", information: info)
    }
}
