//
//  ViewController.swift
//  RxWKWebView
//
//  Created by outofcoding on 06/07/2020.
//  Copyright (c) 2020 outofcoding. All rights reserved.
//

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
