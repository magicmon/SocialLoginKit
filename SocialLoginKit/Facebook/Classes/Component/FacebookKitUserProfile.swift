//
//  FabeookKitUserProfile.swift
//  FacebookKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit

public class FacebookKitUserProfile: SocialLoginKitUserProfile {
    let defaultImageSize = CGSize(width: 1080, height: 1080)

    public var gender: String?

    init(FBProfile: FBSDKProfile?, data: Any?) {
        super.init()
        
        if let userId = FBProfile?.userID {
            self.userID = userId
        }

        if let name = FBProfile?.name {
            self.name = name
            self.nickname = name
        }

        self.profileImagePath = FBProfile?.imageURL(for: .normal, size: defaultImageSize)?.absoluteString

        if let profileData = data as? [String: Any], let email = profileData["email"] as? String {
            self.email = email
        }
    }
}
