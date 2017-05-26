//
//  KakaoKitPost.swift
//  KakaoKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit

extension KakaoKit: SocialLoginKitPostProtocol {
    
    func post(message: String?, imageURL: String?, contentURL: String?, customInfo: [String: Any]?) {
        post(connectType: .post, message: message, imageURL: imageURL, contentURL: contentURL, isWebLink: true, customInfo: customInfo)
    }
    
    func postDialog(fromController: UIViewController?, message: String?, imageURL: String?, contentURL: String?, customInfo: [String : Any]?) {
        post(connectType: .post, message: message, imageURL: imageURL, contentURL: contentURL, isWebLink: true, customInfo: customInfo)
    }
    
    internal func post(connectType connectType: SocialLoginKitTaskType, message: String?, imageURL: String?, contentURL: String?, isWebLink: Bool, customInfo: [String : Any]?) {
        // 앱 설치 유무 확인
        if KOAppCall.canOpenKakaoTalkAppLink() == false {
            self.delegate?.didFailTask(socialType: .kakao, connectType: connectType, errorType: .notInstalled, error: nil)
        }
        
        var linkObject: [KakaoTalkLinkObject] = []
        
        if let message = message {
            if let label = KakaoTalkLinkObject.createLabel(message) {
                linkObject.append(label)
            }
        }
        
        if let imageURL = imageURL {
            if let contentsOfURL = URL(string: imageURL), let data = try? Data(contentsOf: contentsOfURL), let downImage = UIImage(data: data) {
                if let image = KakaoTalkLinkObject.createImage(imageURL, width: Int32(downImage.size.width), height: Int32(downImage.size.height)) {
                    linkObject.append(image)
                }
            } else {
                if let image = KakaoTalkLinkObject.createImage(imageURL, width: 130, height: 130) {
                    linkObject.append(image)
                }
            }
        }
        
        if linkObject.count > 0 {
            
            var actionObject: [KakaoTalkLinkAction] = []
            
            var execparam: [String: Any] = [:]
            
            if let customInfo = customInfo {
                execparam = customInfo
            }
            
            if let androidAppAction = KakaoTalkLinkAction.createAppAction(.android, devicetype: .phone, marketparam: ["referrer": "kakaotalklink"], execparam: execparam) {
                actionObject.append(androidAppAction)
            }
            
            if let iphoneAppAction = KakaoTalkLinkAction.createAppAction(.IOS, devicetype: .phone, marketparam: ["referrer": "kakaotalklink"], execparam: execparam) {
                actionObject.append(iphoneAppAction)
            }
            
            if let contentURL = contentURL, isWebLink == true {
                if let webLinkActionUsingPC = KakaoTalkLinkAction.createWebAction(contentURL) {
                    actionObject.append(webLinkActionUsingPC)
                }
                
                if let webLink = KakaoTalkLinkObject.createWebLink("웹에서 보기", url: contentURL) {
                    linkObject.append(webLink)
                }
            }
            
            if let button = KakaoTalkLinkObject.createAppButton("앱에서 보기", actions: actionObject) {
                linkObject.append(button)
            }
            
            KOAppCall.openKakaoTalkAppLink(linkObject)
        } else {
            self.delegate?.didFailTask(socialType: .kakao, connectType: connectType, errorType: .noData, error: nil)
        }
    }
}
