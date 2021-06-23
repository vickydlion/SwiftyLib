//
//  WebViewViewController.swift
//  SwiftyLib
//
//  Created by Vivek Garg on 23/06/21.
//

import UIKit
import WebKit

class WebViewViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    private let webView: WKWebView = {
        let preferences = WKWebpagePreferences()
        preferences.allowsContentJavaScript = true
        let configurations = WKWebViewConfiguration()
        configurations.defaultWebpagePreferences = preferences
        configurations.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: configurations)
        return webView
    }()
    
    private let url:URL

    
    init(url:URL, title: String) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
        self.title = title
    }
    required init?(coder: NSCoder) {
        fatalError()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(webView)
        webView.navigationDelegate = self
        webView.uiDelegate = self
        webView.load(URLRequest(url: url))
        configurations()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
    
    private func configurations(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(didTapDone))
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(didTapRefresh))
}
    
    @objc private func didTapDone(){
        dismiss(animated: true, completion: nil)
    }
    @objc private func didTapRefresh(){
        webView.load(URLRequest(url: url))
    }
}


