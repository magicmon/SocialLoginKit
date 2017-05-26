//
//  FacebookKitApplication.swift
//  FacebookKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit

import FBSDKCoreKit
import FBSDKLoginKit

extension FacebookKit: SocialLoginKitApplicationProtocol {
    //MARK: - ApplicationdidFinishLaunchingWithOptions
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
    }

    //MARK: - ApplicationdidDidBecomeActive
    func handleDidBecomeActive(application: UIApplication) {
        FBSDKAppEvents.activateApp()
    }

    //MARK: - Scheme
    func handleWithUrl(application: UIApplication?, openURL url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        return FBSDKApplicationDelegate.sharedInstance().application(application, open:url, sourceApplication: sourceApplication, annotation: annotation)
    }

    //MARK: - ApplicationdidDidEnterBackground
    func handleDidEnterBackground(application: UIApplication) {

    }
}
