//
//  SocialLoginKitInviteProtocol.swift
//  SocialLoginKit
//
//  Created by magicmon on 2017. 5. 26..
//
//

import UIKit

protocol SocialLoginKitInviteProtocol {
    /**
     친구 초대
     
     - parameter fromController: 초대 대화상자를 띄울 컨트롤러
     - parameter inviteLink: 받는 사람이 앱 초대 페이지의 설치/시작 버튼을 클릭할 때 열리는 대화 상자에 대한 앱 링크
     - parameter imageURL: 초대에 사용될 이미지의 URL
     - parameter message: 초대 메시지
     - parameter customInfo: 그 밖의 정보(deep link 등)
     */
    func invite(fromController: UIViewController?, inviteLink: String, imageURL: String?, message: String?, customInfo: [String: Any]?)
}
