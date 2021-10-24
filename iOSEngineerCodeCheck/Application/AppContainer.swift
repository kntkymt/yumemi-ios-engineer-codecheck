//
//  AppContainer.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

final class AppContainer {

    // MARK: - Static

    static let shared = AppContainer()

    // MARK: - Property

    let gitHubRepositorySearchUsecase: GitHubReposiotySearchUsecase

    // MARK: - Initializer

    private init() {
        self.gitHubRepositorySearchUsecase = SearchGitHubRepositoryUsecaseImpl(gitHubRepositoryRepository: GitHubRepositoryRepositoryImpl())
    }
}
