//
//  ASAPTabbarViewController.swift
//  ASAP
//
//  Created by Sriram Velaga on 14/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

class ASAPTabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK: View LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        prepareView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private API
    
    func prepareView() {
        UIApplication.shared.statusBarStyle = .lightContent
        
        let selectedColor   = UIColor(white: 1, alpha: 1)
        let unselectedColor = UIColor(white: 1, alpha: 0.8)
        
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: unselectedColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSForegroundColorAttributeName: selectedColor], for: .selected)
        
    }
    
}
