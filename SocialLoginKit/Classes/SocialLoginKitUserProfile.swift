//
//  SocialLoginKitUserProfile.swift
//  SocialLoginKit
//
//  Created by magicmon on 2017. 5. 26..
//
//

import UIKit

public class SocialLoginKitUserProfile: NSObject {
    public var userID: String?
    public var nickname: String?
    public var name: String?
    public var email: String?
    public var profileImagePath: String?
    
    public override var description: String {
        get {
            var profileDescription: [String] = []
            
            profileDescription.append("userID: \(userID ?? "")")
            profileDescription.append("nickname: \(nickname ?? "")")
            profileDescription.append("name: \(name ?? "")")
            profileDescription.append("email: \(email ?? "")")
            profileDescription.append("profileImagePath: \(profileImagePath ?? "")")
            
            return profileDescription.joined(separator: "\n")
        }
    }
}
