//
//  KakaoKit.swift
//  KakaoKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit

class KakaoKit: SocialLoginKitProvider {

    // KakaoKit의 singleton
    static let sharedInstance: KakaoKit = KakaoKit()
    
    // 카카오 로그인 사용자의 프로필
    var userProfile: KakaoKitUserProfile?

    override init() {
        print("KakaoOpenSDK.framework version : \(KAKAO_SDK_IOS_VERSION_STRING)")
    }
}
