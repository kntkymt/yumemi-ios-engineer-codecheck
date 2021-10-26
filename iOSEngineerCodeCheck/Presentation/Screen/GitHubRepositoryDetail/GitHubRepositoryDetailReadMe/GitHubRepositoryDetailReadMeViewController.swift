//
//  GitHubRepositoryDetailReadMeViewController.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/25.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
import UIKit
import WebKit

final class GitHubRepositoryDetailReadMeViewController: UIViewController, Storyboardable {

    // MARK: - Outlet

    @IBOutlet weak var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
            webView.scrollView.isScrollEnabled = false
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupWebView()

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

    var presenter: GitHubRepositoryDetailReadMePresentation!

    // MARK: - Build

    static func build() -> Self {
        return initViewController()
    }

    // MARK: - Private

    private func setupWebView() {
        let url = Bundle.main.url(forResource: "mdbase", withExtension: "html")!
        webView.load(URLRequest(url: url))
    }
}

// MARK: - GitHubRepositoryDetailReadMeView

extension GitHubRepositoryDetailReadMeViewController: GitHubRepositoryDetailReadMeView {

    func showReadme(_ content: String) {
        // MEMO: multiline stringであるバッククオートを使うとマークダウン内に含まれるバッククオートと競合するので
        // マークダウン内のバッククオートをエスケープする
        let js = "insert(`\(content.replacingOccurrences(of: "`", with: "\\`"))`);"

        webView.evaluateJavaScript(js) { [weak self] _, error in
            guard let self = self else { return }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.webView.heightAnchor.constraint(equalToConstant: self.webView.scrollView.contentSize.height).isActive = true
            }
        }
    }
}

extension GitHubRepositoryDetailReadMeViewController: WKNavigationDelegate {

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        presenter.webViewDidFinishSetup()
    }
}
