//
//  GitHubRepositoryReadmeRepositoryStubImpl.swift
//  iOSEngineerCodeCheckTests
//
//  Created by kntk on 2021/10/27.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Foundation
@testable import iOSEngineerCodeCheck

final class GitHubRepositoryReadmeRepositoryStubImpl: GitHubRepositoryReadmeRepository {

    func getGitHubRepositoryReadme(repository: String, owner: String) async throws -> String {
        return "# Readme\n- owner: \(owner)\n- repository: \(repository)"
    }
}
