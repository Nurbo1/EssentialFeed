//
//  FeedRefreshViewController.swift
//  EssentialFeed
//
//  Created by Нурбол Мухаметжан on 02.02.2026.
//

import UIKit
import EssentialFeed

protocol FeedRefreshViewControllerDelegate {
    func didRequestFeedRefresh()
}

public final class FeedRefreshViewController: NSObject, FeedLoadingView {
    public lazy var view: UIRefreshControl = loadView()
    
    private let delegate: FeedRefreshViewControllerDelegate
        
    init(delegate: FeedRefreshViewControllerDelegate) {
        self.delegate = delegate
    }
    
    @objc func refresh() {
        delegate.didRequestFeedRefresh()
    }
    
    func display(_ viewModel: FeedLoadingViewModel) {
        if viewModel.isLoading {
            view.beginRefreshing()
        } else {
            view.endRefreshing()
        }
    }
    
    private func loadView() -> UIRefreshControl {
        let view = UIRefreshControl()
        view.addTarget(self, action: #selector(refresh), for: .valueChanged)
        return view
    }
}
