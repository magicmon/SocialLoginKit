//
//  NaverKitPostPost.swift
//  NaverKit
//
//  Created by magicmon on 2017. 5. 26..
//
//

import UIKit

extension NaverKit: SocialLoginKitPostProtocol {
    func post(message: String?, imageURL: String?, contentURL: String?, customInfo: [String: Any]?) {
        // 앱 설치 유무 확인
    }
    
    func postDialog(fromController: UIViewController?, message: String?, imageURL: String?, contentURL: String?, customInfo: [String : Any]?) {
        
    }
}
