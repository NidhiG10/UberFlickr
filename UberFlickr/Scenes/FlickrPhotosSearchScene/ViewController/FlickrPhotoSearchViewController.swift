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
    let loadMoreCellReuseIdentifier = "loaderCell"
    
    var viewModel: FlickrPhotoSearchViewModel!
    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    @IBOutlet private weak var indicatorView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Memory Game", comment: "Game setup controller title")
        
        indicatorView.isHidden = true
        setupVMBindings()
    }
    
    fileprivate func setupVMBindings() {
        // Setup bindings
        
        viewModel.didUpdateState = { [weak self] vm in
            
            var hidesActivityIndicator = true
            var hidesCollectionView = false
            
            if case .loadingPhotos = vm.state {
                hidesActivityIndicator = false
                hidesCollectionView = true
                self?.collectionView.contentOffset = CGPoint(x: 0, y: 0)
            } else if case .batchFetched = vm.state {
                self?.collectionView.reloadData()
            } else if case let .error(error) = vm.state {
                self?.showAlert(for: error)
                self?.animateLoadMoreCell(animate: false)
            }
            
            self?.indicatorView.isHidden = hidesActivityIndicator
            self?.collectionView.isHidden = hidesCollectionView
        }
    }
    
    func animateLoadMoreCell(animate: Bool) {
        guard let cell = collectionView.cellForItem(at: IndexPath(item: 0, section: 1)) as? FlickrPhotoLoaderCell else {
            return
        }
        
        cell.isAnimating = animate
    }
}

extension FlickrPhotoSearchViewController {
    
    fileprivate func showAlert(for error: Error) {
        UIAlertController.showAlert(for: error, from: navigationController ?? self)
    }
}
extension FlickrPhotoSearchViewController : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return self.viewModel.hasMoreData ? 2 : 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section == 1) ? 1 : self.viewModel.photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.section == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: loadMoreCellReuseIdentifier, for: indexPath) as! FlickrPhotoLoaderCell
            cell.isAnimating = true
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellReuseIdentifier, for: indexPath) as! FlickrPhotoCollectionViewCell
        cell.configureCell(with: viewModel.photos[indexPath.item])
        return cell
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
        
        if indexPath.section == 1 {
            return CGSize(width: collectionView.bounds.size.width, height: 50)
        }
        
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
