//
//  SocialLoginKitUtil.swift
//  SocialLoginKit
//
//  Created by magicmon on 2017. 5. 26..
//
//

import UIKit

class SocialLoginKitUtil<T> {
    
    class func socialInstance<T>(socialType: SocialLoginKitType) -> T? {
        
        if socialType == .facebook {
            #if Facebook
                if let instance = FacebookKit.sharedInstance as? T {
                    return instance
                }
            #endif
        } else if socialType == .kakao {
            #if Kakao
                if let instance = KakaoKit.sharedInstance as? T {
                    return instance
                }
            #endif
        } else if socialType == .naver {
            #if Naver
                if let instance = NaverKit.sharedInstance as? T {
                    return instance
                }
            #endif
            
        }
        
        return nil
    }
    
    class func socialInstances<T>() -> [T] {
        var socialInstances = [T]()
        for type in SocialLoginKitType.allValues {
            if let instance: T = SocialLoginKitUtil<T>.socialInstance(socialType: type) {
                socialInstances.append(instance)
            }
        }
        return socialInstances
    }
    
}
