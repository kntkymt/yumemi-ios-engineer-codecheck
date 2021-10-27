//
//  MessageBanner.swift
//  iOSEngineerCodeCheck
//
//  Created by kntk on 2021/10/27.
//  Copyright © 2021 YUMEMI Inc. All rights reserved.
//


import SwiftEntryKit
import UIKit

final class MessageBanner {

    // MARK: - Static

    static let shared = MessageBanner()

    // MARK: - Public

    func error(_ title: String, with message: String? = nil) {
        let attribute = createBannerAttribute(name: "Error", color: UIColor(named: "error")!, feedBack: .error, duration: 5.0)

        var title = title
        if let message = message {
            title = "\(title)\n\(message)"
        }

        let label = EKProperty.LabelContent(text: title, style: .init(font: UIFont.systemFont(ofSize: 15), color: .white, alignment: .center))
        let note = EKNoteMessageView(with: label)

        SwiftEntryKit.display(entry: note, using: attribute)
    }

    func warn(_ title: String, with message: String? = nil) {
        let attribute = createBannerAttribute(name: "Warn", color: UIColor(named: "warn")!, feedBack: .warning, duration: 5.0)

        var title = title
        if let message = message {
            title = "\(title)\n\(message)"
        }

        let label = EKProperty.LabelContent(text: title, style: .init(font: UIFont.systemFont(ofSize: 15), color: .white, alignment: .center))
        let note = EKNoteMessageView(with: label)

        SwiftEntryKit.display(entry: note, using: attribute)
    }

    // MARK: - Private

    private func createBannerAttribute(name: String, color: UIColor, feedBack: EKAttributes.NotificationHapticFeedback, duration: Double) -> EKAttributes {
        var attribute = EKAttributes.topToast
        attribute.displayMode = .inferred
        attribute.name = name
        attribute.displayDuration = duration
        attribute.hapticFeedbackType = feedBack
        attribute.popBehavior = .animated(animation: .translation)
        attribute.entryBackground = .color(color: EKColor.init(color))
        attribute.statusBar = .light

        return attribute
    }

    // MARK: - Initializer

    private init() {}
}

