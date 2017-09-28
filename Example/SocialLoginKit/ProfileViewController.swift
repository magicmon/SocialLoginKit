//
//  ProfileViewController.swift
//  SocialLoginKit
//
//  Created by Taewoo Kang on 2017. 9. 28..
//  Copyright © 2017년 CocoaPods. All rights reserved.
//

import UIKit
import SocialLoginKit

class ProfileViewController: UIViewController {
    
    var socialType: SocialLoginKitType?
    
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        if let socialType = socialType {
            SocialLoginKit.shared.delegate = self
            SocialLoginKit.shared.requestUserProfile(socialType: socialType)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func tappedLogout() {
        if let socialType = socialType {
            SocialLoginKit.shared.logout(socialType: socialType)
        }
    }
    
    deinit {
        SocialLoginKit.shared.delegate = nil
    }
}

extension ProfileViewController: SocialLoginKitDelegate {
    func didSuccessTask(socialType: SocialLoginKitType, connectType: SocialLoginKitTaskType) {
        
        switch connectType {
        case .userProfile:
            if let userProfile = SocialLoginKit.shared.userProfile(socialType: socialType) {
                textView.text = userProfile.description
            }
        case .logout:
            navigationController?.dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    func didFailTask(socialType: SocialLoginKitType, connectType: SocialLoginKitTaskType, errorType: SocialLoginKitErrorType, error: Error?) {
        if let description = error?.localizedDescription {
            print("\(description)")
        }
    }
}
