//
//  TabBarViewController.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 14.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let homeViewController = makeTab(with: HomeViewController(), title: "Home")
        let accountsViewController = makeTab(with: UIViewController(), title: "Accounts")
        let payViewController = makeTab(with: UIViewController(), title: "Pay")
        let cardsViewController = makeTab(with: UIViewController(), title: "Cards")
        let settingsViewController = makeTab(with: UIViewController(), title: "Settings")
       
        let controllers = [homeViewController, accountsViewController, payViewController, cardsViewController, settingsViewController]
        viewControllers = controllers.map { UINavigationController(rootViewController: $0)}
            
    }
    
    private func makeTab(with vc: UIViewController, title: String) -> UIViewController {
        vc.title = title
        vc.tabBarItem = makeBarItem(title: title)
        return vc
    }
    
    private func makeBarItem(title : String, image: UIImage? = nil, selectedImage : UIImage? = nil) -> UITabBarItem {
        return UITabBarItem(title: title, image: image, selectedImage: selectedImage)
    }

}

