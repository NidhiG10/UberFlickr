//
//  ViewController.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 23/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let gateway: Gateway = NetworkProvider(session: URLSession(configuration: .default))
        let dd = FlickrAPI(gateway: gateway, apiKey: "3e7cc266ae2b0e0d78e279ce8e361736")
        dd.searchPhotos(withText: "hello", page: 1, perPageCount: 50, success: { (photoResultInfo) in
            
        }) { (error) in
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

