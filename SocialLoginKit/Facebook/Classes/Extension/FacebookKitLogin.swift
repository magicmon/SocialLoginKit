//
//  FacebookKitLogin.swift
//  FacebookKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit

import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit


extension FacebookKit: SocialLoginKitLoginProtocol {
    func login(isAutoLogin: Bool, fromViewController: UIViewController) {
        
        var readPermissions = self.readPermissions ?? ["public_profile", "email", "user_friends"]
        
        // 자동 로그인이 돼 있는지 여부 처리
        if isAutoLogin && isValidAccessToken() {
            FBSDKAccessToken.refreshCurrentAccessToken { (connection, object, error) in
                if let error = error {
                    // 토큰 갱신 시 만료 됐기 때문에 다시 권한 요청
                    self.logInWithReadPermissions(fromViewController: fromViewController, permissions: readPermissions)
                } else {
                    self.delegate?.didSuccessTask(socialType: .facebook, connectType: .login)
                }
            }
            return
        } else {
            FBSDKLoginManager().logOut()
            
            // 읽기 권한으로 로그인 시도
            logInWithReadPermissions(fromViewController: fromViewController, permissions: readPermissions)
        }
    }
    
    func logout(withServerToken: Bool) {
        FBSDKLoginManager().logOut()
        self.delegate?.didSuccessTask(socialType: .facebook, connectType: .logout)
    }

    func accessToken() -> String? {
        
        guard let accessToken = FBSDKAccessToken.current() else {
            return nil
        }
        
        let token = accessToken.tokenString
        
        if let token = token, token.characters.count > 0 {
            return token
        }
        
        return nil
    }

    func isValidAccessToken() -> Bool {
        
        // 토큰이 없으면 false
        guard let accessToken = FBSDKAccessToken.current() else {
            return false
        }
        
        // 이미 토큰이 만료 됐으면 false
        if NSDate().compare(accessToken.expirationDate) == .orderedDescending {
            return false
        }
        
        return true
    }
    
    func refreshAccessToken() {
        FBSDKAccessToken.refreshCurrentAccessToken { (connection, object, error) in
            
        }
    }
}

extension FacebookKit {
    /**
     읽기 권한으로 로그인 시도
     
     - parameter fromViewController: base가 될 Controller
     - parameter permissions: 로그인 시도 시 요청할 퍼미션
     */
    func logInWithReadPermissions(fromViewController: UIViewController, permissions: [String]) {
        FBSDKLoginManager().logIn(
            withReadPermissions: permissions,
            from: fromViewController,
            handler: { (loginResult, error) in
                if let error = error {
                    self.delegate?.didFailTask(socialType: .facebook, connectType:.login, errorType: .unknown, error: error)
                } else {
                    if let loginResult = loginResult, loginResult.isCancelled {
                        self.delegate?.didFailTask(socialType: .facebook, connectType: .login, errorType: .userCancel, error: nil)
                        return 
                    }
                    
                    self.delegate?.didSuccessTask(socialType: .facebook, connectType: .login)
                }
        })
    }
    
    /**
     쓰기 권한으로 로그인 시도
     
     - parameter content: 업로드 할 컨텐츠
     - parameter permissions: 로그인 시도 시 요청할 퍼미션
     */
    func logInWithPublishPermissions(content: FBSDKShareLinkContent, permissions: [String]) {
        FBSDKLoginManager().logIn(withPublishPermissions: permissions, handler: { (loginResult, error) in
            if let error = error {
                self.delegate?.didFailTask(socialType: .facebook, connectType: .post, errorType: .unknown, error: error)
            } else {
                if let loginResult = loginResult, loginResult.isCancelled {
                    self.delegate?.didFailTask(socialType: .facebook, connectType: .post, errorType: .userCancel, error: nil)
                    return
                }
                
                FBSDKShareAPI.share(with: content, delegate: self)
            }
        })
    }
}
