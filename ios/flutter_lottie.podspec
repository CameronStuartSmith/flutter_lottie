#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#
Pod::Spec.new do |s|
  s.name             = 'flutter_lottie'
  s.version          = '0.0.1'
  s.summary          = 'Lottie wrapper for flutter'
  s.description      = 'Use Lottie in flutter to create stunning apps with amazing animations.'
  s.homepage         = 'http://example.com'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Your Company' => 'cameron@convictiontech.com' }
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.public_header_files = 'Classes/**/*.h'
  s.dependency 'Flutter'
  s.dependency 'lottie-ios'

  s.ios.deployment_target = '9.0'
end

