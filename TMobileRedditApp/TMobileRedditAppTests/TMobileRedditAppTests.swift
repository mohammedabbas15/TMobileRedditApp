//
//  TMobileRedditAppTests.swift
//  TMobileRedditAppTests
//
//  Created by Mohammed Abbas on 11/11/21.
//

import XCTest
import Combine
@testable import TMobileRedditApp

class TMobileRedditAppTests: XCTestCase {

    var viewModel: ViewModel!
    var cancellable: Set<AnyCancellable>!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        try super.setUpWithError()
        viewModel = ViewModel(repository: TestRepo())
        cancellable = Set<AnyCancellable>()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
        viewModel = nil
        cancellable = nil
        try super.tearDownWithError()
    }
    
    func testGetFeedDataFailure() {
        
        let expectation = XCTestExpectation(description: "")
        var error: String?
        
        viewModel?.feedBinding.dropFirst().sink(receiveCompletion: {_ in}, receiveValue: {_ in XCTFail()}).store(in: &cancellable)
        viewModel?.errorBinding.dropFirst().sink(receiveCompletion: {_ in}, receiveValue: { value in
                error = value
                expectation.fulfill()
            }).store(in: &cancellable)
        viewModel?.getFeeds()
        
        wait(for: [expectation], timeout: 3)
        
        let assertStr = "The operation couldn't be completed. (TMobileRedditApp.NetworkError error 1.)"
        
        XCTAssertEqual(error?.description, assertStr)
    }
    
    func testGetFeedDataSuccess() {
        
        let expectation = XCTestExpectation(description: "SUCCESS")
        
        viewModel.after = "Success"
        viewModel?.feedBinding.dropFirst().sink(receiveCompletion: { _ in}, receiveValue: { _ in expectation.fulfill()}).store(in: &cancellable)
        viewModel?.errorBinding.dropFirst().sink(receiveCompletion: { _ in}, receiveValue: { _ in XCTFail()}).store(in: &cancellable)
        viewModel?.getFeeds()
        
        wait(for: [expectation], timeout: 3)
        
        XCTAssertEqual(viewModel.numberOfItems, 25)
        XCTAssertEqual(viewModel.getTitle(at: 0), "A nanobot picks up a lazy sperm by the tail and inseminates an egg with it")
        XCTAssertEqual(viewModel.getCommentNumber(at: 0), "Comments: 2587")
        XCTAssertEqual(viewModel.getScore(at: 0), "Score: 32860")
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
