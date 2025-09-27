//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Нурбол Мухаметжан on 23.08.2025.
//

import Foundation

public protocol HTTPClient {
    /// The completion handler can be invoked in any thread.
    /// Clients are responsible to dispatch to appropriate threads, if needed.
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}
