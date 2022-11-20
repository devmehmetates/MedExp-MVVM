//
//  MedExp_HomeViewModelTests.swift
//  SwiftUI-MVVM-ExampleTests
//
//  Created by Mehmet Ateş on 19.11.2022.
//

import XCTest
@testable import SwiftUI_MVVM_Example

final class MedExp_HomeViewModelTests: XCTestCase {
    private var homeViewModel: HomeViewModel!
    private var networkManager: NetworkManagerMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkManager = NetworkManagerMock()
        homeViewModel = HomeViewModel(manager: networkManager)
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        homeViewModel = nil
        networkManager = nil
    }
    
    func testSectionInit() {
        XCTAssertTrue(networkManager.invokedApiRequest)
        XCTAssertEqual(networkManager.invokedApiRequestCount, 6)
    }
    
    func testCreateSectionEndpoint() {
        XCTAssertTrue(networkManager.invokedCreateRequestURL)
        XCTAssertEqual(networkManager.invokedCreateRequestURLCount, 6)
    }
    
    func testIncreasePage() {
        homeViewModel.increasePage(withSectionKey: "Popular on TV")
        XCTAssertEqual(networkManager.invokedApiRequestCount, 7)
        XCTAssertEqual(networkManager.invokedCreateRequestURLCount, 7)
    }
}
