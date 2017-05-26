//
//  SocialLoginKitLoginProtocol.swift
//  SocialLoginKit
//
//  Created by magicmon on 2017. 5. 26..
//
//

import UIKit

protocol SocialLoginKitLoginProtocol {
    /**
     로그인.
     
     - parameter isAutoLogin:    자동로그인 처리 여부. true로 설정 시 accessToken에 대한 만료 시간을 검사 후 로그인 시도.
     - parameter fromViewController:    인앱 브라우저로 로그인 처리 시 base가 되는 viewController
     */
    func login(isAutoLogin: Bool, fromViewController: UIViewController)
    
    /**
     로그아웃. 어플리케이션에 저장된 접근 토큰(access token)과 갱신 토큰(refresh token)을 삭제
     
     - parameter withServerToken: 서버에 저장된 정보도 해제할지 여부.
     */
    func logout(withServerToken: Bool)
    
    /**
     엑세스 토큰을 얻어온다
     
     - returns: 엑세스 토큰이 존재하면 해당 값을 리턴.
     */
    func accessToken() -> String?
    
    /**
     현재 세션이 유지중인지 검사
     
     - returns: 현재 세션이 유지중이라면 true, 그렇지 않으면 false 반환
     */
    func isValidAccessToken() -> Bool
    
    /**
     액세스 토큰을 갱신한다
     */
    func refreshAccessToken()
}
