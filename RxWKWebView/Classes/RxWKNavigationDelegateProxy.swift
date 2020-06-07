//
//  RxWKNavigationDelegateProxy.swift
//  RxWKWebView
//
//  Created by OutOfCoding on 2020. 6. 7..
//  Copyright © 2020년 outofcoding. All rights reserved.
//

import WebKit

import RxCocoa
import RxSwift

public extension RxWKNavigationDelegateProxy {
    enum Action {
        case navigationAction(WKWebView, WKNavigationAction, ((WKNavigationActionPolicy) -> Swift.Void))
        case didStart(WKWebView, WKNavigation)
        case didFinish(WKWebView, WKNavigation)
    }
}

public class RxWKNavigationDelegateProxy: DelegateProxy<WKWebView, WKNavigationDelegate>, DelegateProxyType, WKNavigationDelegate {
    
    let action = PublishSubject<Action>()
    
    open class func currentDelegate(for object: WKWebView) -> WKNavigationDelegate? {
        return object.navigationDelegate
    }
    
    open class func setCurrentDelegate(_ delegate: WKNavigationDelegate?, to object: WKWebView) {
        object.navigationDelegate = delegate
    }
    
    public init(webView: WKWebView) {
        super.init(parentObject: webView, delegateProxy: RxWKNavigationDelegateProxy.self)
    }
    
    public static func registerKnownImplementations() {
        self.register { RxWKNavigationDelegateProxy(webView: $0) }
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        action.onNext(.navigationAction(webView, navigationAction, decisionHandler))
    }
    
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        action.onNext(.didStart(webView, navigation))
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        action.onNext(.didFinish(webView, navigation))
    }
}

public extension Reactive where Base: WKWebView {
    
    fileprivate var navigationDelegate: RxWKNavigationDelegateProxy {
        return RxWKNavigationDelegateProxy.proxy(for: base)
    }
    
    var navigationAction: Observable<RxWKNavigationDelegateProxy.Action> {
        return navigationDelegate.action.asObserver()
    }
}
