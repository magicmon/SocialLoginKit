//
//  KakaoKitApplication.swift
//  KakaoKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit


extension KakaoKit: SocialLoginKitApplicationProtocol {
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        
    }
    
    func handleWithUrl(application: UIApplication?, openURL url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        return KOSession.handleOpen(url)
    }
    
    func handleDidBecomeActive(application: UIApplication) {
        KOSession.handleDidBecomeActive()
    }
    
    func handleDidEnterBackground(application: UIApplication) {
        KOSession.handleDidEnterBackground()
    }
}
