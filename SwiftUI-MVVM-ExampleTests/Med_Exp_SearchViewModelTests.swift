//
//  Med_Exp_SearchViewModelTests.swift
//  SwiftUI-MVVM-ExampleTests
//
//  Created by Mehmet Ateş on 20.11.2022.
//

import XCTest
@testable import SwiftUI_MVVM_Example

final class Med_Exp_SearchViewModelTests: XCTestCase {
    private var searchViewModel: SearchViewModel!
    private var networkManager: NetworkManagerMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkManager = NetworkManagerMock()
        searchViewModel = SearchViewModel(manager: networkManager)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        searchViewModel = nil
        networkManager = nil
    }
    
    func testSetPage() {
        searchViewModel.setPage(-1)
        XCTAssertTrue(networkManager.invokedCreateRequestURL)
        XCTAssertEqual(networkManager.invokedCreateRequestURLCount, 1)
        XCTAssertTrue(networkManager.invokedApiRequest)
        XCTAssertEqual(networkManager.invokedApiRequestCount, 1)
    }
    
    func testSetSearchKey_KeySetted() {
        searchViewModel.searchKey = "Titanic"
        XCTAssertTrue(searchViewModel.searchList.isEmpty)
        XCTAssertTrue(networkManager.invokedCreateRequestURL)
        XCTAssertEqual(networkManager.invokedCreateRequestURLCount, 1)
        XCTAssertTrue(networkManager.invokedApiRequest)
        XCTAssertEqual(networkManager.invokedApiRequestCount, 1)
    }
    
    func testSetSearchKey_KeyEmpty() {
        searchViewModel.setPage(-1) // First
        searchViewModel.searchKey = "" // Second - Third
        XCTAssertTrue(searchViewModel.searchList.isEmpty)
        XCTAssertEqual(searchViewModel.page, 1)
        XCTAssertTrue(networkManager.invokedCreateRequestURL)
        XCTAssertEqual(networkManager.invokedCreateRequestURLCount, 3)
        XCTAssertTrue(networkManager.invokedApiRequest)
        XCTAssertEqual(networkManager.invokedApiRequestCount, 3)
    }
}

