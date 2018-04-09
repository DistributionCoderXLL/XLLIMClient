#
#  Be sure to run `pod spec lint XLLTabPage.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "XLLTabPage"
  s.version      = "0.0.1"
  s.summary      = "A short description of XLLTabPage."
  s.description  = <<-DESC
                   一个多scollView交互的视图控制器
                    DESC
  s.homepage     = "http://EXAMPLE/XLLTabPage"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"
  # s.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  s.author             = { "iOS-肖乐乐" => "xiaoll@bbdtek.com" }

  # s.platform     = :ios
  s.platform     = :ios, "8.0"

  #  When using multiple platforms
  s.ios.deployment_target = "8.0"
  # s.osx.deployment_target = "10.7"
  # s.watchos.deployment_target = "2.0"
  # s.tvos.deployment_target = "9.0"

 s.source       = { :git => "https://github.com/storm52/XLLTabPage.git", :tag => s.version.to_s }

    s.subspec 'Core' do |ss|
        ss.source_files = 'XLLTabPage/XLLPageScroll/**/*{h,m}'
    end
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"
  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"
  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"
  # s.framework  = "SomeFramework"
  # s.frameworks = "SomeFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  s.dependency 'ReactiveObjC', '~> 2.1.0'

end
