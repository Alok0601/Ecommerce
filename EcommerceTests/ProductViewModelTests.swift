//
//  ProductListingTest.swift
//  EcommerceTests
//
//  Created by Alok Ranjan on 04/02/24.
//

import XCTest
@testable import Ecommerce

final class ProductListingTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testProductWebService() {
        let viewModel = ProductViewModel()
        let expectation = XCTestExpectation(description: "Product web service call")

        // Act
        viewModel.productWebService(with: "query", sortBy: "Relevancia|0")

        // Assert
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            // Assuming 2 seconds is enough time for the async call to complete
            XCTAssertFalse(viewModel.isAnimated.value ?? false, "isAnimated should be false after web service call")
            XCTAssertGreaterThan(viewModel.products.value?.count ?? 1, 0, "Products array should not be empty")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 3.0) // Adjust the timeout based on your async call duration
    }

    func testSortBYTapped() {
        let viewModel = ProductViewModel()
        viewModel.sortBYTapped(data: .Relevance)
        XCTAssertEqual(viewModel.isAnimated.value, true, "isAnimated should be true after sortBYTapped call")
    }
}

