//
//  NaverKitLoginButton.swift
//  NaverKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit

public class NaverKitLoginButton: UIButton {

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(red: 30 / 255, green: 200 / 255, blue: 0.0, alpha: 1.0)
        
        // common
        self.contentHorizontalAlignment = .left
        
        if let bundleURL = Bundle.main.url(forResource: "Frameworks/SocialLoginKit.framework/NaverAuth", withExtension: "bundle"), let localizedBundle = Bundle(url: bundleURL) {
            
            // title
            let key = localizedBundle.localizedString(forKey: "NaverButtonLoginTitle", value: "login with NAVER", table: "NaverAuth")
            self.setTitle(key, for: .normal)
            self.titleLabel?.adjustsFontSizeToFitWidth = true
            self.titleLabel?.textAlignment = .center
            
            // image
            let buttonImage = UIImage(named: "btn_naver_login_icon_green.png", in: localizedBundle, compatibleWith: nil)
            self.setImage(buttonImage, for: .normal)
            self.setImage(buttonImage, for: .highlighted)
            self.setImage(buttonImage, for: .selected)
            self.imageView?.contentMode = .scaleAspectFit

        }
    }
    
    override public func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        var imageFrame = super.imageRect(forContentRect: contentRect)
        imageFrame.origin.x = -CGFloat(imageFrame.size.height / 2) //offset from left edge
        return imageFrame
    }
    
    override public func titleRect(forContentRect contentRect:CGRect) -> CGRect {
        var titleFrame = super.titleRect(forContentRect: contentRect)
        titleFrame = self.bounds
        return titleFrame
    }
}
