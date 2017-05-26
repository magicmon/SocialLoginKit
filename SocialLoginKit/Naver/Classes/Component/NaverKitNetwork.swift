//
//  NaverKitNetwork.swift
//  NaverKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit

class NaverKitNetwork: NSObject {
    static var sharedInstance: NaverKitNetwork = NaverKitNetwork()
    
    // MARK: - API
    func getUserProfile(successHandler: @escaping (_ httpCode: Int, _ response: [String: Any]?) -> Void,
                        errorHandler: @escaping (_ httpCode: Int, _ error: Error?) -> Void) {
        let naverLoginConn: NaverThirdPartyLoginConnection = NaverThirdPartyLoginConnection.getSharedInstance()

        
        if let url = URL(string: "https://openapi.naver.com/v1/nid/getUserProfile.xml") {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            request.setValue("Bearer \(naverLoginConn.accessToken)", forHTTPHeaderField: "Authorization")
            
            let configuration = URLSessionConfiguration.default
            let session = URLSession(configuration: configuration)
            
            
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        errorHandler((error as NSError).code, error)
                    } else {
                        if let data = data {
                            successHandler(200, ["userProfile": data])
                        } else {
                            successHandler(200, nil)
                        }
                    }
                }
            })
            
            task.resume()
        } else {
            let error = NSError(domain: "https://openapi.naver.com", code: 500, userInfo: ["description": "nsurl init fail"])
            errorHandler(500, error)
        }
    }
}
