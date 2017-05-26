//
//  FacebookKit.swift
//  FacebookKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit

import FBSDKCoreKit
import FBSDKLoginKit
import FBSDKShareKit

class FacebookKit: SocialLoginKitProvider {
    
    // FacebookKit의 싱글턴
    static let sharedInstance: FacebookKit = FacebookKit()
    
    /**
     페이스북 권한 설정을 저장. 앱의 Info.plist에서 값을 얻어옴
     Info.plist에 아래 추가
     
     <key>SocialLoginKitKey</key>
       <dict>
         <key>FacebookReadPermissions</key>
         <array>
           <string>public_profile</string>
           <string>email</string>
           <string>user_friends</string>
         </array>
         <key>FacebookPublishPermissions</key>
         <array>
           <string>publish_actions</string>
         </array>
     </dict>
     */
    var readPermissions: [String]?      // 읽기 권한
    var publishPermissions: [String]?   // 쓰기 권한
    
    // 페이스북 로그인 사용자의 프로필
    var userProfile: FacebookKitUserProfile?
    
    override init() {
        FBSDKProfile.enableUpdates(onAccessTokenChange: true)
        
        if let sdkVersion = FBSDKSettings.sdkVersion() {
            print("FBSDKCoreKit version : \(sdkVersion)")
        }
    }

    /**
     기존의 퍼미션이 동일한지 체크

     - parameter permissions: 퍼미션
     - returns: 퍼미션이 같으면 true and false
     */
    func hasGrantedPermissions(permissions: [String]) -> Bool {
        guard let token = FBSDKAccessToken.current() else {
            return false
        }

        for permission in permissions {
            if token.hasGranted(permission) == false {
                return false
            }
        }

        return true
    }
}
