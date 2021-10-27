//
//  GetGitHubRepositoryReadmeRequest.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/26.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Moya
import Foundation

struct GetGitHubRepositoryReadmeResponse: Codable {
    var content: String
}

struct GetGitHubRepositoryReadmeRequest {
    var owner: String
    var repository: String
}

extension GetGitHubRepositoryReadmeRequest: APITargetType {

    typealias Response = GetGitHubRepositoryReadmeResponse

    var path: String {
        return "/repos/\(owner)/\(repository)/readme"
    }

    var method: Moya.Method {
        return .get
    }

    var task: Task {
        return .requestPlain
    }

    var sampleData: Data {
        let path = Bundle.main.path(forResource: "GetGitHubRepositoryReadmeRequestStub", ofType: "json")!
        return FileHandle(forReadingAtPath: path)!.readDataToEndOfFile()
    }
}

