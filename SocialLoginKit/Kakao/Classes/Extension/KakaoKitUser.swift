//
//  KakaoKitUser.swift
//  KakaoKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit


extension KakaoKit: SocialLoginKitUserProtocol {
    func requestUserProfile() {

        // 기존의 유저 정보를 삭제하고 새로 프로필 작성
        self.userProfile = nil
        userProfile = KakaoKitUserProfile()

        KOSessionTask.meTask(withSecureResource: true) { (object, error) in
            if error != nil {
                self.delegate?.didFailTask(socialType: .kakao, connectType: .userProfile, errorType: .unknown, error: error)
            } else {
                guard let user = object as? KOUser else {
                    self.delegate?.didFailTask(socialType: .kakao, connectType: .userProfile, errorType: .userNotFound, error: nil)
                    return
                }

                self.userProfile?.setUserProfile(user: user)

                self.delegate?.didSuccessTask(socialType: .kakao, connectType: .userProfile)
            }
        }
    }

    func getUserProfile() -> SocialLoginKitUserProfile? {
        return self.userProfile
    }
}
