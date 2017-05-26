//
//  NaverKitApplication.swift
//  NaverKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit

extension NaverKit: SocialLoginKitApplicationProtocol {

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {

    }

    func handleWithUrl(application: UIApplication?, openURL url: URL, sourceApplication: String?, annotation: Any?) -> Bool {
        guard let loginConn = NaverThirdPartyLoginConnection.getSharedInstance() else {
            return false
        }

        if url.scheme == loginConn.serviceUrlScheme {
            if url.host == kCheckResultPage {
                // 네이버앱으로부터 전달받은 url값을 NaverThirdPartyLoginConnection의 인스턴스에 전달

                guard let thirdConnection = NaverThirdPartyLoginConnection.getSharedInstance() else {
                    let error = NSError(domain: "NaverKit", code: 500, userInfo: [NSLocalizedDescriptionKey: "not initalized sharedInstance"])
                    delegate?.didFailTask(socialType: .naver, connectType: .login, errorType: .connection, error: error)
                    
                    return false
                }
                
                let resultType: THIRDPARTYLOGIN_RECEIVE_TYPE = thirdConnection.receiveAccessToken(url)

                var errorMessage: String? = nil

                switch resultType {
                case SUCCESS:
                    break
                case PARAMETERNOTSET:
                    errorMessage = "Naver ThirdPartyLoginConnection Error - parameter not set"
                case CANCELBYUSER:
                    errorMessage = "Naver ThirdPartyLoginConnection Error - cancel by user"
                case NAVERAPPNOTINSTALLED:
                    errorMessage = "Naver ThirdPartyLoginConnection Error - Naver app not installed"
                case NAVERAPPVERSIONINVALID:
                    errorMessage = "Naver ThirdPartyLoginConnection Error - Naver app version invalid"
                case OAUTHMETHODNOTSET:
                    errorMessage = "Naver ThirdPartyLoginConnection Error - OAuth method not set"
                default:
                    errorMessage = "Naver ThirdPartyLoginConnection Error - Unknown Error"
                }

                if let message = errorMessage {
                    let error = NSError(domain: "NaverKit", code: Int(resultType.rawValue), userInfo: [NSLocalizedDescriptionKey: message])
                    delegate?.didFailTask(socialType: .naver, connectType: .login, errorType: .unknown, error: error)
                }
            }

            return true
        }

        return false

    }

    func handleDidBecomeActive(application: UIApplication) {

    }

    func handleDidEnterBackground(application: UIApplication) {

    }
}
