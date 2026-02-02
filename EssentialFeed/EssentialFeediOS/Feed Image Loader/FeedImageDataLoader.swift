//
//  FeedImageDataLoader.swift
//  EssentialFeed
//
//  Created by Нурбол Мухаметжан on 02.02.2026.
//

import Foundation

public protocol FeedImageDataLoaderTask {
    func cancel()
}

public protocol FeedImageDataLoader {
    typealias Result = Swift.Result<Data, Error>
    
    func loadImageData(from url: URL, completion: @escaping (Result) -> Void) -> FeedImageDataLoaderTask
}
