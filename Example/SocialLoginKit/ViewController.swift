//
//  ViewController.swift
//  SocialLoginKit
//
//  Created by magicmon on 2017. 5. 26..
//  Copyright (c) 2017 magicmon. All rights reserved.
//

import UIKit
import SocialLoginKit

class ViewController: UIViewController {

    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let navi = segue.destination as? UINavigationController, let vc = navi.viewControllers.first as? ProfileViewController {
            vc.socialType = sender as? SocialLoginKitType
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SocialLoginKit.shared.delegate = self
    }
    
    @IBAction func tappedKakaoLogin() {
        SocialLoginKit.shared.login(socialType: .kakao, isAutoLogin: false, fromViewController: self)
    }
    
    @IBAction func tappedFacebookLogin() {
        SocialLoginKit.shared.login(socialType: .facebook, isAutoLogin: false, fromViewController: self)
    }
    
    @IBAction func tappedNaverLogin() {
        SocialLoginKit.shared.login(socialType: .naver, isAutoLogin: false, fromViewController: self)
    }
}

extension ViewController: SocialLoginKitDelegate {
    func didSuccessTask(socialType: SocialLoginKitType, connectType: SocialLoginKitTaskType) {
        
        switch connectType {
        case .login:
            if let accessToken = SocialLoginKit.shared.accessToken(socialType: socialType) {
                print("accessToken: \(accessToken)")
            }
            
            performSegue(withIdentifier: "ProfileView", sender: socialType)
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

