# SocialLoginKit

[![CI Status](http://img.shields.io/travis/sagun25si@gmail.com/SocialLoginKit.svg?style=flat)](https://travis-ci.org/magicmon/SocialLoginKit)
[![Version](https://img.shields.io/cocoapods/v/SocialLoginKit.svg?style=flat)](http://cocoapods.org/pods/SocialLoginKit)
[![License](https://img.shields.io/cocoapods/l/SocialLoginKit.svg?style=flat)](http://cocoapods.org/pods/SocialLoginKit)
[![Platform](https://img.shields.io/cocoapods/p/SocialLoginKit.svg?style=flat)](http://cocoapods.org/pods/SocialLoginKit)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SocialLoginKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SocialLoginKit"
```

### Import

Info.plist에 아래 항목 추가

## Usage
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

## Author

magicmon

## License

SocialLoginKit is available under the MIT license. See the LICENSE file for more info.
