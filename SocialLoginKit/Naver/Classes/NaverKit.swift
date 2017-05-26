//
//  NaverKit.swift
//  NaverKit
//
//  Created by magicmon on 2017. 5. 26..
//

import Foundation

class NaverKit: SocialLoginKitProvider {
    
    // NaverKit의 singleton
    static let sharedInstance: NaverKit = NaverKit()
    
    // 사용자 프로필
    var userProfile: NaverKitUserProfile?
    var currentElement: String = ""
    var fromViewController: UIViewController?

    /// 네이버 로그인 개발자 사이트에서 발급받은 Client ID
    var consumerKey: String {
        set {
            NaverThirdPartyLoginConnection.getSharedInstance().consumerKey = newValue
        } get {
            return NaverThirdPartyLoginConnection.getSharedInstance().consumerKey
        }
    }

    /// 네이버 로그인 개발자 사이트에서 발급받은 Client Secret
    var consumerSecret: String {
        set {
            NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret = newValue
        } get {
            return NaverThirdPartyLoginConnection.getSharedInstance().consumerSecret
        }
    }

    /// 네이버 로그인 개발자 사이트에서 지정했던 앱 이름
    var appName: String {
        set {
            NaverThirdPartyLoginConnection.getSharedInstance().appName = newValue
        } get {
            return NaverThirdPartyLoginConnection.getSharedInstance().appName
        }
    }

    /// 네이버 로그인 개발자 사이트에서 지정했던 앱의 URL Scheme
    var serviceURLScheme: String {
        set {
            NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme = newValue
        } get {
            return NaverThirdPartyLoginConnection.getSharedInstance().serviceUrlScheme
        }
    }

    //MARK: - Initalize
    override init() {
        let loginConn: NaverThirdPartyLoginConnection = NaverThirdPartyLoginConnection.getSharedInstance()
        loginConn.isNaverAppOauthEnable = true
        loginConn.isInAppOauthEnable = true

        // 네이버 로그인 라이브러리의 버전을 표시
        if let version = loginConn.getVersion() {
            print("libNaverLogin.a version : \(version)")
        }
    }
}
