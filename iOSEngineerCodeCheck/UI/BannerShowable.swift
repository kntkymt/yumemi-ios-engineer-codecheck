//
//  BannerShowable.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/27.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

protocol BannerShowable {
    func showErrorBanner(_ title: String, with message: String?)
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
