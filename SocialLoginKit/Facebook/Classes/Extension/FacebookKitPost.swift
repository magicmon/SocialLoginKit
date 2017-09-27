//
//  FacebookKitPost.swift
//  FacebookKit
//
//  FacebookKitPost.swift
//  FacebookKit
//
//  Created by magicmon on 2017. 5. 26..
//

import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

extension FacebookKit: SocialLoginKitPostProtocol {
    func post(message: String, imageURL: String?, contentURL: String?, customInfo: [String: Any]?, from viewController: UIViewController) {
//        let shareContent  = FBSDKShareLinkContent()
//        
//        if let contentURL = contentURL {
//            shareContent.contentURL = URL(string: contentURL)
//        }
//        
//        if let hashtag = customInfo?[kSocialLoginKitPostHashtag] as? String {
//            shareContent.hashtag = FBSDKHashtag(string: hashtag)
//        }
//        
//        if let quote = customInfo?[kSocialLoginKitPostQuote] as? String {
//            shareContent.quote = quote
//        }
//        
//        // 쓰기 권한이 없다면 에러 반환
//        guard let publishPermissions = self.publishPermissions else {
//            self.delegate?.didFailTask(socialType: .facebook, connectType: .post, errorType: .permission, error: nil)
//            return
//        }
//        
//        if let _ = FBSDKAccessToken.current(), hasGrantedPermissions(permissions: publishPermissions) {
//            FBSDKShareAPI.share(with: shareContent, delegate: self)
//        } else {
//            logInWithPublishPermissions(content: shareContent, permissions: publishPermissions, from: viewController)
//        }
        
        
        guard let contentURL = contentURL else {
            let error = NSError(domain: "facebook.com", code: 500, userInfo: ["message": "not initalized contentURL"])
            delegate?.didFailTask(socialType: .facebook, connectType: .post, errorType: .noData, error: error)
            
            return
        }
        
        let shareContent = FBSDKShareLinkContent()
        
        shareContent.contentURL = URL(string: contentURL)
        
        if let hashtag = customInfo?[kSocialLoginKitPostHashtag] as? String {
            if hashtag.hasPrefix("#") {
                shareContent.hashtag = FBSDKHashtag(string: hashtag)
            } else {
                shareContent.hashtag = FBSDKHashtag(string: "#\(hashtag)")
            }
        }
        
        if let quote = customInfo?[kSocialLoginKitPostQuote] as? String {
            shareContent.quote = quote
        }
        
        FBSDKShareDialog.show(from: viewController, with: shareContent, delegate: self)
    }
}

extension FacebookKit: FBSDKSharingDelegate {
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        if let _ = results["postId"] {
            self.delegate?.didSuccessTask(socialType: .facebook, connectType: .post)
        } else {
            self.delegate?.didFailTask(socialType: .facebook, connectType: .post, errorType: .userCancel, error: nil)
        }
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        // 포스팅 하다 에러 난 경우 AccessToken을 업데이트
        // 그래도 에러가 발생한다면 에러를 사용자에게 알림
        FBSDKAccessToken.refreshCurrentAccessToken { (connection, object, error) in
            if let error = error {
                self.delegate?.didFailTask(socialType: .facebook, connectType: .post, errorType: .unknown, error: error)
            }
        }
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        self.delegate?.didFailTask(socialType: .facebook, connectType: .post, errorType: .userCancel, error: nil)
    }
}
