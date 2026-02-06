//
//  FeedPresenter.swift
//  EssentialFeediOS
//
//  Created by Нурбол Мухаметжан on 05.02.2026.
//

import Foundation
import EssentialFeed

protocol FeedView {
    func display(_ viewModel: FeedViewModel)
}

protocol FeedLoadingView {
    func display(_ viewModel: FeedLoadingViewModel)
}

struct FeedViewModel {
    let feed: [FeedImage]
}

struct FeedLoadingViewModel {
    let isLoading: Bool
}


final class FeedPresenter {
    let loadingView: FeedLoadingView
    let feedView: FeedView
    
    init(loadingView: FeedLoadingView, feedView: FeedView) {
        self.loadingView = loadingView
        self.feedView = feedView
    }
    
    func didStartLoadingFeed() {
        loadingView.display(FeedLoadingViewModel(isLoading: true))
    }
    
    func didFinishLoadingFeed(with feed: [FeedImage]) {
        feedView.display(FeedViewModel(feed: feed))
        loadingView.display(FeedLoadingViewModel(isLoading: false  ))
    }
    
    func didFinishLoadingFeed(with error: Error) {
        loadingView.display(FeedLoadingViewModel(isLoading: false  ))
    }
}
