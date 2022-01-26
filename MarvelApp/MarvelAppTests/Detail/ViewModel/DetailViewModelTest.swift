//
//  DetailViewModelTest.swift
//  MarvelAppTests
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import XCTest
import Foundation
@testable import MarvelApp

final class DetailViewModelTest: XCTestCase {
    
    var api: DetailAPIMock!
    var viewModel: DetailViewModel!
    
    override func setUpWithError() throws {
        api = DetailAPIMock()
        viewModel = DetailViewModel(characterId: 0, api: api)
    }
    
    func testInformationNil() {
        api.withError = true
        viewModel.getCharacterDetail { result in
            XCTAssertFalse(result)
            XCTAssertNotNil(self.viewModel.httpError)
            XCTAssertEqual(self.viewModel.information.description, String())
            XCTAssertEqual(self.viewModel.information.name, String())
            XCTAssertEqual(self.viewModel.information.event, String())
        }
    }
    
    func testInformation() {
        api.withError = false
        viewModel.getCharacterDetail { result in
            XCTAssertTrue(result)
            XCTAssertNil(self.viewModel.httpError)
            XCTAssertEqual(self.viewModel.information.description, "Description:\niOS Developer")
            XCTAssertEqual(self.viewModel.information.name, "Juan")
            XCTAssertEqual(self.viewModel.information.event, "Event: iOS Event")
        }
    }
}
