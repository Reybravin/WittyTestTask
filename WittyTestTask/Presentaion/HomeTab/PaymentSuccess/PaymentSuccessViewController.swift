//
//  PaymentSuccessViewController.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 14.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import UIKit

class PaymentSuccessViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func returnHomeAction(_ sender: Any) {
        showHomeViewController()
    }
    
    //MARK: Navigation
    
    private func showHomeViewController(){
        navigationController?.popToRootViewController(animated: true)
    }
    
}
