//
//  NextResponderTextField.swift
//  Example
//
//  Created by Adrian Bobrowski on 09.09.2017.
//  Copyright © 2017 Adrian Bobrowski (Decybel07), adrian071993@gmail.com. All rights reserved.
//

import UIKit

final class NextResponderTextField: UITextField, UITextFieldDelegate {

    @IBOutlet
    private weak var nextResponderField: UIResponder?

    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.delegate = self
    }

    func textFieldShouldReturn(_: UITextField) -> Bool {
        if self.nextResponderField?.canBecomeFirstResponder ?? false {
            self.nextResponderField!.becomeFirstResponder()
            return false
        }
        self.resignFirstResponder()
        return true
    }
}
