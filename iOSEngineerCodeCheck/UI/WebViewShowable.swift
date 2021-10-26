//
//  WebViewShowable.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/26.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import SafariServices

protocol WebViewShowable {
    func openSafariApp(url: URL)

    func presentSafariViewController(url: URL)
}

extension WebViewShowable where Self: UIViewController {

    func openSafariApp(url: URL) {
        guard UIApplication.shared.canOpenURL(url) else { return }
        UIApplication.shared.open(url)
    }

    func presentSafariViewController(url: URL) {
        guard UIApplication.shared.canOpenURL(url) else { return }
        let safariViewController = SFSafariViewController(url: url)
        present(safariViewController, animated: true)
    }
}
