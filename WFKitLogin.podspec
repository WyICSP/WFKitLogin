#
# Be sure to run `pod lib lint WFKitLogin.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'WFKitLogin'
  s.version          = '1.0.0'
  s.summary          = 'WFKitLogin登录模块'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
WFKitLogin是云智充的登录模块主骨架组件
                       DESC

  s.homepage         = 'https://github.com/WyICSP/WFKitLogin'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'wyxlh' => 'wy_wangyu163@163.com' }
  s.source           = { :git => 'https://github.com/WyICSP/WFKitLogin.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'WFKitLogin/Classes/**/*'
  
  s.resource_bundles = {
     'WFKitLogin' => ['WFKitLogin/Assets/*.png']
  }

  #s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
  s.dependency 'WFKitMain'
  s.dependency 'MJExtension'
  s.dependency 'MJRefresh'
  s.dependency 'WFHomeAddress'
  s.dependency 'SDWebImage'
  s.dependency 'dsBridge'
  s.dependency 'WKFunComponents'

end
