//
//  KeyboardLayoutConstraint.swift
//  SwiftyKeyboardObserver
//
//  Created by Adrian Bobrowski on 26.08.2017.
//  Copyright © 2017 Adrian Bobrowski (Decybel07), adrian071993@gmail.com. All rights reserved.
//

import UIKit

open class KeyboardLayoutConstraint: NSLayoutConstraint, KeyboardObserver {

    @IBOutlet
    public weak var containerView: UIView! {
        didSet {
            self.initialConstant = self.constant
            self.registerKeyboardNotification()
        }
    }

    public var keyboardWillChangeFrameObserver: NSObjectProtocol?
    public var initialConstant: CGFloat = 0

    public var view: UIView! {
        return self.containerView
    }

    public var constraint: NSLayoutConstraint! {
        return self
    }

    deinit {
        self.unregisterKeyboardNotification()
    }
}
