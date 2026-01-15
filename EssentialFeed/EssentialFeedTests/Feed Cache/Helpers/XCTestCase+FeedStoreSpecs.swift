//
//  XCTestCase+FeedStoreSpecs.swift
//  EssentialFeedTests
//
//  Created by Нурбол Мухаметжан on 27.09.2025.
//

import EssentialFeed
import XCTest

extension FeedStoreSpecs where Self: XCTestCase {
	
	func assertThatRetrieveDeliversEmptyOnEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		expect(sut, toRetrieve: .success(.none), file: file, line: line)
	}
	
	func assertThatRetrieveHasNoSideEffectsOnEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		expect(sut, toRetrieveTwice: .success(.none), file: file, line: line)
	}
	
	func assertThatRetrieveDeliversFoundValuesOnNonEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		let feed = uniqueImageFeed().local
		let timestamp = Date()
		
		insert((feed, timestamp), to: sut)
		
		expect(sut, toRetrieve: .success(CachedFeed(feed: feed, timestamp: timestamp)), file: file, line: line)
	}
	
	func assertThatRetrieveHasNoSideEffectsOnNonEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		let feed = uniqueImageFeed().local
		let timestamp = Date()
		
		insert((feed, timestamp), to: sut)
		
		expect(sut, toRetrieveTwice: .success(CachedFeed(feed: feed, timestamp: timestamp)), file: file, line: line)
	}
	
	func assertThatInsertDeliversNoErrorOnEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		let insertionError = insert((uniqueImageFeed().local, Date()), to: sut)
		
		XCTAssertNil(insertionError, "Expected cache insertion to succeed", file: file, line: line)
	}
	
	func assertThatInsertDeliversNoErrorOnNonEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		insert((uniqueImageFeed().local, Date()), to: sut)
		
		let insertionError = insert((uniqueImageFeed().local, Date()), to: sut)
		
		XCTAssertNil(insertionError, "Expected cache insertion to succeed", file: file, line: line)
	}
	
	func assertThatInsertOverridesPreviouslyInsertedCacheValues(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		let firstInsertionError = insert((uniqueImageFeed().local, Date()), to: sut)
		XCTAssertNil(firstInsertionError, "Expected first cache insertion to succeed", file: file, line: line)
		
		let latestFeed = uniqueImageFeed().local
		let latestTimestamp = Date()
		let latestInsertionError = insert((latestFeed, latestTimestamp), to: sut)
		
		XCTAssertNil(latestInsertionError, "Expected latest cache insertion to succeed", file: file, line: line)
		expect(sut, toRetrieve: .success(CachedFeed(feed: latestFeed, timestamp: latestTimestamp)), file: file, line: line)
	}
	
	func assertThatDeleteDeliversNoErrorOnEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		let deletionError = deleteCache(from: sut)
		
		XCTAssertNil(deletionError, "Expected cache deletion to succeed", file: file, line: line)
	}
	
	func assertThatDeleteHasNoSideEffectsOnEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		_ = deleteCache(from: sut)
		
		expect(sut, toRetrieve: .success(.none), file: file, line: line)
	}
	
	func assertThatDeleteDeliversNoErrorOnNonEmptyCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		insert((uniqueImageFeed().local, Date()), to: sut)
		
		let deletionError = deleteCache(from: sut)
		
		XCTAssertNil(deletionError, "Expected cache deletion to succeed", file: file, line: line)
	}
	
	func assertThatDeleteEmptiesPreviouslyInsertedCache(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		insert((uniqueImageFeed().local, Date()), to: sut)
		
		_ = deleteCache(from: sut)
		
		expect(sut, toRetrieve: .success(.none), file: file, line: line)
	}
	
	func assertThatSideEffectsRunSerially(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		var completedOperationsInOrder = [XCTestExpectation]()
		
		let op1 = expectation(description: "Operation 1")
		sut.insert(uniqueImageFeed().local, timestamp: Date()) { _ in
			completedOperationsInOrder.append(op1)
			op1.fulfill()
		}
		
		let op2 = expectation(description: "Operation 2")
		sut.deleteCachedFeed { _ in
			completedOperationsInOrder.append(op2)
			op2.fulfill()
		}
		
		let op3 = expectation(description: "Operation 3")
		sut.insert(uniqueImageFeed().local, timestamp: Date()) { _ in
			completedOperationsInOrder.append(op3)
			op3.fulfill()
		}
		
		waitForExpectations(timeout: 5.0)
		
		XCTAssertEqual(completedOperationsInOrder, [op1, op2, op3], "Expected side-effects to run serially but operations finished in the wrong order", file: file, line: line)
	}
	
	func assertThatInsertDeliversErrorOnInsertionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		let insertionError = insert((uniqueImageFeed().local, Date()), to: sut)

		XCTAssertNotNil(insertionError, "Expected cache insertion to fail with an error", file: file, line: line)
	}

	func assertThatInsertHasNoSideEffectsOnInsertionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		insert((uniqueImageFeed().local, Date()), to: sut)

		expect(sut, toRetrieve: .success(.none), file: file, line: line)
	}
	
	func assertThatRetrieveDeliversFailureOnRetrievalError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		expect(sut, toRetrieve: .failure(anyNsError()), file: file, line: line)
	}

	func assertThatRetrieveHasNoSideEffectsOnFailure(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		expect(sut, toRetrieveTwice: .failure(anyNsError()), file: file, line: line)
	}
	
	func assertThatDeleteDeliversErrorOnDeletionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		let deletionError = deleteCache(from: sut)
		XCTAssertNotNil(deletionError, "Expected cache deletion to fail", file: file, line: line)
	}

	func assertThatDeleteHasNoSideEffectsOnDeletionError(on sut: FeedStore, file: StaticString = #file, line: UInt = #line) {
		_ = deleteCache(from: sut)
		expect(sut, toRetrieve: .success(.none), file: file, line: line)
	}
	
	@discardableResult
	func insert(_ cache: (feed: [LocalFeedImage], timestamp: Date), to sut: FeedStore) -> Error? {
		let exp = expectation(description: "Wait for a cache insertion")
		var insertionError: Error?
		sut.insert(cache.feed, timestamp: cache.timestamp) { result in
			if case let Result.failure(error) = result { insertionError = error }
			exp.fulfill()
		}
		wait(for: [exp], timeout: 1.0)
		return insertionError
	}
	
	func deleteCache(from sut: FeedStore) -> Error? {
		let exp = expectation(description: "Wait for cache deletion")
		var deletionError: Error?
		sut.deleteCachedFeed { result in
			if case let Result.failure(error) = result { deletionError = error }
			exp.fulfill()
		}
		wait(for: [exp], timeout: 1.0)
		return deletionError
	}
	
	func expect(_ sut: FeedStore, toRetrieveTwice expectedResult: FeedStore.RetrievalResult, file: StaticString = #file, line: UInt = #line) {
		expect(sut, toRetrieve: expectedResult, file: file, line: line)
		expect(sut, toRetrieve: expectedResult, file: file, line: line)
	}
	
	func expect(_ sut: FeedStore, toRetrieve expectedResult: FeedStore.RetrievalResult, file: StaticString = #file, line: UInt = #line) {
		let exp = expectation(description: "Wait for cache retrieval")

		sut.retrieve { retrievedResult in
			switch (expectedResult, retrievedResult) {
			case (.success(.none), .success(.none)),
				 (.failure, .failure):
				break
			case let (.success(.some(expected)), .success(.some(retrieved))):
				XCTAssertEqual(retrieved.feed, expected.feed, file: file, line: line)
				XCTAssertEqual(retrieved.timestamp, expected.timestamp, file: file, line: line)
				
			default:
				XCTFail("Expected to retrieve \(expectedResult), but got \(retrievedResult) instead", file: file, line: line)
			}
			exp.fulfill()
		}
		wait(for: [exp], timeout: 1.0)
	}
}
