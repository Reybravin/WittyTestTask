//
//  HomeViewController.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 14.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    //MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: Actions
    
    @IBAction func addAction(_ sender: Any) {
        showAddMoneyViewController()
    }
    
    //MARK: Navigation
    
    private func showAddMoneyViewController(){
        let vc = AddMoneyMethodsViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
