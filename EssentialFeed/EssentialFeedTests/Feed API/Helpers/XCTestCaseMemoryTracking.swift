//
//  XCTestCaseMemoryTracking.swift
//  EssentialFeed
//
//  Created by Нурбол Мухаметжан on 04.09.2025.
//

import XCTest

extension XCTestCase {
    func trackForMemoryLeaks(_ instance: AnyObject, file: StaticString = #filePath, line: UInt = #line) {
        addTeardownBlock { [weak instance] in
            XCTAssertNil(instance, "Instance should have deallocated. Potential memory leak", file: file, line: line)
        }
    }
}
