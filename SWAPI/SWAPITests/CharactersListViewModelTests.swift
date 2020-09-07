//
//  CharactersListViewModelTests.swift
//  SWAPITests
//
//  Created by Malav Soni on 07/09/20.
//  Copyright © 2020 Malav Soni. All rights reserved.
//

import XCTest
@testable import SWAPI

class CharactersListViewModelTests: XCTestCase {

    var viewModel:CharactersListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.viewModel = CharactersListViewModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        self.viewModel = nil
    }
    
    func testLoadingCharacters() {
        
        let expectation = Expectation(description: #function)
        expectation.expectedFulfillmentCount = 4
        
        // Fetch Characters
        self.viewModel.loadCharacters()
        
        // Max Response Time: 10 Seconds x Number of API Calls
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 10) {
            if self.viewModel.characters.count > 0 {
                // API Should return more than one records.
                expectation.fulfill()
                
                // Check for next page URL avalibility.
                XCTAssert(self.viewModel.nextPageUrlValue.count > 0, "Next Page URL Should be available")
                expectation.fulfill()
                
                // Check what if first object passed in the function
                if let firstObject = self.viewModel.characters.first {
                    XCTAssert(self.viewModel.loadCharacters(fromLastItem: firstObject) == false, "First object passes as last object so API call should be ignored")
                    expectation.fulfill()
                } else {
                    XCTFail("First character not found")
                }
                
                // Check what if last object passed in the function
                if let lastObject = self.viewModel.characters.last {
                    XCTAssert(self.viewModel.loadCharacters(fromLastItem: lastObject) == true, "Last object passes as last object so API call should be initiated")
                    expectation.fulfill()
                } else {
                    XCTFail("First character not found")
                }
            } else {
                XCTFail("Failed to retrive characters")
            }
        }
        
        // Expectations to be fulfilled
        wait(for: [expectation], timeout: 20.0)
    }
}
