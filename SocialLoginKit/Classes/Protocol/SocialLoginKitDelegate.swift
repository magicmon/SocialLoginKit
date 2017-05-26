//
//  SocialLoginKitDelegate.swift
//  SocialLoginKit
//
//  Created by magicmon on 2017. 5. 26..
//
//

import UIKit

public protocol SocialLoginKitDelegate: class {
    /**
     각 Task 성공 시 호출
     
     - parameter socialType:     각 Social 타입.
     - parameter connectType:    요청했던 task type.
     */
    func didSuccessTask(socialType: SocialLoginKitType, connectType: SocialLoginKitTaskType)
    
    /**
     각 Task 실패 시 호출
     
     - parameter socialType:    각 Social 타입.
     - parameter connectType:   요청했던 task type.
     - parameter errorType:     에러 종류
     - parameter error:         해당 task에서 발생한 에러내용.
     */
    func didFailTask(socialType: SocialLoginKitType, connectType: SocialLoginKitTaskType, errorType: SocialLoginKitErrorType, error: Error?)
}
