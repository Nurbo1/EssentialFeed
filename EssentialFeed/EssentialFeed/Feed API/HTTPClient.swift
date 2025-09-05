//
//  HTTPClient.swift
//  EssentialFeed
//
//  Created by Нурбол Мухаметжан on 23.08.2025.
//

import Foundation

public protocol HTTPClient {
    func get(from url: URL, completion: @escaping (HTTPClientResult) -> Void)
}

public enum HTTPClientResult {
    case success(Data, HTTPURLResponse)
    case failure(Error)
}
