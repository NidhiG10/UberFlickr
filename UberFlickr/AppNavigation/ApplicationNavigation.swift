//
//  ApplicationNavigation.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 28/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class ApplicationNavigation {
    private let apiKey: APIKey
    private let window: UIWindow
    private let navigationController: UINavigationController
    
    private lazy var gateway: Gateway = NetworkProvider(session: URLSession(configuration: .default))
    private lazy var api: API = FlickrAPI(gateway: gateway, apiKey: apiKey)
    
    init(window: UIWindow, apiKey: APIKey) {
        self.apiKey = apiKey
        self.window = window
        navigationController = UINavigationController()
        
        window.rootViewController = navigationController
        
        let photoSearchController = photoSearchVC()
        photoSearchController.viewModel = FlickrPhotoSearchVM(api: api)
        navigationController.viewControllers = [photoSearchController]
    }
    
    fileprivate func photoSearchVC() -> FlickrPhotoSearchViewController {
        return UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "FlickrPhotoSearchViewController") as! FlickrPhotoSearchViewController
    }
}

