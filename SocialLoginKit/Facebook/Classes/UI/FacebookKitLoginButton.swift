//
//  FacebookKitLoginButton.swift
//  FacebookKit
//
//  Created by magicmon on 2017. 5. 26..
//

import UIKit
import FBSDKLoginKit

public class FacebookKitLoginButton: UIButton {
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.init(red: 59 / 255, green: 89 / 255, blue: 152 / 255, alpha: 1.0)
        
        self.contentHorizontalAlignment = .left
        
        // add login image
        let podBundle = Bundle(for: FacebookKit.self)
        if let url = podBundle.url(forResource: "FacebookBundle", withExtension: "bundle"), let bundle = Bundle(url: url) {
            
            // title
            self.setTitle("Login with Facebook", for: .normal)
            self.titleLabel?.adjustsFontSizeToFitWidth = true
            self.titleLabel?.textAlignment = .center
            
            // image
            let buttonImage = UIImage.init(named: "fb_logo_white.png", in: bundle, compatibleWith: nil)
            self.setImage(buttonImage, for: .normal)
            self.setImage(buttonImage, for: .highlighted)
            self.setImage(buttonImage, for: .selected)
            self.imageView?.contentMode = .scaleAspectFit
        }
    }
    
    override public func imageRect(forContentRect contentRect: CGRect) -> CGRect {
        var imageFrame = super.imageRect(forContentRect: contentRect)
        imageFrame.origin.x = CGFloat(imageFrame.size.height / 2) //offset from left edge
        return imageFrame
    }
    
    override public func titleRect(forContentRect contentRect:CGRect) -> CGRect {
        var titleFrame = super.titleRect(forContentRect: contentRect)
        titleFrame = self.bounds
        return titleFrame
    }
}
