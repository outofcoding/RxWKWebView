#
# Be sure to run `pod lib lint RxWKWebView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RxWKWebView'
  s.version          = '0.1.0'
  s.summary          = 'RxWKWebView is RxSwift wrapper for WKWebView.'
  s.description      = <<-DESC
  RxWKWebView is RxSwift wrapper for WKWebView.
  subscribe webView.rx.navigationAction.
  
  webview.rx.navigationAction
      .subscribe(onNext: { action in
          switch action {
          case let .navigationAction(webView, action, handler):
              print("navigationAction. action = \(action)")
              print("navigationAction. target = \(webView.url?.absoluteString ?? "<nil>")")
              handler(WKNavigationActionPolicy.allow)
          case let .didStart(webView, navigation):
              print("start web page. action = \(navigation)")
              print("start web page. target = \(webView.url?.absoluteString ?? "<nil>")")
          case let .didFinish(webView, navigation):
              print("end web page. action = \(navigation)")
              print("end web page. target = \(webView.url?.absoluteString ?? "<nil>")")
          }
      })
      .disposed(by: disposeBag)
  DESC

  s.homepage         = 'https://github.com/outofcoding/RxWKWebView'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'outofcoding' => 'outofcoding@gmail.com' }
  s.source           = { :git => 'https://github.com/outofcoding/RxWKWebView.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'RxWKWebView/Classes/**/*'
  s.swift_version = '5.0'
  s.dependency 'RxSwift', '~> 5.0'
  s.dependency 'RxCocoa', '~> 5.0'
end
