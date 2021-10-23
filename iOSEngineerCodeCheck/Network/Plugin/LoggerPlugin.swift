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
        request.request.map { Logger.debug("Target: \(target)\n\($0.curlString)") }
    }

    func didReceive(_ result: Result<Response, MoyaError>, target: TargetType) {
        switch result {
        case .success(let response):
            Logger.debug("Success\nTarget: \(target)\nResponse: \(response)")

        case .failure(let error):
            Logger.debug("Failure\nTarget: \(target)\nError: \(error)")
        }
    }
}
