//
//  SocialLoginKit.swift
//  SocialLoginKit
//
//  Created by magicmon on 2017. 5. 26..
//
//

import UIKit

public enum SocialLoginKitType: String {
    case facebook   = "FACEBOOK"
    case naver      = "NAVER"
    case kakao      = "KAKAO"
    
    static let allValues = [facebook, naver, kakao]
}

// 요청타입
public enum SocialLoginKitTaskType: Int {
    case login              /// 로그인
    case logout             /// 로그아웃
    case userProfile        /// 유저정보
    case post               /// 글 업로드
    case invite             /// 친구 초대
}

// 에러타입
public enum SocialLoginKitErrorType: Int {
    case userCancel         /// 유저의 의한 취소
    case userNotFound       /// 유저 정보를 찾을 수 없음
    case permission         /// 일치하지 않는 권한
    case tokenExpired       /// 토큰 만료
    case notInstalled       /// 해당 앱이 설치 안됨(카카오톡, 네이버의 경우 해당, 페이스북은 web browser로 진행)
    case noData             /// 입력 데이터가 존재하지 않음
    case connection         /// 커넥션 에러
    case unknown            /// 의도치 않는 취소
}


public let kSocialLoginKitPostHashtag         = "kSocialLoginKitPostHashtag"
public let kSocialLoginKitPostQuote           = "kSocialLoginKitPostQuote"


public class SocialLoginKit: NSObject {
    static public let sharedInstance: SocialLoginKit = SocialLoginKit()
    
    
    private override init() {
        // 설정 정보는 Info.plist의 SocialLoginKitKey의 Key를 통해 저장
        // plist 검색 후 설정이 없으면 에러를 내 뱉음
        guard let socials = Bundle.main.infoDictionary?["SocialLoginKitKey"] as? [String: Any] else {
            fatalError("not found SocialLoginKit Key at Info.plist")
        }
        
        #if Facebook
            guard let fbReadPermissions = socials["FacebookReadPermissions"] as? [String] else {
                fatalError("not found FacebookReadPermissions at SocialLoginKitKey list")
            }
            FacebookKit.sharedInstance.readPermissions = fbReadPermissions
            
            guard let fbPublishPermissions = socials["FacebookPublishPermissions"] as? [String] else {
                fatalError("not found FacebookPublishPermissions at SocialLoginKitKey list")
            }
            FacebookKit.sharedInstance.publishPermissions = fbPublishPermissions
        #endif
        
        #if Naver
            guard let naverConsumerKey = socials["NaverConsumerKey"] as? String else {
                fatalError("not found NaverConsumerKey at SocialLoginKit list")
            }
            NaverKit.sharedInstance.consumerKey = naverConsumerKey
            
            guard let naverConsumerSecret = socials["NaverConsumerSecret"] as? String else {
                fatalError("not found NaverConsumerSecret at SocialLoginKit list")
            }
            NaverKit.sharedInstance.consumerSecret = naverConsumerSecret
            
            guard let naverAppName = socials["NaverAppName"] as? String else {
                fatalError("not found NaverAppName at SocialLoginKit list")
            }
            NaverKit.sharedInstance.appName = naverAppName
            
            guard let serviceURLScheme = socials["NaverServiceURLScheme"] as? String else {
                fatalError("not found NaverServiceURLScheme at SocialLoginKit list")
            }
            NaverKit.sharedInstance.serviceURLScheme = serviceURLScheme
        #endif
    }
    
    
    // MARK: - Delegate
    public weak var delegate: SocialLoginKitDelegate? {
        didSet {
            let socialInstances: [SocialLoginKitProvider] = SocialLoginKitUtil<SocialLoginKitProvider>.socialInstances()
            
            for socialInstance in socialInstances {
                socialInstance.delegate = delegate
                
                #if Naver
                    if let naverInstance = socialInstance as? NaverKit {
                        NaverThirdPartyLoginConnection.getSharedInstance().delegate = naverInstance
                    }
                #endif
            }
        }
    }
}

// MARK: - Application
extension SocialLoginKit {

    public func handleApplication(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
        let socialInstances: [SocialLoginKitApplicationProtocol] = SocialLoginKitUtil<SocialLoginKitApplicationProtocol>.socialInstances()
        
        for socialInstance in socialInstances {
            socialInstance.application(application: application, didFinishLaunchingWithOptions: launchOptions)
        }
    }
    
