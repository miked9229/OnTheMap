//
//  AppDelegate.swift
//  OnTheMap
//
//  Created by Michael Doroff on 2/25/17.
//
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var studentLocations = [StudentLocation]()
    var userLocation: String = ""
    


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }


}

