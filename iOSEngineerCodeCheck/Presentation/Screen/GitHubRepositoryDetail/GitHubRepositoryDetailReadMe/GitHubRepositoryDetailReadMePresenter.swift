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
                self.view?.showReadme(readme)
            }
        }
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
                        self?.view?.showReadme(readme)
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
