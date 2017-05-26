//
//  SocialLoginKitUserProtocol.swift
//  SocialLoginKit
//
//  Created by magicmon on 2017. 5. 26..
//
//

import UIKit

protocol SocialLoginKitUserProtocol {
    /**
     사용자 정보를 얻어온다. didSuccessTask()를 통해 성공 알림.
     
     */
    func requestUserProfile()
    
    /**
     저장되어있는 유저 프로필을 가져온다
     
     - returns: 유저정보
     */
    func getUserProfile() -> SocialLoginKitUserProfile?
}
