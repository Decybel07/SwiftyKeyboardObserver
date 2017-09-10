//
//  KeyboardAdjustingView.swift
//  SwiftyKeyboardObserver
//
//  Created by Adrian Bobrowski on 26.08.2017.
//  Copyright © 2017 Adrian Bobrowski (Decybel07), adrian071993@gmail.com. All rights reserved.
//

import UIKit

/// Class KeyboardAdjustingView.
open class KeyboardAdjustingView: UIView, KeyboardObserver {

    /// Boolean value that determines whether the view will hide keyboard on tap.
    ///
    /// If is true then keyboard will be hide when user
    /// tap outsite [UITextInput](apple-reference-documentation://hsYPLVjxug) but on this view.
    ///
    @IBInspectable
    open var hideKeyboardOnTap: Bool = false

    /// The constraint to which the constant value will be changed.
    @IBOutlet
    open weak var keyboardConstraint: NSLayoutConstraint! {
        didSet {
            self.initialConstant = self.keyboardConstraint.constant
            self.registerKeyboardNotification()
        }
    }

    open var keyboardWillChangeFrameObserver: NSObjectProtocol?
    private(set) public var initialConstant: CGFloat = 0

    public var view: UIView! {
        return self
    }

    public var constraint: NSLayoutConstraint! {
        return self.keyboardConstraint
    }

    open override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)

        if self.hideKeyboardOnTap {
            self.endEditing(true)
        }
    }

    deinit {
        self.unregisterKeyboardNotification()
    }
}
