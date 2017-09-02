//
//  KeyboardAdjustingView.swift
//  SwiftyKeyboardObserver
//
//  Created by Adrian Bobrowski on 26.08.2017.
//  Copyright © 2017 Adrian Bobrowski (Decybel07), adrian071993@gmail.com. All rights reserved.
//

import UIKit

open class KeyboardAdjustingView: UIView, KeyboardObserver {

    @IBInspectable
    public var hideKeyboardOnTap: Bool = false

    @IBOutlet
    public weak var keyboardConstraint: NSLayoutConstraint! {
        didSet {
            self.initialConstant = self.keyboardConstraint.constant
            self.registerKeyboardNotification()
        }
    }

    public var keyboardWillChangeFrameObserver: NSObjectProtocol?
    public var initialConstant: CGFloat = 0

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
