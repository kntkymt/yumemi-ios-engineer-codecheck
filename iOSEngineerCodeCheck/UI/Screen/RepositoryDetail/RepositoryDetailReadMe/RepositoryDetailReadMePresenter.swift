//
//  RepositoryDetailReadMePresenter.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/26.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

final  class RepositoryDetailReadMePresenter: RepositoryDetailReadmePresentation {

    // MARK: - Property

    private weak var view: RepositoryDetailReadmeView?
    private var gitHubRepositoryDetailUsecase: GitHubRepositoryDetailUsecase
    private var gitHubRepository: GitHubRepository

    private let readmeBaseHtmlURL = Bundle.main.url(forResource: "mdbase", withExtension: "html")!
    private var readme: String?
    private var webViewSetuped = false

    // MARK: - Initializer

    init(view: RepositoryDetailReadmeView, gitHubRepositoryDetailUsecase: GitHubRepositoryDetailUsecase, gitHubRepository: GitHubRepository) {
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
        if readme != nil {
            evaluateJavaScriptToWebView()
        }
    }

    func webViewDidFailEvaluateJavaScript(with error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.showErrorView()
        }
        Logger.error(error)
        handle(error)
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

    func errorViewRefreshButtonDidTap() {
        if readme == nil {
            getReadme()
        } else {
            evaluateJavaScriptToWebView()
        }
    }

    // MARK: - Private

    private func getReadme() {
        Task {
            do {
                let readme = try await gitHubRepositoryDetailUsecase.getGitHubRepositoryReadme(repository: gitHubRepository.name, owner: gitHubRepository.owner.login)
                self.readme = readme

                // 先にWebViewのsetupが終わっていた場合
                if webViewSetuped {
                    evaluateJavaScriptToWebView()
                }
            } catch let apierror as APIError {
                // 404の場合はReadmeが存在しないのでViewController自体を隠す
                if case .statusCode(let statusError) = apierror, case .notfound = statusError {
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.hideReadmeViewController()
                    }
                } else {
                    DispatchQueue.main.async { [weak self] in
                        self?.view?.showErrorView()
                    }
                    Logger.error(apierror)
                    handle(apierror)
                }
            } catch {
                DispatchQueue.main.async { [weak self] in
                    self?.view?.showErrorView()
                }
                Logger.error(error)
                handle(error)
            }
        }
    }

    private func evaluateJavaScriptToWebView() {
        guard let readme = readme else { return }

        DispatchQueue.main.async { [weak self] in
            self?.view?.hideErrorView()

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

    private func handle(_ error: Error) {

        let title: String
        let message: String

        if let apiErorr = error as? APIError {
            switch apiErorr {
            case .statusCode(let statusCodeError):
                title = "システムエラー"
                message = "再度お試しください。\n\(statusCodeError._domain), \(statusCodeError._code)"

            case .response(let error):
                title = "ネットワークエラー"
                message = "通信状況をお確かめの上、再度お試しください。\n\(error._domain), \(error._code)"

            case .decode(let error):
                title = "パースエラー"
                message = "再度お試しください。\n\(error._domain), \(error._code)"

            case .base64Decode:
                title = "パースエラー"
                message = "再度お試しください。\n\(error._domain), \(error._code)"
            }
        } else {
            title = "システムエラー"
            message = "再度お試しください。\n\(error._domain), \(error._code)"
        }

        DispatchQueue.main.async { [weak self] in
            self?.view?.showErrorBanner(title, with: message)
        }
    }
}
