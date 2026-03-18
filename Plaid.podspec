Pod::Spec.new do |s|
  s.name              = 'Plaid'
  s.module_name       = 'LinkKit'
  s.version           = '6.4.6'

  s.summary           = '[DEPRECATED] The official Plaid Link SDK for iOS.'

  s.description       = <<-DESC
                        ⚠️ DEPRECATED: CocoaPods distribution for LinkKit is deprecated and will
                        not receive updates beyond this version. CocoaPods trunk becomes
                        permanently read-only on December 2nd, 2026.

                        Migrate to Swift Package Manager using the official SPM repository:
                        https://github.com/plaid/plaid-link-ios-spm

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

  s.platform          = :ios, '14.0'
  s.source            = { :git => 'https://github.com/plaid/plaid-link-ios.git', :tag => s.version }

  s.ios.frameworks    = 'Foundation', 'UIKit', 'WebKit', 'SafariServices'
  s.ios.vendored_frameworks = 'LinkKit.xcframework'
  s.deprecated        = true
end
