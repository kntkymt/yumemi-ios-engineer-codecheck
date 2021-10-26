//
//  GitHubRepositoryReadmeRepository.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/26.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation

protocol GitHubRepositoryReadmeRepository {

    func getGitHubRepositoryReadme(at repositoryName: String, in owner: String) async throws -> String
}


final class GitHubRepositoryReadmeRepositoryImpl: GitHubRepositoryReadmeRepository {

    func getGitHubRepositoryReadme(at repositoryName: String, in owner: String) async throws -> String {
        let base64Content = try await API.shared.call(GetGitHubRepositoryReadmeRequest(owner: owner, repository: repositoryName)).content

        guard let data = Data(base64Encoded: base64Content, options: .ignoreUnknownCharacters), let decodedContent = String(data: data, encoding: .utf8) else {
            throw APIError.base64Decode
        }

        return decodedContent
    }
}

