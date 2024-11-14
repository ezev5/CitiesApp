//
//  CitiesAppTests.swift
//  CitiesAppTests
//
//  Created by Ezequiel Nicolas Velez on 11/11/2024.
//

import XCTest
import Combine
@testable import CitiesApp

final class CitiesAppTests: XCTestCase {
  var useCaseWrapper: MockUseCaseWrapper!
  var sut: CitiesListViewModel!
  var cancellables: Set<AnyCancellable> = []
  
  override func setUp() {
    super.setUp()
    useCaseWrapper = MockUseCaseWrapper()
    sut = CitiesListViewModel(useCaseWrapper: useCaseWrapper)
    sut.loadData()
  }
  
  override func tearDown() {
    useCaseWrapper = nil
    sut = nil
    cancellables.removeAll()
    super.tearDown()
  }
  
  func testSearchFunctionWithTextA() {
    let expectation = expectation(description: "Load Data Finish")
    sut.$isLoading.sink { isLoading in
      if !isLoading {
        expectation.fulfill()
      }
    }.store(in: &cancellables)
    
    waitForExpectations(timeout: 5)
    
    let inputString: String = "A"
    sut.searchInput = inputString
    
    let result: [City] = sut.searchResult
    
    XCTAssertFalse(result.isEmpty)
    XCTAssertEqual(result.count, 4)
  }
  
  func testSearchFunctionWithTextS() {
    let expectation = expectation(description: "Load Data Finish")
    sut.$isLoading.sink { isLoading in
      if !isLoading {
        expectation.fulfill()
      }
    }.store(in: &cancellables)
    
    waitForExpectations(timeout: 5)
    
    let expectedResult: [City] = []
    let inputString: String = "S"
    
    sut.searchInput = inputString
    
    let result: [City] = sut.searchResult
    
    XCTAssertFalse(result.isEmpty)
    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result.first?.name, "Sydney")
  }
  
  func testSearchFunctionWithTextAl() {
    let expectation = expectation(description: "Load Data Finish")
    sut.$isLoading.sink { isLoading in
      if !isLoading {
        expectation.fulfill()
      }
    }.store(in: &cancellables)
    
    waitForExpectations(timeout: 5)
    
    let inputString: String = "Al"
    
    sut.searchInput = inputString
    
    let result: [City] = sut.searchResult
    
    XCTAssertFalse(result.isEmpty)
    XCTAssertEqual(result.count, 2)
    XCTAssertTrue(result.contains(where: {$0.name == "Alabama"}))
    XCTAssertTrue(result.contains(where: {$0.name == "Albuquerque"}))
  }
  
  func testSearchFunctionWithTextAlb() {
    let expectation = expectation(description: "Load Data Finish")
    sut.$isLoading.sink { isLoading in
      if !isLoading {
        expectation.fulfill()
      }
    }.store(in: &cancellables)
    
    waitForExpectations(timeout: 5)
    
    let inputString: String = "Alb"
    
    sut.searchInput = inputString
    
    let result: [City] = sut.searchResult
    
    XCTAssertFalse(result.isEmpty)
    XCTAssertEqual(result.count, 1)
    XCTAssertEqual(result.first?.name, "Albuquerque")
  }
  
  func testSearchFunctionWithTextZZZZ() {
    let expectation = expectation(description: "Load Data Finish")
    sut.$isLoading.sink { isLoading in
      if !isLoading {
        expectation.fulfill()
      }
    }.store(in: &cancellables)
    
    waitForExpectations(timeout: 5)
    
    let inputString: String = "ZZZZ"
    
    sut.searchInput = inputString
    
    let result: [City] = sut.searchResult
    
    XCTAssertTrue(result.isEmpty)
  }
}
