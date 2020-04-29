//
//  AppDelegate.swift
//  PictureGallery
//
//  Created by Anuj Rai on 27/04/20.
//  Copyright © 2020 Anuj Rai. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customisation after application launch.
        defer { window?.makeKeyAndVisible() }

        let rootViewController = UIStoryboard.instantiateViewcontroller(ofType: RootViewController.self)
        let rootNavigationController = UINavigationController.init(rootViewController: rootViewController)

        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = rootNavigationController
        return true
    }

}

