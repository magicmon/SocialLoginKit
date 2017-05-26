//
//  FacebookKitUser.swift
//  FacebookKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit

import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

extension FacebookKit: SocialLoginKitUserProtocol {
    //MARK: Infomation
    /**
     *  사용자 정보를 얻어온다
     *
     *  acFBProfileDidSuccess(), acFBProfileDidFail()을 통해 결과 확인
     */
    func requestUserProfile() {
        if isValidAccessToken() == false {
            self.delegate?.didFailTask(socialType: .facebook, connectType: .userProfile, errorType: .tokenExpired, error: nil)
            return
        }

        guard let graphRequest = FBSDKGraphRequest(graphPath: "me", parameters: ["fields": "email"]) else {
            self.delegate?.didFailTask(socialType: .facebook, connectType: .userProfile, errorType: .connection, error: nil)
            return
        }
        
        graphRequest.start(completionHandler: { (connection, result, error) -> Void in
            if let error = error {
                self.delegate?.didFailTask(socialType: .facebook, connectType: .userProfile, errorType: .unknown, error: error)
            } else {
                self.userProfile = FacebookKitUserProfile(FBProfile: FBSDKProfile.current(), data: result)
                self.delegate?.didSuccessTask(socialType: .facebook, connectType: .userProfile)
            }
        })
    }

    func getUserProfile() -> SocialLoginKitUserProfile? {
        return self.userProfile
    }
}
