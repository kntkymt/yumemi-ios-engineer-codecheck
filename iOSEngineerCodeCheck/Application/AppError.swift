//
//  AppError.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/24.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

enum APIError: Error {

    enum HTTPStatusCodeError: Error {
        /// 400
        case badrequest

        /// 401
        case unauthorized

        /// 403
        case forbidden

        /// 404
        case notfound

        /// 422
        case validationFailed

        /// 500番台
        case server(Int)

        /// 200番台以外かつ上記以外の番号
        case unknown(Int)

        // MARK: - Property

        /// NSErrorに変換した時のdomainを定義
        // swiftlint:disable:next identifier_name
        var _domain: String {
            return "HTTPStatusCodeError"
        }

        /// NSErrorに変換した時のcodeを定義
        // swiftlint:disable:next identifier_name
        var _code: Int {
            switch self {
            case .badrequest:
                return 400
            case .unauthorized:
                return 401
            case .forbidden:
                return 403
            case .notfound:
                return 404
            case .validationFailed:
                return 422
            case .server(let statusCode):
                return statusCode
            case .unknown(let statusCode):
                return statusCode
            }
        }

        // MARK: - Initializer

        init(statusCode: Int) {

            switch statusCode {
            case 400:
                self = .badrequest
            case 401:
                self = .unauthorized
            case 403:
                self = .forbidden
            case 404:
                self = .notfound
            case 422:
                self = .validationFailed
            case 500..<600:
                self = .server(statusCode)
            default:
                self = .unknown(statusCode)
            }
        }
    }

    /// 200番代以外のステータスコードが返ってきた場合
    case statusCode(HTTPStatusCodeError)

    /// レスポンスを受け取れなかった(ネットワーク不良など)
    case response(Error)

    /// レスポンスのパースに失敗した
    case decode(Error)

    /// base64デコードに失敗した
    case base64Decode

    var causeError: Error? {
        switch self {
        case .statusCode(let statusCodeError):
            return statusCodeError

        case .decode(let error):
            return error

        case .base64Decode:
            return nil

        case .response(let error):
            return error
        }
    }
}
