//
//  KeyboardObserver.swift
//  SwiftyKeyboardObserver
//
//  Created by Adrian Bobrowski on 23.08.2017.
//  Copyright © 2017 Adrian Bobrowski (Decybel07), adrian071993@gmail.com. All rights reserved.
//

import UIKit

/// Protocol KeyboardObserver.
///
/// Adjusts the constant value of the constraint when the keyboard appears, moves and disappears.
///
public protocol KeyboardObserver: class {

    /// Observer for required notification.
    var keyboardWillChangeFrameObserver: NSObjectProtocol? { get set }

    /// Initial constant.
    var initialConstant: CGFloat { get }

    /// The constraint to which the constant value will be changed.
    var constraint: NSLayoutConstraint! { get }

    /// The view for which the constant value of the constraint will be calculated.
    var view: UIView! { get }
}

public extension KeyboardObserver {

    /// Register required notification.
    ///
    /// - Important:
    /// If you register notification then remember to call *unregisterKeyboardNotification*.
    ///
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

    /// Unregister notification.
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
                self.constraint?.constant = self.constant(for: frame)
                self.view.layoutIfNeeded()
            }
        )
    }

    private func constant(for keyboardFrame: CGRect) -> CGFloat {
        let length = (
            (self.constraint.firstItem as? UILayoutSupport) ??
                (self.constraint.secondItem as? UILayoutSupport)
        )?.length ?? 0

        return (keyboardFrame.maxY == UIScreen.main.bounds.maxY
            ? max(self.view.convert(self.view.frame, to: nil).maxY - keyboardFrame.minY - length, 0) : 0
        ) + self.initialConstant
    }
}
