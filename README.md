# SocialLoginKit

[![Version](https://img.shields.io/cocoapods/v/SocialLoginKit.svg?style=flat)](http://cocoapods.org/pods/SocialLoginKit)
[![License](https://img.shields.io/cocoapods/l/SocialLoginKit.svg?style=flat)](http://cocoapods.org/pods/SocialLoginKit)
[![Platform](https://img.shields.io/cocoapods/p/SocialLoginKit.svg?style=flat)](http://cocoapods.org/pods/SocialLoginKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

* Swift 3.0
* Xcode 8
* iOS 8.0+

## Installation

Each site can be added, and all can be added.

If you want FacebookKit
```ruby
pod 'SocialLoginKit/Faceook'
```

with Naver
```ruby
pod 'SocialLoginKit/Naver'
```

with Kakao
```ruby
pod 'SocialLoginKit/Kakao'
```

All of them
```ruby
pod 'SocialLoginKit/Faceook'
pod 'SocialLoginKit/Naver'
pod 'SocialLoginKit/Kakao'
```

## Setting

### Info.plist

Add the key related to **SocialLoginKit** to the Info.plist. These are the permission key values for facebook and naver.

```
<key>SocialLoginKitKey</key>
<dict>
  <key>FacebookPublishPermissions</key>
  <array>
    <string>publish_actions</string>
  </array>
  <key>FacebookReadPermissions</key>
  <array>
    <string>public_profile</string>
    <string>email</string>
    <string>user_friends</string>
  </array>
  <key>NaverConsumerKey</key>
  <string>[Naver_Consumer_Key]</string>
  <key>NaverConsumerSecret</key>
  <string>[Naver_Consumer_Secret]</string>
  <key>NaverAppName</key>
  <string>[Naver_App_Name]</string>
  <key>NaverServiceURLScheme</key>
  <string>[Naver_Service_URL_Scheme]</string>
</dict>
```

This is the same as the Info.list setting for each site.

[Facebook Getting Started](https://developers.facebook.com/docs/ios/getting-started)

[카카오 개발 가이드 > iOS 개발가이드 > 시작하기](https://developers.kakao.com/docs/ios#시작하기-개발환경-구성)

## Usage


## Author

magicmon, https://magicmon.github.com 

## License

**SocialLoginKit** is available under the MIT license. See the LICENSE file for more info.
