//
//  FeedViewModel.swift
//  EssentialFeed
//
//  Created by Нурбол Мухаметжан on 04.02.2026.
//

import EssentialFeed

final class FeedViewModel {
    typealias Observer<T> = (T) -> Void
    private var feedLoader: FeedLoader
        
    init(feedLoader: FeedLoader) {
        self.feedLoader = feedLoader
    }

    var onLoadingStateChange: Observer<Bool>?
    var onFeedLoad: Observer<[FeedImage]>?
    
    func loadFeed() {
        onLoadingStateChange?(true)
        feedLoader.load { [weak self] result in
            if let feed = try? result.get() {
                self?.onFeedLoad?(feed)
            }
            self?.onLoadingStateChange?(false)
        }
    }
}
