//
//  MedExp_DetailViewModelTests.swift
//  SwiftUI-MVVM-ExampleTests
//
//  Created by Mehmet Ateş on 20.11.2022.
//

import XCTest
@testable import SwiftUI_MVVM_Example

final class MedExp_DetailViewModelTests: XCTestCase {
    private var detailViewModel: DetailViewModel!
    private var networkManager: NetworkManagerMock!
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        networkManager = NetworkManagerMock()
        detailViewModel = DetailViewModel(mediaId: 95403, mediaType: .tvShow, manager: networkManager)
    }
    
    override func tearDownWithError() throws {
        try super.tearDownWithError()
        detailViewModel = nil
        networkManager = nil
    }
    
    func testHandleMedias() {
        XCTAssertTrue(networkManager.invokedCreateRequestURL)
        XCTAssertEqual(networkManager.invokedCreateRequestURLCount, 4)
        XCTAssertTrue(networkManager.invokedApiRequest)
        XCTAssertEqual(networkManager.invokedApiRequestCount, 4)
    }
}
