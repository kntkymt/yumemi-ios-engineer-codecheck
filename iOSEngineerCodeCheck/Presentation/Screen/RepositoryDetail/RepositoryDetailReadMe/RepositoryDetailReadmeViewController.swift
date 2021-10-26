//
//  RepositoryDetailReadmeViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit
import WebKit

final class RepositoryDetailReadmeViewController: UIViewController, Storyboardable {

    // MARK: - Outlet

    @IBOutlet private weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
            webView.scrollView.isScrollEnabled = false
        }
    }
    @IBOutlet private weak var webViewHeightConstraint: NSLayoutConstraint!

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        presenter.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        presenter.viewWillAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        presenter.viewDidAppear()
    }

    deinit {
        presenter.viewDidStop()
    }

    // MARK: - Property

    var presenter: RepositoryDetailReadmePresentation!

    // MARK: - Build

    static func build() -> Self {
        return initViewController()
    }
}

// MARK: - GitHubRepositoryDetailReadmeView

extension RepositoryDetailReadmeViewController: RepositoryDetailReadmeView {
    func evaluateJavaScriptToWebView(javaScript: String) {
        webView.evaluateJavaScript(javaScript) { [weak self] _, error in
            guard let self = self else { return }

            if let error = error {
                Logger.error(error)
                return
            }

            // js適応からscrollViewのcontentSizeが反映されるまで少し待つ
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.webViewHeightConstraint.constant = self.webView.scrollView.contentSize.height
            }
        }
    }


    func hideReadmeViewController() {
        view.isHidden = true
    }

    func setupWebView(url: URL) {
        webView.load(URLRequest(url: url))
    }
}

// MARK: - WKNavigationDelegate

extension RepositoryDetailReadmeViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        presenter.webViewDidFinishSetup()
    }

    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard let url = navigationAction.request.url else { return decisionHandler(.cancel) }

        if presenter.webViewCanNavigate(to: url) {
            decisionHandler(.allow)
        } else {
            decisionHandler(.cancel)
        }
    }
}
