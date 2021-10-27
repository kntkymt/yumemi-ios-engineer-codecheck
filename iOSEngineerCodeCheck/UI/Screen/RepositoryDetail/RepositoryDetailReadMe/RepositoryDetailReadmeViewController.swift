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

    // MARK: - Property

    private var webViewContntObservation: NSKeyValueObservation?

    // MARK: - Property

    var presenter: RepositoryDetailReadmePresentation!

    private lazy var errorViewController = ErrorViewController.build(refreshTitle: "再読み込み", hideRefreshButton: false)

    // MARK: - Build

    static func build() -> Self {
        return initViewController()
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        errorViewController.setRefreshButtonHandler { [weak self] in
            self?.presenter.errorViewRefreshButtonDidTap()
        }

        // ScrollViewのcontentの高さをobserveし、WebViewの高さとcontentの高さを常に一致させる
        webViewContntObservation = webView.scrollView.observe(\.contentSize) { [weak self] scrollView, _ in
            guard let self = self else { return }
            if self.webViewHeightConstraint.constant != scrollView.contentSize.height {
                self.webViewHeightConstraint.constant = scrollView.contentSize.height
            }
        }

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
}

// MARK: - GitHubRepositoryDetailReadmeView

extension RepositoryDetailReadmeViewController: RepositoryDetailReadmeView {

    func evaluateJavaScriptToWebView(javaScript: String) {
        webView.evaluateJavaScript(javaScript) { [weak self] _, error in
            if let error = error {
                self?.presenter.webViewDidFailEvaluateJavaScript(with: error)
                return
            }
        }
    }

    func hideReadmeViewController() {
        view.isHidden = true
    }

    func setupWebView(url: URL) {
        webView.load(URLRequest(url: url))
    }

    func showErrorView() {
        webView.addSubview(errorViewController.view, constraints: .allEdges())
    }

    func hideErrorView() {
        errorViewController.view.removeFromSuperview()
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
