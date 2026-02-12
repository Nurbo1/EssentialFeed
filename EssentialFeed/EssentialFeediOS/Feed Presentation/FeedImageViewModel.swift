//
//  FeedImageViewModel.swift
//  EssentialFeed
//
//  Created by Нурбол Мухаметжан on 04.02.2026.
//

import EssentialFeed
import Foundation

struct FeedImageViewModel<Image> {
    let description: String?
    let location: String?
    let image: Image?
    let isLoading: Bool
    let shouldRetry: Bool

    var hasLocation: Bool {
        return location != nil
    }
}
