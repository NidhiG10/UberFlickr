//
//  FlickrPhotoSearchViewModel.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 24/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

enum State {
    case `default`
    case loadingImages
    case error(Error)
    case batchFetched
}

extension State: Equatable {
    static func == (l: State, r: State) -> Bool {
        switch (l, r) {
        case (.default, .default),
             (.loadingImages, loadingImages),
             (.batchFetched, batchFetched):
            return true
            
        case let (.error(lDescription), .error(rDescription)):
            return lDescription == rDescription
            
        default:
            return false
        }
    }
}

class FlickrPhotoSearchViewModel {
    
    private(set) var state: State = .default {
        didSet { self.didUpdateState?(self) }
    }
    
    fileprivate let api: API
    
    var photos: [FlickrPhoto] = []
    private var nextPage = 1
    private var hasMoreData = false
    
    private let searchPageCount = 50
    
    var  didUpdateState: ((FlickrPhotoSearchViewModel) -> Void)?
    
    init(api: API) {
        self.api = api
    }
    
    var searchText: String = "" {
        didSet {
            guard searchText != oldValue else {
                return
            }
            performInitialSearch()
        }
    }
    
    private func performInitialSearch() {
        // Reset
        photos = []
        nextPage = 1
        hasMoreData = false
        
        let currentSearchText = searchText
        guard !currentSearchText.isEmpty else {
            return
        }
        
        searchPhotos(with: self.searchText)
    }
    
    // API call to fetch Images
    private func searchPhotos(with text: String) {
        
        guard self.state != .loadingImages else {
            return
        }
        
        state = .loadingImages
        
        api.searchPhotos(withText: text, page: nextPage, perPageCount: searchPageCount, success: {[weak self] (result) in
            DispatchQueue.main.async {
                if let photos = result.photos{
                    self?.photos.append(contentsOf: photos)
                }
                self?.state = .batchFetched
            }
        }) {[weak self] (error) in
            DispatchQueue.main.async {
                self?.state = .error(error)
            }
        }
    }
    
    func loadMorePhotos() {
        guard self.state != .loadingImages else {
            return
        }
        
        nextPage += 1
        
        searchPhotos(with: self.searchText)
    }
}
