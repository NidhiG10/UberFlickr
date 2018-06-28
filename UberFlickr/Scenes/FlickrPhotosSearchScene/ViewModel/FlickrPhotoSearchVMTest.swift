//
//  FlickrPhotoSearchVMTest.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 28/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import Foundation

import XCTest
@testable import UberFlickr

class FlickrPhotoSearchVMTests: XCTestCase {
    
    var vm: FlickrPhotoSearchVM!
    var api: APIMock!
    
    override func setUp() {
        super.setUp()
        api = APIMock()
        vm = FlickrPhotoSearchVM(api: api)
    }
    
    func testVMState() {
        
        XCTAssertEqual(vm.state, .default)
        
        vm.searchText = "Hello"
        XCTAssertEqual(vm.state, .loadingPhotos)
        
    }
    
    func testSuccessfulResponse() {
        
        let photos = [UberFlickr.FlickrPhoto(id: "23451156376", title: "testPhoto", farm: 1, secret: "8983a8ebc7", server: "578")]
        api.result = UberFlickr.FlickrPhotoSearchResult(page: 1, pages: 4, photos: photos)
        vm.searchText = "Hello"
        
        let expectation = self.expectation(description: "errorState")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        waitForExpectations(timeout: 4, handler: nil)
        XCTAssertEqual(vm.state, .batchFetched)
        
        XCTAssertEqual(vm.photos[0], photos[0])
        
    }
    
    func testFailureResponse() {
        
        api.error = UberFlickr.Error.api(.invalidImageData)
        vm.searchText = "Hello"
        
        let expectation = self.expectation(description: "errorState")
        DispatchQueue.main.async {
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 4, handler: nil)
        XCTAssertEqual(vm.state, .error(UberFlickr.Error.api(.invalidImageData)))
        
        
        
    }
}
