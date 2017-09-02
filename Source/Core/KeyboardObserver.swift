//
//  KeyboardObserver.swift
//  SwiftyKeyboardObserver
//
//  Created by Adrian Bobrowski on 23.08.2017.
//  Copyright © 2017 Adrian Bobrowski (Decybel07), adrian071993@gmail.com. All rights reserved.
//

import UIKit

public protocol KeyboardObserver: class {

    var keyboardWillChangeFrameObserver: NSObjectProtocol? { get set }
    var initialConstant: CGFloat { get }

    var constraint: NSLayoutConstraint! { get }
    var view: UIView! { get }
}

public extension KeyboardObserver {

    func registerKeyboardNotification() {
        guard self.keyboardWillChangeFrameObserver == nil else {
            return
        }

        self.keyboardWillChangeFrameObserver = NotificationCenter.default.addObserver(
            forName: .UIKeyboardWillChangeFrame, object: nil, queue: .main
        ) { [weak self] notification in
            self?.keyboardWillFrameUpdated(notification)
        }
    }

    func unregisterKeyboardNotification() {
        guard let observer = self.keyboardWillChangeFrameObserver else {
            return
        }
        NotificationCenter.default.removeObserver(observer)
        self.keyboardWillChangeFrameObserver = nil
    }

    private func keyboardWillFrameUpdated(_ notification: Notification) {
        guard let keyboardInfo = notification.userInfo,
            let frame = keyboardInfo[UIKeyboardFrameEndUserInfoKey] as? CGRect,
            let duration = keyboardInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber,
            let options = keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber,
            frame.height > 0
        else {
            return
        }

        UIView.animate(
            withDuration: duration.doubleValue,
            delay: 0,
            options: UIViewAnimationOptions(rawValue: options.uintValue),
            animations: {
                self.constraint.constant = self.constant(for: frame)
                self.view.layoutIfNeeded()
            }
        )
    }

    private func constant(for keyboardFrame: CGRect) -> CGFloat {
        return max(self.view.convert(self.view.frame, to: nil).maxY - keyboardFrame.minY, 0) + self.initialConstant
    }
}
