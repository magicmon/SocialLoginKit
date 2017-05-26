//
//  NaverKitUser.swift
//  NaverKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit

extension NaverKit: SocialLoginKitUserProtocol {
    func requestUserProfile() {
        NaverKitNetwork.sharedInstance.getUserProfile(successHandler: { (httpCode, response) in
            if let profile = response?["userProfile"] {
                if let data = profile as? Data {
                    let parser = XMLParser(data: data)
                    parser.delegate = self
                    parser.parse()
                } else {
                    // error delegate
                    let error = NSError(domain: "NaverKit", code: -900, userInfo: [NSLocalizedDescriptionKey: "convert error"])
                    self.delegate?.didFailTask(socialType: .naver, connectType: .userProfile, errorType: .unknown, error: error)
                }
            } else {
                // error delegate
                let error = NSError(domain: "NaverKit", code: -901, userInfo: [NSLocalizedDescriptionKey: "not found userProfile"])
                self.delegate?.didFailTask(socialType: .naver, connectType: .userProfile, errorType: .userNotFound, error: error)
            }
        }) { (httpCode, error) in
            self.delegate?.didFailTask(socialType: .naver, connectType: .userProfile, errorType: .unknown, error: error)
        }
    }

    func getUserProfile() -> SocialLoginKitUserProfile? {
        return self.userProfile
    }
}

extension NaverKit: XMLParserDelegate {

    func parserDidStartDocument(_ parser: XMLParser) {
        self.userProfile = nil
        userProfile = NaverKitUserProfile()
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        currentElement = elementName
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {

        switch currentElement {
        case "id":
            userProfile?.userID = string
        case "nickname":
            userProfile?.nickname = string
        case "name":
            userProfile?.name = string
        case "email":
            userProfile?.email = string
        case "gender":
            userProfile?.gender = string
        case "age":
            userProfile?.age = string
        case "birthday":
            userProfile?.birthday = string
        case "profile_image":
            userProfile?.profileImagePath = string
        default:
            break
        }
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        currentElement = ""

        if let userProfile = self.userProfile {
            delegate?.didSuccessTask(socialType: .naver, connectType: .userProfile)
        } else { 
            delegate?.didFailTask(socialType: .naver, connectType: .userProfile, errorType: .userNotFound, error: nil)
        }
    }
}
