//
//  FeedStoreSpecs.swift
//  EssentialFeed
//
//  Created by Нурбол Мухаметжан on 27.09.2025.
//
import Foundation

protocol FeedStoreSpecs {
    func test_retrieve_deliversEmptyOnEmptyCache()
    func test_retrieve_hasNoSideEffects()
    func test_retrieve_deliversFoundValuesOnNonEmptyCache()
    func test_retrieve_hasNoSideEffectsOnNonEmptyCache()

    func test_insert_overridesPreviouslyInsertedCacheValues()

    func test_delete_hasNoSideEffectsOnEmptyCache()
    func test_delete_emptiesPreviouslyInsertedCache()

    func test_storeSideEffects_runSerially()
}

protocol FailableRetrieveFeedSpecs: FeedStoreSpecs {
    func test_retrieve_deliversFailureOnRetrievalFailure()
    func test_retrieve_hasNoSideEffectsOnFailure()
}

protocol FailableInsertFeedSpecs: FeedStoreSpecs {
    func test_insert_deliversErrorOnInsertionError()
    func test_insert_hasNoSideEffectsOnFailure()
}

protocol FailableDeleteFeedSpecs: FeedStoreSpecs {
    func test_delete_deliversErrorOnDeletionError()
    func test_delete_hasNoSideEffectsOnFailure()
}
