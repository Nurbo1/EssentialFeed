//
//  RemoteFeedItem.swift
//  EssentialFeed
//
//  Created by Нурбол Мухаметжан on 10.09.2025.
//

import Foundation

struct RemoteFeedItem: Decodable {
	let id: UUID
	let description: String?
	let location: String?
	let image: URL
}
