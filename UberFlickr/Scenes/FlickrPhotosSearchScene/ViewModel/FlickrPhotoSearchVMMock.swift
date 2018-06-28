//
//  FlickrPhotoSearchVMMock.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 28/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

@testable import UberFlickr

class FlickrPhotoSearchVMMock: FlickrPhotoSearchVM {
    
    override var photos: [FlickrPhoto] {
        set {}
        get { return mockPhotos }
    }
    
    var mockPhotos: [FlickrPhoto] = []
    
    var error: UberFlickr.Error?
    
    convenience init() {
        self.init(api: APIMock())
    }
    
    override var state: State {
        get { return mockState }
    }
    
    var mockState: State = .default {
        didSet { self.didUpdateState?(self) }
    }
    
    private func searchPhotos(with text: String) {
        
        if let error = error {
            self.mockState = .error(error)
            return
        }
        
        self.mockState = .batchFetched
    }
}

