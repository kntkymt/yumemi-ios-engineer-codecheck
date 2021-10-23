//
//  Repository.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

struct GitHubRepository: Codable {

    var fullName: String
    var language: String?
    var stargazersCount: Int
    var watchersCount: Int
    var forksCount: Int
    var openIssuesCount: Int

    var owner: User
}
