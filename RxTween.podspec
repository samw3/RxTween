#
# Be sure to run `pod lib lint RxTween.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |spec|
  spec.name             = 'RxTween'
  spec.version          = '0.1.0'
  spec.summary          = 'Tweening operators for RxSwift'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  spec.description      = <<-DESC
Adds tweening operators to RxSwift for use in animations.
                       DESC

  spec.homepage         = 'https://github.com/samw3/RxTween'
  # spec.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  spec.license          = { :type => 'MIT', :file => 'LICENSE' }
  spec.author           = { 'samw3' => 'sam@samwashburn' }
  spec.source           = { :git => 'https://github.com/samw3/RxTween.git', :tag => spec.version.to_s }

  spec.ios.deployment_target = '8.0'
  spec.dependency 'RxSwift'

  spec.source_files = 'RxTween/Classes/**/*'
  
  # spec.resource_bundles = {
  #   'RxTween' => ['RxTween/Assets/*.png']
  # }

  # spec.public_header_files = 'Pod/Classes/**/*.h'
  # spec.frameworks = 'UIKit', 'MapKit'
  # spec.dependency 'AFNetworking', '~> 2.3'
end
