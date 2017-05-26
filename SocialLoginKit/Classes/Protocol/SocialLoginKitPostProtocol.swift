//
//  SocialLoginKitPostProtocol.swift
//  SocialLoginKit
//
//  Created by magicmon on 2017. 5. 26..
//
//

import UIKit

protocol SocialLoginKitPostProtocol {
    /**
     게시물을 업로드한다
     
     - parameter message: 게시물에 대한 설명
     - parameter imageURL: 이미지 업로드 시 해당 경로(web주소)
     - parameter contentURL: 링크 클릭 시 접근할 경로
     - parameter customInfo: 그 밖에 정보
     */
    func post(message: String?, imageURL: String?, contentURL: String?, customInfo: [String: Any]?)
    
    /**
     게시물을 업로드한다. 업로드 전 다이얼로그를 호출
     
     - parameter fromController: 게시물을 업로드할 컨트롤러
     - parameter message: 게시물에 대한 설명
     - parameter imageURL: 이미지 업로드 시 해당 경로(web주소)
     - parameter contentURL: 링크 클릭 시 접근할 경로
     - parameter customInfo: 그 밖에 정보
     */
    func postDialog(fromController: UIViewController?, message: String?, imageURL: String?, contentURL: String?, customInfo: [String: Any]?)
}
