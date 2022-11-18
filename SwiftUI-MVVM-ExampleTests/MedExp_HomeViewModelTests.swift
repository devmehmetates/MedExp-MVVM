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
    
    override func setUpWithError() throws {
        try super.setUpWithError()
        homeViewModel = HomeViewModel()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        homeViewModel = nil
    }
}
