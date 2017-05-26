//
//  SocialLoginKitApplicationProtocol.swift
//  SocialLoginKit
//
//  Created by magicmon on 2017. 5. 26..
//
//

import UIKit

protocol SocialLoginKitApplicationProtocol {
    /**
     어플리케이션 시작 시 설정 해야할 값.
     AppDelegate.swift의 application(_:)를 그대로 내부로 전달.
     */
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?)
    
    /**
     외부에서 Scheme을 통해 앱 진입 시 설정.
     AppDelegate.swift의 handleWithUrl(_:)를 그대로 내부로 전달.
     */
    func handleWithUrl(application: UIApplication?, openURL url: URL, sourceApplication: String?, annotation: Any?) -> Bool
    
    /**
     앱이 활성화 됐을 때 설정.
     AppDelegate.swift의 handleDidBecomeActive(_:)를 그대로 내부로 전달.
     */
    func handleDidBecomeActive(application: UIApplication)
    
    /**
     앱이 백그라운드로 들어갔을 때 설정.
     AppDelegate.swift의 handleDidEnterBackground(_:)를 그대로 내부로 전달.
     */
    func handleDidEnterBackground(application: UIApplication)
}
