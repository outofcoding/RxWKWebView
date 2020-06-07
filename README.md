# RxWKWebView

[![CI Status](https://img.shields.io/travis/outofcoding/RxWKWebView.svg?style=flat)](https://travis-ci.org/outofcoding/RxWKWebView)
[![Version](https://img.shields.io/cocoapods/v/RxWKWebView.svg?style=flat)](https://cocoapods.org/pods/RxWKWebView)
[![License](https://img.shields.io/cocoapods/l/RxWKWebView.svg?style=flat)](https://cocoapods.org/pods/RxWKWebView)
[![Platform](https://img.shields.io/cocoapods/p/RxWKWebView.svg?style=flat)](https://cocoapods.org/pods/RxWKWebView)

## Installation

RxWKWebView is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxWKWebView'
```

## Requirements
- Xcode 11.x
- Swift 5.x

## Example Usages

To run the example project, clone the repo, and run `pod install` from the Example directory first.

```swift
import UIKit
import WebKit

import RxSwift
import RxWKWebView

class ViewController: UIViewController {
    
    private lazy var webView: WKWebView = {
        let configuration = WKWebViewConfiguration()
        let webView = WKWebView(frame: view.bounds, configuration: configuration)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return webView
    }()
    private lazy var disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView)
        
        webView.rx.navigationAction
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
            
        let url = URL(string: "https://www.apple.com")!
        let request = URLRequest(url: url)
        webView.load(request)
    }
}
```

## Author

outofcoding, outofcoding@gmail.com

## License

RxWKWebView is available under the MIT license. See the LICENSE file for more info.
