//
//  BannerShowable.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/27.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

protocol BannerShowable {

    /// エラーメッセージをバナーで表示する
    /// バナーの色は赤色
    ///
    /// - parameters:
    ///     - title: タイトル(1行目に表示)
    ///     - message: メッセージ(2行目に表示)
    func showErrorBanner(_ title: String, with message: String?)

    /// 警告メッセージをバナーで表示する
    /// バナーの色は黄色
    ///
    /// - parameters:
    ///     - title: タイトル(1行目に表示)
    ///     - message: メッセージ(2行目に表示)
    func showWarnBanner(_ title: String, with message: String?)
}

extension BannerShowable {
    
    func showErrorBanner(_ title: String, with message: String? = nil) {
        MessageBanner.shared.error(title, with: message)
    }

    func showWarnBanner(_ title: String, with message: String? = nil) {
        MessageBanner.shared.warn(title, with: message)
    }
}
