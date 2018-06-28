//
//  FlickrPhotoSearchViewControllerTests.swift
//  UberFlickrTests
//
//  Created by Nidhi Goyal on 28/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

import XCTest
@testable import UberFlickr

class FlickrPhotoSearchViewControllerTests: XCTestCase {
    
    var vc: FlickrPhotoSearchViewController!
    var vm: FlickrPhotoSearchVMMock!
    
    override func setUp() {
        super.setUp()
        vm = FlickrPhotoSearchVMMock()
        vm.mockPhotos = [UberFlickr.FlickrPhoto(id: "23451156376", title: "testPhoto", farm: 1, secret: "8983a8ebc7", server: "578")]
        vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FlickrPhotoSearchViewController") as! FlickrPhotoSearchViewController
        vc.viewModel = vm
        
        // load view
        _ = vc.view
    }
    
    func testCollectionView() {
        XCTAssertNotNil(vc.collectionView)
        
        let count = vc.collectionView(vc.collectionView, numberOfItemsInSection: 0)
        XCTAssertTrue(count == 1)
        
        let indexPath = IndexPath(row: 0, section: 0)
        let cell = vc.collectionView(vc.collectionView, cellForItemAt: indexPath)
        XCTAssertTrue(cell.isKind(of: FlickrPhotoCollectionViewCell.self))
    }
    
}
