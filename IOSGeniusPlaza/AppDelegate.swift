//
//  AppDelegate.swift
//  IOSGeniusPlaza
//
//  Created by Jeffrey Chang on 5/9/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow()
        window?.makeKeyAndVisible()
        let homeTableVC = createHomeViewController()
        window?.rootViewController = homeTableVC
        return true
    }
    
    private func createHomeViewController() -> HomeTableViewController {
        let movieNetworkService = NetworkService(mediaType: .movie)
        let movieViewModel = HomeViewModel(mediaService: movieNetworkService)
        let podCastNetworkService = NetworkService(mediaType: .podCast)
        let podCastViewModel = HomeViewModel(mediaService: podCastNetworkService)
        return HomeTableViewController(movieViewModel: movieViewModel, podCastViewModel: podCastViewModel)
    }
}

