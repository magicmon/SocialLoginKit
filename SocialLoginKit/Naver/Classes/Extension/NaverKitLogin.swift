//
//  NaverKitLoginExtension.swift
//  NaverKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit


extension NaverKit: SocialLoginKitLoginProtocol {
    func login(isAutoLogin: Bool = true, fromViewController: UIViewController) {
        self.fromViewController = fromViewController
        guard let loginConn = NaverThirdPartyLoginConnection.getSharedInstance() else {
            let error = NSError(domain: "NaverKit", code: 500, userInfo: [NSLocalizedDescriptionKey: "not initalized sharedInstance"])
            delegate?.didFailTask(socialType: .naver, connectType: .login, errorType: .connection, error: error)
            
            return
        }

        if isAutoLogin {
            if loginConn.isValidAccessTokenExpireTimeNow() {
                delegate?.didSuccessTask(socialType: .naver, connectType: .login)
            } else {
                loginConn.requestThirdPartyLogin()
            }
        } else {
            logout(withServerToken: false)
            loginConn.requestThirdPartyLogin()
        }
    }

    func logout(withServerToken: Bool = false) {
        self.userProfile = nil

        if withServerToken {
            NaverThirdPartyLoginConnection.getSharedInstance().requestDeleteToken()
        } else {
            NaverThirdPartyLoginConnection.getSharedInstance().resetToken()
        }

        delegate?.didSuccessTask(socialType: .naver, connectType: .logout)
    }

    func accessToken() -> String? {
        let token = NaverThirdPartyLoginConnection.getSharedInstance().accessToken

        if let token = token {
            return token
        }

        return nil
    }

    func isValidAccessToken() -> Bool {
        return NaverThirdPartyLoginConnection.getSharedInstance().isValidAccessTokenExpireTimeNow()
    }
    
    func refreshAccessToken() {
        NaverThirdPartyLoginConnection.getSharedInstance().requestAccessTokenWithRefreshToken()
    }
}

extension NaverKit: NaverThirdPartyLoginConnectionDelegate {
    
    func oauth20ConnectionDidOpenInAppBrowser(forOAuth request: URLRequest!) {
        guard let inAppBrowserViewController = NLoginThirdPartyOAuth20InAppBrowserViewController(request: request) else {
            return
        }
        
        if let baseViewController = self.fromViewController {
            baseViewController.present(inAppBrowserViewController, animated: false, completion: nil)
        }
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        delegate?.didSuccessTask(socialType: .naver, connectType: .login)
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        delegate?.didSuccessTask(socialType: .naver, connectType: .login)
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        delegate?.didSuccessTask(socialType: .naver, connectType: .logout)
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print(oauthConnection.state())
        
        //TODO: task 지정을 해야함
        if isValidAccessToken() {
            delegate?.didFailTask(socialType: .naver, connectType: .logout, errorType: .unknown, error: error)
        } else {
            delegate?.didFailTask(socialType: .naver, connectType: .login, errorType: .unknown, error: error)
        }
    }
}
