//
//  LoggerPlugin.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Moya

struct LoggerPlugin: PluginType {

    func willSend(_ request: RequestType, target: TargetType) {
        request.request.map { print("Target: \(target)\n\($0.curlString)") }
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            print("Success\nTarget: \(target)\nResponse: \(response)")

        case .failure(let error):
            print("Failure\nTarget: \(target)\nError: \(error)")
        }
    }
}
