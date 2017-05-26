//
//  FacebookKitInvite.swift
//  FacebookKit
//
//  Created by magicmon on 2017. 5. 26..
//
//

import FBSDKCoreKit
import FBSDKShareKit
import FBSDKLoginKit

extension FacebookKit: SocialLoginKitInviteProtocol {
    func invite(fromController: UIViewController?, inviteLink: String, imageURL: String?, message: String?, customInfo: [String: Any]?) {
        
        let content = FBSDKAppInviteContent()
        content.destination = .facebook
        content.appLinkURL = URL(string: inviteLink)
        if let imageURL = imageURL {
            content.appInvitePreviewImageURL = URL(string: imageURL)
        }
        
        if let fromController = fromController {
            FBSDKAppInviteDialog.show(from: fromController, with: content, delegate: self)
        }
    }
}

extension FacebookKit: FBSDKAppInviteDialogDelegate {
    func appInviteDialog(_ appInviteDialog: FBSDKAppInviteDialog!, didCompleteWithResults results: [AnyHashable : Any]!) {
        if results != nil {
            
            let complete = results["didComplete"] as? Bool
            let completionGesture = results["completionGesture"] as? String
            
            // cancel
            if let completionGesture = completionGesture, completionGesture == "cancel" {
                self.delegate?.didFailTask(socialType: .facebook, connectType: .invite, errorType: .userCancel, error: nil)
                
                return
            }
            
            // success
            if let complete = complete, complete == true {
                self.delegate?.didSuccessTask(socialType: .facebook, connectType: .invite)
                
                return
            }
            
            self.delegate?.didFailTask(socialType: .facebook, connectType: .invite, errorType: .unknown, error: nil)
        } else {
            self.delegate?.didFailTask(socialType: .facebook, connectType: .invite, errorType: .userCancel, error: nil)
        }
    }
    
    func appInviteDialog(_ appInviteDialog: FBSDKAppInviteDialog!, didFailWithError error: Error!) {
        self.delegate?.didFailTask(socialType: .facebook, connectType: .invite, errorType: .unknown, error: error)
    }
}
