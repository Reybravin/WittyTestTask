//
//  WittyTextField.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 14.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import UIKit

class CardDetailTextField: UITextField {
            
    override var text: String? {
        didSet {
            if (text?.count)! > 0 {
                makeActive(withAnimation: false)
                if !isFirstResponder {
                    makeInactive(withAnimation: false)
                }
            }
        }
    }
    
    fileprivate let kDefaultAnimationDuration: Double = 0.15
    
    fileprivate var errorLabel: UILabel?
    
    private var errorColor: UIColor = UIColor(red: 255.0 / 255.0, green: 97.0 / 255.0, blue: 121.0 / 255.0, alpha: 1.0) {
        didSet {
            self.errorLabel?.textColor = errorColor
        }
    }
    
    var errorText: String? {
        didSet {
            self.errorLabel?.text = errorText
        }
    }
    
    
    // MARK: - Life cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
   
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        addErrorLabel()
        if isFirstResponder {
            makeActive(withAnimation: false)
        }
    }
    
    //MARK: - Methods
        
    fileprivate func addErrorLabel() {
        if errorLabel != nil {
            return
        }
        errorLabel = UILabel()
        errorLabel?.backgroundColor = UIColor.clear
        errorLabel?.font = self.font?.withSize(12)
        errorLabel?.text = ""
        errorLabel?.textColor = errorColor
        errorLabel?.sizeToFit()
        errorLabel?.alpha = 0.0
        errorLabel?.isUserInteractionEnabled = false
        self.addSubview(errorLabel!)
        errorLabel?.translatesAutoresizingMaskIntoConstraints = false
        errorLabel?.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        errorLabel?.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        errorLabel?.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 20).isActive = true
    }
    
    // MARK: - Field states
    
    func makeActive(withAnimation animate:Bool? = true) {
        var duration = kDefaultAnimationDuration
        if animate == false {
            duration = 0.0
        }

        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: {
            self.errorLabel?.alpha = 0.0
        }, completion: nil)
    }
    
    func makeInactive(withAnimation animate:Bool? = true) {
        var duration = kDefaultAnimationDuration
        if animate == false {
            duration = 0.0
        }
        UIView.animate(withDuration: duration, delay: 0.0, options: [.curveLinear], animations: {
            self.errorLabel?.alpha = 0.0
        }, completion: nil)
    }
    
    fileprivate func makeFieldError() {
        UIView.animate(withDuration: kDefaultAnimationDuration, delay: 0.0, options: [.curveLinear], animations: {
            self.errorLabel?.alpha = 1.0
            if self.text?.count == 0 {
                if !self.isFirstResponder {
                }
            }
        }, completion: nil)
    }
    
    // MARK: - Public methods
    
    func showError(message errorMessage:String, withResignFirstResponder resign:Bool? = false) {
        errorText = errorMessage
        if resign! {
            self.resignFirstResponder()
        }
        makeFieldError()
    }

}
