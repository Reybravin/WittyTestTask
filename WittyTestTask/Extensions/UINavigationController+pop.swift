//
//  UINavigationController+pop.swift
//  WittyTestTask
//
//  Created by Sergiy Sachuk on 17.08.2020.
//  Copyright © 2020 Sachuk. All rights reserved.
//

import UIKit

extension UINavigationController {

    func popToViewControllerOfType(ofClass: AnyClass) {
        for controller in viewControllers {
            if controller.classForCoder == ofClass {
                popToViewController(controller, animated: true)
                break
            }
        }
    }
    
}
