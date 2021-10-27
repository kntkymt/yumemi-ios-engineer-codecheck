//
//  UIView+LoadingIndicator.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/27.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//

import UIKit

enum IndicatorViewKey {
    static let tag = 100
}

extension UIView {

    var indicatorView: UIActivityIndicatorView {
        get {
            let indicatorView = UIActivityIndicatorView()
            indicatorView.style = .large
            indicatorView.color = .systemGray
            indicatorView.backgroundColor = .clear
            indicatorView.frame.size.height = 50
            indicatorView.tag = IndicatorViewKey.tag

            return indicatorView
        }
    }

    func showLoading(disableUserIteraction: Bool = true) {
        if let addedIndicatorView = getAddedIndicatorView() {
            addedIndicatorView.isHidden = false

            if disableUserIteraction {
                isUserInteractionEnabled = false
            }

            addedIndicatorView.startAnimating()
        } else {
            let indicatorView = indicatorView
            indicatorView.translatesAutoresizingMaskIntoConstraints = false
            indicatorView.hidesWhenStopped = true

            self.addSubview(indicatorView, constraints: .center())

            if disableUserIteraction {
                isUserInteractionEnabled = false
            }

            indicatorView.startAnimating()
        }
    }

    func hideLoading() {
        if let addedIndicatorView = getAddedIndicatorView() {
            isUserInteractionEnabled = true
            addedIndicatorView.stopAnimating()
            addedIndicatorView.isHidden = true
        }
    }

    private func getAddedIndicatorView() -> UIActivityIndicatorView? {
        for subview in subviews {
            if let indicatorView = subview as? UIActivityIndicatorView, indicatorView.tag == IndicatorViewKey.tag {
                return indicatorView
            }
        }

        return nil
    }
}

