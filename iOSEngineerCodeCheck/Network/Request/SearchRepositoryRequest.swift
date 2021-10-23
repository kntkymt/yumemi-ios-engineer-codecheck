//
//  SearchRepositoryRequest.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Moya

struct SearchGitHubRepositoryResponse: Codable {
    var items: [GitHubRepository]
}

struct SearchGitHubRepositoryRequest {
    var query: String
}

extension SearchGitHubRepositoryRequest: APITargetType {

    typealias Response = SearchGitHubRepositoryResponse

    var path: String {
        return "/search/repositories"
    }

    var method: Method {
        return .get
    }

    var task: Task {
        let parameters: Parameters = [
            "q": query
        ]

        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }
}
