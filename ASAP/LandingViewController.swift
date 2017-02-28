//
//  ViewController.swift
//  ASAP
//
//  Created by Sriram Velaga on 10/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import UIKit

class LandingViewController: UIViewController {
    
    @IBOutlet weak var registrationBtn: UIButton!
    @IBOutlet weak var loginBtn: UIButton!
    
    // MARK: View LifeCycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.prepareView()
        self.getToken()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.statusBarStyle = .default

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Priavte API
    
    func prepareView() {
        
        registrationBtn.layer.cornerRadius = registrationBtn.frame.size.height/2.0
        loginBtn.layer.cornerRadius = loginBtn.frame.size.height/2.0
        loginBtn.layer.borderColor = UIColor().asapThemeColor().cgColor
        loginBtn.layer.borderWidth = 2.0
    }
    
    func getToken() {
        
        ASAPHttpClinetManager.sharedInstance.getTokenForDevice("", parameters: ["":""], success: { (_result) in
            
            if _result["result"]["status_code"] == "200" {
                print("Token is", _result)

                ASAPUserDefaults.sharedInstance.setToken(_result["result"]["data"]["info"]["_token"].string!) 
            }else{
                print("Unable to get Token", _result)

            }
            
        }) { (_error) in
            print("Error is ", _error)

        }
    }

    // MARK: IBAction Methods
    
    @IBAction func goToRegistration(_ sender: UIButton) {
        let signInOrSignUpVC = self.storyboard!.instantiateViewController(withIdentifier: "SignInOrSignUpViewController") as! SignInOrSignUpViewController
        signInOrSignUpVC.isSignInSelected = false
        self.navigationController?.pushViewController(signInOrSignUpVC, animated: true)
        
    }

    @IBAction func goToLogin(_ sender: UIButton) {
        let signInOrSignUpVC = self.storyboard!.instantiateViewController(withIdentifier: "SignInOrSignUpViewController") as! SignInOrSignUpViewController
        signInOrSignUpVC.isSignInSelected = true
        self.navigationController?.pushViewController(signInOrSignUpVC, animated: true)
    }
    
    @IBAction func goToHelp(_ sender: UIButton) {
        
        let asapTabBarController = self.storyboard!.instantiateViewController(withIdentifier: "ASAPTabbarViewController") as! ASAPTabbarViewController
        self.navigationController?.pushViewController(asapTabBarController, animated: true)
    }
}

extension LandingViewController {
    
    
    
}
