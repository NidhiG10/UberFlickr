//
//  AppDelegate.swift
//  UberFlickr
//
//  Created by Nidhi Goyal on 23/06/18.
//  Copyright © 2018 Nidhi Goyal. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navigation: ApplicationNavigation?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        let apiKey = "3e7cc266ae2b0e0d78e279ce8e361736"
        let window = UIWindow(frame: UIScreen.main.bounds)
        
        navigation = ApplicationNavigation(window: window, apiKey:apiKey)
        self.window = window
        
        window.makeKeyAndVisible()
        return true
    }
    

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
    }

    func applicationWillTerminate(_ application: UIApplication) {
    }


}

