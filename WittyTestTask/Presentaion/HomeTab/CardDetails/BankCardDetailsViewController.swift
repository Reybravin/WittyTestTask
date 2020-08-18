//
//  BankCardDetailsViewController.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 14.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import UIKit

class CardDetailsViewController: UIViewController {

    @IBOutlet weak var cardNumberTextField: CardDetailTextField!
    @IBOutlet weak var expirationDateTextField: CardDetailTextField!
    @IBOutlet weak var cvvTextField: CardDetailTextField!
    @IBOutlet weak var cardTypeImageView: UIImageView!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var continueButtonBottomConstraint: NSLayoutConstraint!
    
    private var continueButtonBottomDefaultConstraint : CGFloat = 20
    private var cardDetailEntry : CardDetailEntry!
    
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        registerForKeyboardNotifications()
    }

    //MARK: UI Setup
    
    private func setupView(){
        title = "Card Details"
        cardDetailEntry = CardDetailEntry(cardNumberTextField: cardNumberTextField,
                                          expirationDateTextField: expirationDateTextField,
                                          cvvTextField: cvvTextField)

        cardNumberTextField.delegate = cardDetailEntry
        expirationDateTextField.delegate = cardDetailEntry
        cvvTextField.delegate = cardDetailEntry
        
    }
    
    //MARK: Actions
    
    @IBAction func continueAction(_ sender: Any) {
        if cardDetailEntry.isCardValid {
            showAmountEnterViewController()
        }
    }
    
    //MARK: Navigation
    
    private func showAmountEnterViewController(){
        let card = BankCard(cardNumber: cardNumberTextField.text ?? "",
                            expirationDate: expirationDateTextField.text ?? "",
                            cvv: cvvTextField.text ?? "",
                            bankTitle: "STARLING BANK",
                            paymentSystem: "VISA")
        let vc = AmountTableViewController.create(with: card)
        navigationController?.pushViewController(vc, animated: true)
    }

}


//MARK: - Keyboard handling

private extension CardDetailsViewController {
    
    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func handleKeyboard(notification: Notification) {
        // 1. Keyboard is hiding.
        guard notification.name == UIResponder.keyboardWillChangeFrameNotification else {
            continueButtonBottomConstraint.constant = continueButtonBottomDefaultConstraint
            view.layoutIfNeeded()
            return
        }
        
        // 2. Keyboard is showing
        if continueButtonBottomConstraint.constant == continueButtonBottomDefaultConstraint {
            
            guard
                let info = notification.userInfo,
                let keyboardFrame = info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
                else {
                    return
            }
            
            // 2
            let keyboardHeight = keyboardFrame.cgRectValue.size.height
            UIView.animate(withDuration: 0.1, animations: { () -> Void in
                self.continueButtonBottomConstraint.constant = keyboardHeight//+=keyboardHeight
                self.view.layoutIfNeeded()
            })
            
        }
        
    }
}
