#
# Be sure to run `pod lib lint OperationFramework.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OperationFramework'
  s.version          = '1.0.0'
  s.summary          = 'Architectural framework for highly configurable software.'
  s.swift_version = '5.0'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
Easy framework to perform configurable tasks in iOS

OperationFramework has been written in swift and offers highly configurable way of executing ordered tasks in your iOS app. These tasks could include executing of multiple functions one after each other or displaying series of view controllers in the particular order.

                       DESC

  s.homepage         = 'https://github.com/AmirKamali/OperationFramework-iOS'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Amir' => 'amir@kamali.io' }
  s.source           = { :git => 'https://github.com/AmirKamali/OperationFramework-iOS.git', :tag => s.version.to_s }
  s.social_media_url = 'https://stackoverflow.com/users/11065715/'

  s.ios.deployment_target = '8.0'
  s.source_files = 'OperationFramework/Classes/**/*'
 
end
