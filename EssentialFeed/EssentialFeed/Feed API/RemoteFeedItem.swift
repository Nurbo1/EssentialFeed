//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Нурбол Мухаметжан on 10.09.2025.
//

import Foundation

internal struct RemoteFeedItem: Decodable {
    internal let id: UUID
    internal let description: String?
    internal let location: String?
    internal let image: URL
}
