//
//  PaymentVerificationViewController.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 14.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import UIKit

class PaymentVerificationViewController: UIViewController {

    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    //MARK: UI Setup
    
    private func setupView(){
        view.backgroundColor = .white
        title = "3DS Verification"
        addNextNavButton()
    }
    
    private func addNextNavButton(){
        let item = UIBarButtonItem(title: "Next", style: .done, target:  self, action: #selector(nextAction))
        self.navigationItem.rightBarButtonItem = item
    }
    
    //MARK: Actions
    
    @objc private func nextAction(){
        showHomeViewController()
    }
    
    //MARK: Navigation
    
    private func showHomeViewController(){
        let vc = PaymentSuccessViewController(nibName: String(describing: PaymentSuccessViewController.self), bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
}
