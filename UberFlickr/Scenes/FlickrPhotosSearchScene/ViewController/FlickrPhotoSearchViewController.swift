//
//  FlickrPhotoSearchViewController.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 24/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class FlickrPhotoSearchViewController: UIViewController {
    let cellReuseIdentifier = "collectionCell"
    var viewModel: FlickrPhotoSearchViewModel!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Memory Game", comment: "Game setup controller title")   
        setupVMBindings()
    }
    
    fileprivate func setupVMBindings() {
        // Setup bindings
        
        viewModel.didUpdateState = { [weak self] vm in
            self?.indicatorView.isHidden = (vm.state != .loadingImages)
            if case .batchFetched = vm.state {
                self?.collectionView.reloadData()
            }
//            if case let .error(error) = vm.state {
//                self?.showAlert(for: error)
//            }
        }
    }
    
//    func setupColelctionViewFooterView() {
//        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
//        spinner.startAnimating()
//        spinner.frame = CGRect(x: 0, y: 0, width: self.tableView.frame.width, height: 44)
//        self.collectionView.collecfoo
//    }
}

extension FlickrPhotoSearchViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! FlickrPhotoCollectionViewCell
        cell.configureCell(with: viewModel.photos[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionFooter {
            let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionFooter,
                                                                             withReuseIdentifier:"SectionFooter", for: indexPath) as UICollectionReusableView
            return headerView
        }
        
            return UICollectionReusableView()
    }
    
}

extension FlickrPhotoSearchViewController : UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(5.0, 5.0, 5.0, 5.0)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemWidth = (collectionView.bounds.width / 3) - (2 * 5)
        return CGSize(width: itemWidth, height: itemWidth)
    }
}

extension FlickrPhotoSearchViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        // calculates where the user is in the y-axis
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if self.viewModel.photos.count > 0 && offsetY > contentHeight - scrollView.frame.size.height {
            
            // call your API for more data
            self.viewModel.loadMorePhotos()
        }
    }
}

extension FlickrPhotoSearchViewController : UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        
        if let query = searchBar.text, !query.isEmpty {
            self.viewModel.searchText = query
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
}
