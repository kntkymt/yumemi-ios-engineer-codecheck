//
//  GitHubRepositoryDetailReadMePresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/26.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

final  class GitHubRepositoryDetailReadMePresenter: GitHubRepositoryDetailReadMePresentation {

    // MARK: - Property

    private weak var view: GitHubRepositoryDetailReadMeView?
    private var gitHubRepositoryDetailUsecase: GitHubRepositoryDetailUsecase
    private var gitHubRepository: GitHubRepository

    private let readmeBaseHtmlURL = Bundle.main.url(forResource: "mdbase", withExtension: "html")!
    private var readme: String?
    private var webViewSetuped = false

    // MARK: - Initializer

    init(view: GitHubRepositoryDetailReadMeView, gitHubRepositoryDetailUsecase: GitHubRepositoryDetailUsecase, gitHubRepository: GitHubRepository) {
        self.view = view
        self.gitHubRepositoryDetailUsecase = gitHubRepositoryDetailUsecase
        self.gitHubRepository = gitHubRepository
    }

    // MARK: - Lifecycle

    func viewDidLoad() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.view?.setupWebView(url: self.readmeBaseHtmlURL)
        }

        getReadme()
    }

    func viewWillAppear() {
    }

    func viewDidAppear() {
    }

    func viewDidStop() {
    }

    // MARK: - Internal

    func webViewDidFinishSetup() {
        webViewSetuped = true

        // 先にreadmeを取得できていた場合
        if let readme = readme {
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                // MEMO: multiline stringであるバッククオートを使うと
                // マークダウン内に含まれるバッククオート, JSの文字列展開である「${}」と競合するので
                // マークダウン内のバッククオート, $をエスケープする
                let escapedContent = readme
                    .replacingOccurrences(of: "`", with: "\\`")
                    .replacingOccurrences(of: "$", with: "\\$")
                let javaScript = "insert(`\(escapedContent)`);"

                self.view?.evaluateJavaScriptToWebView(javaScript: javaScript)
            }
        }
    }

    func webViewCanNavigate(to url: URL) -> Bool {
        // 初期読み込みは許可
        if url == readmeBaseHtmlURL {
            return true
        }

        if url.scheme == "http" || url.scheme == "https" {
            // リンクは全てSafariVCで開く
            DispatchQueue.main.async { [weak self] in
                self?.view?.presentSafariViewController(url: url)
            }
        }

        // 初期読み込み以外は拒否し、ReadmeのWebViewはページ移動しないようにする
        return false
    }

    // MARK: - Private

    private func getReadme() {
        Task {
            do {
                let readme = try await gitHubRepositoryDetailUsecase.getGitHubRepositoryReadme(at: gitHubRepository.name, in: gitHubRepository.owner.login)
                self.readme = readme

                // 先にWebViewのsetupが終わっていた場合
                if webViewSetuped {
                    DispatchQueue.main.async { [weak self] in
                        // MEMO: multiline stringであるバッククオートを使うと
                        // マークダウン内に含まれるバッククオート, JSの文字列展開である「${}」と競合するので
                        // マークダウン内のバッククオート, $をエスケープする
                        let escapedContent = readme
                            .replacingOccurrences(of: "`", with: "\\`")
                            .replacingOccurrences(of: "$", with: "\\$")
                        let javaScript = "insert(`\(escapedContent)`);"

                        self?.view?.evaluateJavaScriptToWebView(javaScript: javaScript)
                    }
                }
            } catch let apierror as APIError {
                // 404の場合はReadmeが存在しないのでViewController自体を隠す
                if case .statusCode(let statusError) = apierror, case .notfound = statusError {
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.hideReadmeViewController()
                    }
                } else {
                    Logger.error(apierror)
                }
            } catch {
                Logger.error(error)
            }
        }
    }
}
