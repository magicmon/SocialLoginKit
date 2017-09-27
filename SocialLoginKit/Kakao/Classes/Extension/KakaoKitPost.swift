//
//  KakaoKitPost.swift
//  KakaoKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit

extension KakaoKit: SocialLoginKitPostProtocol {
    
    func post(message: String, imageURL: String?, contentURL: String?, customInfo: [String: Any]?, from viewController: UIViewController) {
        post(type: .post, message: message, imageURL: imageURL, contentURL: contentURL, isWebLink: true, customInfo: customInfo)
    }
    
    internal func post(type connectType: SocialLoginKitTaskType, message: String, imageURL: String?, contentURL: String?, isWebLink: Bool, customInfo: [String : Any]?) {
        
        // 앱 설치 유무 확인
        if KLKTalkLinkCenter.shared().canOpenTalkLink() == false {
            self.delegate?.didFailTask(socialType: .kakao, connectType: connectType, errorType: .notInstalled, error: nil)
            return
        }
        
        let template = KLKFeedTemplate { (feedTemplateBuilder) in
            
            // 컨텐츠
            feedTemplateBuilder.content = KLKContentObject(builderBlock: { (contentBuilder) in
                contentBuilder.title = message
                if let imageURL = imageURL, let contentsOfURL = URL(string: imageURL) {
                    contentBuilder.imageURL = contentsOfURL
                }
                contentBuilder.link = KLKLinkObject(builderBlock: { (linkBuilder) in
                    if let contentURL = contentURL {
                        linkBuilder.mobileWebURL = URL(string: contentURL)
                    }
                })
            })
            
            // 버튼
            if isWebLink {
                feedTemplateBuilder.addButton(KLKButtonObject(builderBlock: { (buttonBuilder) in
                    buttonBuilder.title = "웹으로 보기"
                    buttonBuilder.link = KLKLinkObject(builderBlock: { (linkBuilder) in
                        if let contentURL = contentURL {
                            linkBuilder.mobileWebURL = URL(string: contentURL)
                        }
                    })
                }))
            }
            
            feedTemplateBuilder.addButton(KLKButtonObject(builderBlock: { (buttonBuilder) in
                buttonBuilder.title = "앱으로 보기"
                buttonBuilder.link = KLKLinkObject(builderBlock: { (linkBuilder) in
                    if let customInfo = customInfo {
                        var param = [String]()
                        for key in customInfo.keys {
                            if let value = customInfo[key] as? String {
                                param.append("\(key)=\(value)")
                            }
                        }
                        let params = param.joined(separator: "&")
                        
                        linkBuilder.iosExecutionParams = params
                        linkBuilder.androidExecutionParams = params
                    }
                })
            }))
        }
        
        // 카카오링크 실행
        KLKTalkLinkCenter.shared().sendDefault(with: template, success: { [weak self] (warningMsg, argumentMsg) in
            self?.delegate?.didSuccessTask(socialType: .kakao, connectType: connectType)
        }, failure: { [weak self] (error) in
            self?.delegate?.didFailTask(socialType: .kakao, connectType: connectType, errorType: .unknown, error: error)
        })
    }
}
