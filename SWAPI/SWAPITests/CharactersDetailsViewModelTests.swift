//
//  CharactersDetailsViewModelTests.swift
//  SWAPITests
//
//  Created by Malav Soni on 07/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import XCTest
@testable import SWAPI

class CharactersDetailsViewModelTests: XCTestCase {

    var viewModel:CharactersDetailsViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewModel = CharactersDetailsViewModel(withModel: Character.sample())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
    }
    
    func testFetchFilms() {
        let expectation = Expectation(description: #function)
        expectation.expectedFulfillmentCount = 2
        
        let totalFilms = self.viewModel.totalFilms
        XCTAssert(self.viewModel.fetchFilm() == true, "API Call should be initiated")
        expectation.fulfill()
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
            XCTAssert(self.viewModel.films.count == totalFilms, "Film objects should be equal to film urls \(self.viewModel.films.count) == \(totalFilms))")
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 15.0)
    }
}
