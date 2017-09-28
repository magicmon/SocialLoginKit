//
//  KakaoKitLogin.swift
//  KakaoKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit


extension KakaoKit: SocialLoginKitLoginProtocol {

    func login(isAutoLogin: Bool, fromViewController: UIViewController) {
        guard let session = KOSession.shared() else {
            let error = NSError(domain: "KakaoKit", code: -999, userInfo: [NSLocalizedDescriptionKey: "session is null"])
            self.delegate?.didFailTask(socialType: .kakao, connectType: .login, errorType: .unknown, error: error)
            
            return
        }
        
        // 자동 로그인 처리
        // 이미 세션이 열려있으면 완료 Delegate 보냄
        if isAutoLogin {
            if session.isOpen() {
                session.presentingViewController = nil
                self.delegate?.didSuccessTask(socialType: .kakao, connectType: .login)
                
                return
            }
        } else {
            session.close()
        }
        
        // 로그인 실행
        session.presentingViewController = fromViewController
        

        session.open(completionHandler: { (error) in
            session.presentingViewController = nil
            
            if session.isOpen() {
                self.delegate?.didSuccessTask(socialType: .kakao, connectType: .login)
            } else {
                
                guard let error = error else {
                    self.delegate?.didFailTask(socialType: .kakao, connectType: .login, errorType: .unknown, error: nil)
                    return
                }
                
                switch ((error as NSError).code) {
                case Int(KOErrorCancelled.rawValue):
                    self.delegate?.didFailTask(socialType: .kakao, connectType: .login, errorType: .userCancel, error: error)
                default:
                    self.delegate?.didFailTask(socialType: .kakao, connectType: .login, errorType: .unknown, error: error)
                }
            }

        }, authParams: nil,
           authTypes: [NSNumber(value: KOAuthType.talk.rawValue), NSNumber(value: KOAuthType.account.rawValue)])
    }
    
    func logout(withServerToken: Bool = false) {
        if withServerToken {
            // 사용자 앱 연결을 완전 해제.
            KOSessionTask.unlinkTask(completionHandler: { (success, error) in
                if success {
                    self.delegate?.didSuccessTask(socialType: .kakao, connectType: .logout)
                } else {
                    self.delegate?.didFailTask(socialType: .kakao, connectType: .logout, errorType: .unknown, error: error)
                }
            })
        } else {
            KOSession.shared().logoutAndClose { (success, error) in
                if success {
                    self.delegate?.didSuccessTask(socialType: .kakao, connectType: .logout)
                } else {
                    self.delegate?.didFailTask(socialType: .kakao, connectType: .logout, errorType: .unknown, error: error)
                }
            }
        }
    }

    func accessToken() -> String? {
        return KOSession.shared().accessToken
    }

    func isValidAccessToken() -> Bool {
        return KOSession.shared().isOpen()
    }
    
    func refreshAccessToken() {
        
    }
}
