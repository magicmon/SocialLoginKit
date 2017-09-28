//
//  KakaoKitUserProfile.swift
//  KakaoKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit

public class KakaoKitUserProfile: SocialLoginKitUserProfile {
    public var gender: String?
    public var age: String?
    public var thumnailImagePath: String?

    func setUserProfile(user: KOUser) {
        if let userId = user.id {
            self.userID = "\(userId)"
        }
        self.nickname = user.properties?["nickname"] as? String
        self.name = user.properties?["name"] as? String
        self.gender = user.properties?["gender"] as? String
        self.age = user.properties?["age"] as? String
        self.profileImagePath = user.properties?["profile_image"] as? String
        self.thumnailImagePath = user.properties?["thumbnail_image"] as? String
    }
}
