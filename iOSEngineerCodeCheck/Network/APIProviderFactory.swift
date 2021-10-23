//
//  APIProviderFactory.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import Moya
import Alamofire
import Foundation

// データをとる先をStubとサーバーで切り替える
struct APIProviderFactory {

    // MARK: - Property

    private static let configuration: URLSessionConfiguration = {
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = HTTPHeaders.default.dictionary
        configuration.timeoutIntervalForRequest = 30

        return configuration
    }()

    // MARK: - Internal

    /// StubのProviderを生成する
    static func createStub() -> MoyaProvider<MultiTarget> {
        return createProvider(stubBehavior: MoyaProvider.delayedStub(1.0))
    }

    /// サーバーへ向けたProvider生成する
    static func createService() -> MoyaProvider<MultiTarget> {
        return createProvider()
    }

    // MARK: - Private

    /// Interceptorを元にProviderを作成
    private static func createProvider(stubBehavior: @escaping (MultiTarget) -> StubBehavior = MoyaProvider.neverStub) -> MoyaProvider<MultiTarget> {
        let sessionManager = Session(configuration: configuration)

        let provider = MoyaProvider<MultiTarget>(stubClosure: stubBehavior,
                                                 session: sessionManager,
                                                 plugins: [LoggerPlugin()])

        return provider
    }
}