    public func handleApplicationWithUrl(application: UIApplication?, openURL url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        let socialInstances: [SocialLoginKitApplicationProtocol] = SocialLoginKitUtil<SocialLoginKitApplicationProtocol>.socialInstances()
        
        for socialInstance in socialInstances {
            if socialInstance.handleWithUrl(application: application, openURL: url, sourceApplication: sourceApplication, annotation: annotation) {
                return true
            }
        }
        
        return false
    }
    
    public func handleDidBecomeActive(application: UIApplication) {
        let socialInstances: [SocialLoginKitApplicationProtocol] = SocialLoginKitUtil<SocialLoginKitApplicationProtocol>.socialInstances()
        
        for socialInstance in socialInstances {
            socialInstance.handleDidBecomeActive(application: application)
        }
    }
    
    public func handleDidEnterBackground(application: UIApplication) {
        let socialInstances: [SocialLoginKitApplicationProtocol] = SocialLoginKitUtil<SocialLoginKitApplicationProtocol>.socialInstances()
        
        for socialInstance in socialInstances {
            socialInstance.handleDidEnterBackground(application: application)
        }
    }
}

// MARK: - Login
extension SocialLoginKit {
    public func login(socialType: SocialLoginKitType, isAutoLogin: Bool = false, fromViewController: UIViewController) {
        if let socialInstance: SocialLoginKitLoginProtocol  = SocialLoginKitUtil<SocialLoginKitLoginProtocol>.socialInstance(socialType: socialType) {
            socialInstance.login(isAutoLogin: isAutoLogin, fromViewController: fromViewController)
        }
    }
    
    public func logout(socialType: SocialLoginKitType, withServerToken: Bool = false) {
        if let socialInstance: SocialLoginKitLoginProtocol = SocialLoginKitUtil<SocialLoginKitLoginProtocol>.socialInstance(socialType: socialType) {
            socialInstance.logout(withServerToken: withServerToken)
        }
    }
    
    public func accessToken(socialType: SocialLoginKitType) -> String? {
        if let socialInstance: SocialLoginKitLoginProtocol = SocialLoginKitUtil<SocialLoginKitLoginProtocol>.socialInstance(socialType: socialType) {
            return socialInstance.accessToken()
        }
        
        return nil
    }
    
    public func isValidAccessToken(socialType: SocialLoginKitType) -> Bool {
        if let socialInstance: SocialLoginKitLoginProtocol = SocialLoginKitUtil<SocialLoginKitLoginProtocol>.socialInstance(socialType: socialType) {
            return socialInstance.isValidAccessToken()
        }
        
        return false
    }
    
    public func refreshAccessToken(socialType: SocialLoginKitType) {
        if let socialInstance: SocialLoginKitLoginProtocol = SocialLoginKitUtil<SocialLoginKitLoginProtocol>.socialInstance(socialType: socialType) {
            return socialInstance.refreshAccessToken()
        }
    }
}

// MARK: - User Profile
extension SocialLoginKit {
    public func requestUserProfile(socialType: SocialLoginKitType) {
        if let socialInstance: SocialLoginKitUserProtocol = SocialLoginKitUtil<SocialLoginKitUserProtocol>.socialInstance(socialType: socialType) {
            socialInstance.requestUserProfile()
        }
    }
    
    public func userProfile(socialType: SocialLoginKitType) -> SocialLoginKitUserProfile? {
        if let socialInstance: SocialLoginKitUserProtocol = SocialLoginKitUtil<SocialLoginKitUserProtocol>.socialInstance(socialType: socialType) {
            return socialInstance.getUserProfile()
        }
        return nil
    }
}

// MARK: - Post
extension SocialLoginKit {
    public func post(socialType: SocialLoginKitType,
                     message: String,
                     imageURL: String? = nil,
                     contentURL: String? = nil,
                     customInfo: [String: Any]? = nil,
                     from viewController: UIViewController) {
        if let socialInstance: SocialLoginKitPostProtocol = SocialLoginKitUtil<SocialLoginKitPostProtocol>.socialInstance(socialType: socialType) {
            socialInstance.post(message: message, imageURL: imageURL, contentURL: contentURL, customInfo: customInfo, from: viewController)
        }
    }
}

// MARK: - Invite
extension SocialLoginKit {
    public func invite(socialType: SocialLoginKitType, fromController: UIViewController?, inviteLink: String, imageURL: String?, message: String, customInfo: [String: Any]?) {
        if let socialInstance: SocialLoginKitInviteProtocol = SocialLoginKitUtil<SocialLoginKitInviteProtocol>.socialInstance(socialType: socialType) {
            socialInstance.invite(fromController: fromController, inviteLink: inviteLink, imageURL: imageURL, message: message, customInfo: customInfo)
        }
    }
}
