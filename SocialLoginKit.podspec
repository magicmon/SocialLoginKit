#
# Be sure to run `pod lib lint SocialLoginKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SocialLoginKit'
  s.version          = '0.1.0'
  s.summary          = 'multiple social login kit. Support to Naver, Kakao and Facebook'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
multiple social login kit. Support to Naver, Kakao and Facebook
                       DESC

  s.homepage         = 'https://github.com/magicmon/SocialLoginKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'magicmon' => 'sagun25si@gmail.com' }
  s.source           = { :git => 'https://github.com/magicmon/SocialLoginKit.git', :tag => s.version.to_s }

  s.platform = :ios
  s.ios.deployment_target = '8.0'

  s.default_subspec = 'Core'

  s.subspec 'Core' do |sp|
    sp.source_files = 'SocialLoginKit/Classes/**/*'
  end

  s.subspec 'Facebook' do |sp|
      sp.dependency 'SocialLoginKit/Core'
      sp.dependency 'FBSDKCoreKit', '4.22.0'
      sp.dependency 'FBSDKLoginKit', '4.22.0'
      sp.dependency 'FBSDKShareKit', '4.22.0'
      sp.source_files = 'SocialLoginKit/Facebook/Classes/**/*.swift'
      sp.resource_bundle = {'FacebookBundle' => ['SocialLoginKit/Facebook/Dependencies/Resources/*.png']}
      sp.pod_target_xcconfig  = { "OTHER_LDFLAGS" => "-all_load -ObjC", "OTHER_SWIFT_FLAGS"=> '$(inherited) "-DFacebook"'}
  end

  s.subspec 'Naver' do |sp|
      sp.dependency 'SocialLoginKit/Core'
      sp.source_files         = 'SocialLoginKit/Naver/Classes/**/*', 'SocialLoginKit/Naver/Dependencies/thirdPartyModule/*.[h,m]'
      sp.vendored_libraries   = 'SocialLoginKit/Naver/Dependencies/thirdPartyModule/libNaverLogin.a'
      sp.resource             = 'SocialLoginKit/Naver/Dependencies/Resources/NaverAuth.bundle'
      sp.pod_target_xcconfig  = { "OTHER_LDFLAGS" => "-all_load -ObjC", "OTHER_SWIFT_FLAGS"=> '$(inherited) "-DNaver"'}
  end

  s.subspec 'Kakao' do |sp|
      sp.dependency 'SocialLoginKit/Core'
      sp.source_files         = 'SocialLoginKit/Kakao/Classes/**/*.{h,swift}', 'SocialLoginKit/Kakao/Dependencies/**/*.h'
      sp.vendored_frameworks  = 'SocialLoginKit/Kakao/Dependencies/KakaoOpenSDK.framework'
      sp.pod_target_xcconfig  = { "OTHER_LDFLAGS" => "-all_load -ObjC", "OTHER_SWIFT_FLAGS"=> '$(inherited) "-DKakao"'}
  end
end
