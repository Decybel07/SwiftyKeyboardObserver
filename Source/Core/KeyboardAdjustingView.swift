//
//  KeyboardAdjustingView.swift
//  SwiftyKeyboardObserver
//
//  Created by Adrian Bobrowski on 26.08.2017.
//  Copyright © 2017 Adrian Bobrowski (Decybel07), adrian071993@gmail.com. All rights reserved.
//

import UIKit

open class KeyboardAdjustingView: UIView, KeyboardObserver {

    @IBOutlet
    public weak var keyboardConstraint: NSLayoutConstraint! {
        didSet {
            self.registerKeyboardNotification()
        }
    }

    @IBInspectable
    public var hideKeyboardOnTap: Bool = false {
        didSet {
            if self.hideKeyboardOnTap {
                self.addGestureRecognizer(self.tapGestureRecognizer)
            } else {
                self.removeGestureRecognizer(self.tapGestureRecognizer)
            }
        }
    }

    private lazy var tapGestureRecognizer: UITapGestureRecognizer = {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(self.hideKeyboard))
        gestureRecognizer.cancelsTouchesInView = false
        return gestureRecognizer
    }()

    public var keyboardWillChangeFrameObserver: NSObjectProtocol?

    public var view: UIView! {
        return self
    }

    public var constraint: NSLayoutConstraint! {
        return self.keyboardConstraint
    }

    public func hideKeyboard() {
        self.endEditing(true)
    }

    deinit {
        self.unregisterKeyboardNotification()
    }
}
