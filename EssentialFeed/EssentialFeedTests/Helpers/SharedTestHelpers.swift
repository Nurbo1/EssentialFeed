//
//  SharedTestHelpers.swift
//  EssentialFeedTests
//
//  Created by Нурбол Мухаметжан on 18.09.2025.
//

import Foundation

func anyURL() -> URL {
    return URL(string: "https://example.com")!
}

func anyNsError() -> NSError {
    return NSError(domain: "any error", code: 1)
}
