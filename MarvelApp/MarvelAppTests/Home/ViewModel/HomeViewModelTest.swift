//
//  HomeViewModelTest.swift
//  MarvelAppTests
//
//  Created by Juan David Lopera Lopez on 25/01/22.
//

import Foundation
import XCTest
@testable import MarvelApp

final class HomeViewModelTest: XCTestCase {
    
    var api: HomeAPIMock!
    var viewModel: HomeViewModel!
    
    override func setUpWithError() throws {
        api = HomeAPIMock()
        viewModel = HomeViewModel(api: api)
    }
    
    func testNumberOfRowInTable() {
        api.withError = false
        viewModel.getMarvelInfo { result in
            XCTAssertTrue(result)
            XCTAssertNil(self.viewModel.httpError)
            XCTAssertEqual(self.viewModel.numberOfRowInTable, 1)
        }
    }
    
    func testNumberOfRowInTableZero() {
        api.withError = true
        viewModel.getMarvelInfo { result in
            XCTAssertFalse(result)
            XCTAssertNotNil(self.viewModel.httpError)
            XCTAssertEqual(self.viewModel.numberOfRowInTable, 0)
        }
    }
    
    func testTitle() {
        XCTAssertEqual(viewModel.title, "Marvel")
    }
    
    func testInformationNil() {
        api.withError = true
        viewModel.getMarvelInfo { result in
            XCTAssertFalse(result)
            XCTAssertNotNil(self.viewModel.httpError)
            XCTAssertEqual(self.viewModel.information.description, String())
            XCTAssertEqual(self.viewModel.information.comics, String())
            XCTAssertEqual(self.viewModel.information.series, String())
        }
    }
    
    func testInformation() {
        api.withError = false
        viewModel.getMarvelInfo { result in
            XCTAssertTrue(result)
            XCTAssertNil(self.viewModel.httpError)
            XCTAssertEqual(self.viewModel.information.description, "Description:\niOS Developer")
            XCTAssertEqual(self.viewModel.information.comics, "Comics: 1")
            XCTAssertEqual(self.viewModel.information.series, "Series: 1")
        }
    }
}
