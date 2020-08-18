//
//  CardDetailEntry.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 16.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import UIKit

final class CardDetailEntry : NSObject {
    
    private let cardNumberTextField : CardDetailTextField!
    private let expirationDateTextField: CardDetailTextField!
    private let cvvTextField: CardDetailTextField!
    
    static let CardNumberMaximumCount = 16
    static let CardNumberMinimumCount = 16
    static let NonBreakingSpace: String = "\u{00a0}"
        
    init(cardNumberTextField : CardDetailTextField,
         expirationDateTextField: CardDetailTextField,
         cvvTextField: CardDetailTextField) {
        self.cardNumberTextField = cardNumberTextField
        self.expirationDateTextField = expirationDateTextField
        self.cvvTextField = cvvTextField
    }
    
}

//MARK: Public Methods

extension CardDetailEntry {
    
    func getExpireDate() -> (Int, Int)? {
        guard let text = expirationDateTextField.text, text.count == 5 else {
            return nil
        }
        
        let components = text.components(separatedBy: "/")
        guard components.count == 2 else {
            return nil
        }
        guard let month = Int(components[0]) else {
            return nil
        }
        guard let year = Int(components[1]) else {
            return nil
        }
        return (month, year)
    }
    
    func cardNumber() -> String? {
        if let number = cardNumberTextField.text?.replacingOccurrences(of: " ", with: "") {
            return number
        }
        return nil
    }
    
}


//MARK: Card Details Formatting

extension CardDetailEntry {
    
    fileprivate func expireDateFormatting(textField: UITextField, range: NSRange, string: String) -> Bool {
        //Range.Lenth will greater than 0 if user is deleting text - Allow it to replce
        if range.length > 0
        {
            return true
        }
        
        //Dont allow empty strings
        if string == " "
        {
            return false
        }
        
        //Check for max length including the spacers we added
        if range.location >= 5
        {
            return false
        }
        
        var originalText = textField.text
        let replacementText = string.replacingOccurrences(of: " ", with: "")
        
        //Verify entered text is a numeric value
        let digits = CharacterSet.decimalDigits
        for char in replacementText.unicodeScalars {
            if !digits.contains(char) {
                return false
            }
        }
        
        //Put / space after 2 digit
        if range.location == 2
        {
            originalText?.append(contentsOf: "/")
            textField.text = originalText
        }
        
        return true
    }
    
    fileprivate func cardNumberEntry(textField: UITextField, range: NSRange, string: String) -> Bool {
        // Allow delete chars
        if string.count == 0 {
            return true
        }
        
        //Range.Lenth will greater than 0 if user is deleting text - Allow it to replce
        if range.length > 0 {
            return false
        }
        
        //Dont allow empty strings
        if string == " " {
            return false
        }
        
        var originalText = textField.text
        let replacementText = string.replacingOccurrences(of: " ", with: "")
        
        // XXXX XXXX XXXX XXXX for a 16 number card or XXXX XXXX XXXX XXXXXXX for a 19.
        //Check for max length including the spacers we added
        // + 2 - spaces in card number
        let charactersLimit = CardDetailEntry.CardNumberMaximumCount
        if range.location > charactersLimit + 2 {
            print("16 characters already entered")
            return false
        }
        
        //Verify entered text is a numeric value
        if !replacementText.isStringOnlyNumbers {
            return false
        }
        
        if replacementText.count == 1 {
            //Put / space after 2 digit
            let numberOfSpaces = originalText?.components(separatedBy: " ") ?? []
            if (range.location - (numberOfSpaces.count - 1)) % 4 == 0 && range.location < CardDetailEntry.CardNumberMaximumCount && range.location > 0 {
                if originalText?.last != " " {
                    originalText?.append(contentsOf: " ")
                }
                textField.text = originalText
            }
        } else if replacementText.count < CardDetailEntry.CardNumberMinimumCount {
            return false
        } else if replacementText.count >= CardDetailEntry.CardNumberMinimumCount && replacementText.count <= CardDetailEntry.CardNumberMaximumCount {
            textField.text = replacementText.formatToCardNumber()
            return false
        }
        
        return true
    }
    
}

//MARK: UITextField Delegate
extension CardDetailEntry : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == expirationDateTextField {
            if !expireDateFormatting(textField:textField, range: range, string: string) {
                cvvTextField.becomeFirstResponder()
                return false
            } else {
                if let text = textField.text {
                    let newLength = text.count + string.count - range.length
                    if newLength == 5 {
                        DispatchQueue.main.async {
                            self.cvvTextField.becomeFirstResponder()
                        }
                    }
                }
                return true
            }
        } else if textField == cardNumberTextField {
            if !cardNumberEntry(textField:textField, range: range, string: string) {
                expirationDateTextField.becomeFirstResponder()
                return false
            } else {
                if let text = textField.text {
                    let newLength = text.count + string.count - range.length
                    if newLength == 19 {
                        DispatchQueue.main.async {
                            self.expirationDateTextField.becomeFirstResponder()
                        }
                    }
                }
                return cardNumberEntry(textField:textField, range: range, string: string)
            }
        } else if textField == cvvTextField {
            if let text = textField.text {
                let newLength = text.count + string.count - range.length
//                print("newLength <= 5: \(newLength <= 5)")
//                if !(newLength < 3) {
//                    DispatchQueue.main.async {
//                        self.cardNumberTextField.becomeFirstResponder()
//                    }
//                }
                return newLength <= 3
            }
        }
        
        return true
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        guard let textField = textField as? CardDetailTextField else { return }
        textField.makeActive()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let textField = textField as? CardDetailTextField else { return }
        textField.makeInactive()
    }
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
    
}

//MARK: Validation

extension CardDetailEntry {
    
    var isCardValid : Bool {
        return isCardNumberValid && isExpirationDateValid && isCvvValid
    }
    
    private var isCardNumberValid : Bool {
        let cardNumber = cardNumberTextField.text?
            .components(separatedBy:CharacterSet
            .decimalDigits
            .inverted)
            .joined()
        if cardNumber?.count != 16 {
            cardNumberTextField.showError(message: "Please enter a valid card number")
            return false
        }
        return true
    }
    
    private var isExpirationDateValid : Bool {
        if expirationDateTextField.text?.count != 5 {
            expirationDateTextField.showError(message: "Enter correct date")
            return false
        }
        return true
    }
    
    private var isCvvValid : Bool {
        if cvvTextField.text?.count != 3 {
            cvvTextField.showError(message: "Please enter full details")
            return false
        }
        return true
    }
    
}

