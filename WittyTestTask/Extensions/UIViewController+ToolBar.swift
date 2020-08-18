//
//  UIViewController+ToolBar.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 17.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import UIKit

extension UIViewController: UITextFieldDelegate {
    
    func addToolBar(textField: UITextField, button: UIButton) {

        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = .white

        let doneButton = UIBarButtonItem(customView: button)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        toolBar.setItems([spaceButton, doneButton], animated: true)

        toolBar.isUserInteractionEnabled = true
        toolBar.sizeToFit()

        textField.delegate = self
        textField.inputAccessoryView = toolBar
    }

}
