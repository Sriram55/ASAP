//
//  SignIn:SignUpViewController.swift
//  ASAP
//
//  Created by Sriram Velaga on 13/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit
import ACFloatingTextfield

class SignInOrSignUpViewController: UIViewController
{
    // MARK: SignInControls
    
    @IBOutlet weak var signInEmailTextField: ACFloatingTextfield!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
}
