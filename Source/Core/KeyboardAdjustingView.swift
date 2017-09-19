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

    deinit {
        self.unregisterKeyboardNotification()
    }
}
