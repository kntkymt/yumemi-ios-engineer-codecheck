//
//  SearchRepositoryRequest.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Moya
import Foundation

enum GitHubRepositorySortKind {
    case stars
    case forks
    case helpWantedIssues
    case updated
    case bestMatch

    var rawValue: String? {
        switch self {
        case .stars: return "stars"
        case .forks: return "forks"
        case .helpWantedIssues: return "help-wanted-issues"
        case .updated: return "updated"
        case .bestMatch: return nil
        }
    }
}

struct SearchGitHubRepositoryResponse: Codable {
    var items: [GitHubRepository]
}

struct SearchGitHubRepositoryRequest {

    var query: String
    var sort: GitHubRepositorySortKind
}

extension SearchGitHubRepositoryRequest: APITargetType {

    typealias Response = SearchGitHubRepositoryResponse

    var path: String {
        return "/search/repositories"
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        var parameters: Parameters = [
            "q": query
        ]

        if let sortKind = sort.rawValue {
            parameters["sort"] = sortKind
        }

        return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
    }

    var sampleData: Data {
        let path = Bundle.main.path(forResource: "SearchGitHubRepositoryRequestStub", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }
}
