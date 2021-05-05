Pod::Spec.new do |s|
  s.name              = 'Plaid'
  s.module_name       = 'LinkKit'
  s.version           = '2.1.2'

  s.summary           = 'The official Plaid Link SDK for iOS.'

  s.description       = <<-DESC
                        Plaid Link is a quick and secure way to integrate with
                        the Plaid API. LinkKit is an embeddable framework
                        that handles credential validation, multi-factor
                        authentication, and error handling for each institution
                        that Plaid supports — all while keeping credentials from
                        ever hitting your infrastructure.
                        DESC
  s.screenshot        = 'https://plaid.com/assets/img/docs/link-ios.png'

  s.homepage          = 'https://plaid.com/docs/link/ios/'
  s.license           = { :type => 'MIT', :file => 'LICENSE' }
  s.author            = 'Plaid Inc.'

  s.platform          = :ios, '11.0'
  s.source            = { :git => 'https://github.com/plaid/plaid-link-ios.git', :tag => "ios/#{s.version}" }

  s.ios.frameworks    = 'Foundation', 'UIKit', 'WebKit', 'SafariServices'
  s.ios.vendored_frameworks = 'LinkKit.xcframework'
end
