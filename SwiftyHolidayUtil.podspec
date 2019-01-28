#
# Be sure to run `pod lib lint SwiftyHolidayUtil.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'SwiftyHolidayUtil'
    s.version          = '0.1.1'
    s.summary          = 'SwiftyHolidayUtil is a library for highlighting holidays.'
    
    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!
    
    s.description      = <<-DESC
    SwiftyHolidayUtil is a library for highlighting holidays. Very easy as it can be used as extension of UILabel.
    DESC
    
    s.homepage         = 'https://github.com/kazuomatz/SwiftyHolidayUtil'
    s.screenshots     =  'https://user-images.githubusercontent.com/2704723/51838188-f1a12c80-2348-11e9-8b22-45de8cac84e0.png'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'kazuomatz' => 'getlasterror@gmail.com' }
    s.source           = { :git => 'https://github.com/kazuomatz/SwiftyHolidayUtil.git', :tag => s.version.to_s }
    s.social_media_url = 'https://twitter.com/kazuomatz'
    s.swift_version = '4.2'
    s.ios.deployment_target = '9.3'
    s.source_files = 'Classes/**/*'
    s.frameworks = 'UIKit'
    s.dependency 'CalculateCalendarLogic'
end
