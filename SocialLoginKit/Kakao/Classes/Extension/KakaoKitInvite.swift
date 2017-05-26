//
//  KakaoKitInvite.swift
//  KakaoKit
//
//  Created by magicmon on 2017. 5. 26..
//
//

import UIKit

extension KakaoKit: SocialLoginKitInviteProtocol {
    func invite(fromController: UIViewController?, inviteLink: String, imageURL: String?, message: String?, customInfo: [String: Any]?) {
        post(connectType: .invite, message: message, imageURL: imageURL, contentURL: inviteLink, isWebLink: false, customInfo: customInfo)
    }
}
