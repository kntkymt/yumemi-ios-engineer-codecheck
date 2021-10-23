//
//  APITargetType.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Moya
import Foundation

typealias Parameters = [String: Any]

protocol APITargetType: TargetType {
    associatedtype Response: Codable

    func decode(from result: Moya.Response) throws -> Response
}

extension APITargetType {
    
    var baseURL: URL {
        return URL(string: AppConstant.API.baseURL)!
    }

    var headers: [String: String]? {
        return [:]
    }

    func decode(from result: Moya.Response) throws -> Response {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return try decoder.decode(Response.self, from: result.data)
    }
}
