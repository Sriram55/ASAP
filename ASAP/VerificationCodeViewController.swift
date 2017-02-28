//
//  VerificationCodeViewController.swift
//  ASAP
//
//  Created by Sriram Velaga on 16/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

class VerificationCodeViewController: UIViewController {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var verificationTitleLabel: UILabel!
    @IBOutlet weak var verificationCodeTextField: UITextField!
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBOutlet weak var verificationCodeValidationLabel: UILabel!
    // MARK: View lifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: Private API
    
    func prepareView() {
        self.navigationItem.hidesBackButton = true
        confirmBtn.layer.cornerRadius = confirmBtn.frame.size.height/2.0
        let startIndex = ASAPUserDefaults.sharedInstance.mobileNumber().index(ASAPUserDefaults.sharedInstance.mobileNumber().startIndex, offsetBy: 6)

        self.logoImageView?.image = self.logoImageView?.image!.withRenderingMode(.alwaysTemplate)
        self.logoImageView?.tintColor = UIColor.white
        
        verificationTitleLabel?.text = "Hello \(ASAPUserDefaults.sharedInstance.firstName()), we have sent verification code to your mobile ending with ******\(ASAPUserDefaults.sharedInstance.mobileNumber().substring(from: startIndex))"
        
        
    }
    
    // MARK: IBAction Methods
    
    @IBAction func validateVerificationCode(_ sender: Any) {
        
        let parameters = ["_token": ASAPUserDefaults.sharedInstance.token(), "users_id": ASAPUserDefaults.sharedInstance.userId(),"code": self.verificationCodeTextField.text!]
        
        ASAPHttpClinetManager.sharedInstance.verifyOTP(parameters, success: { (_result) in
            
            if _result["result"]["status_code"] == "200" {
                print("User Registered in", _result);
                self.verificationCodeValidationLabel?.text! = ""
                let asapTabBarController = self.storyboard!.instantiateViewController(withIdentifier: "ASAPTabbarViewController") as! ASAPTabbarViewController
                self.navigationController?.pushViewController(asapTabBarController, animated: true)
            }else {
                let alert = UIAlertController(title: "Error", message: _result["result"]["message"].string!, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }) { (Error) in
            let alert = UIAlertController(title: "Error", message: Error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    @IBAction func resendOTP(_ sender: UIButton) {
        
        let parameters = ["users_id": ASAPUserDefaults.sharedInstance.userId(),"phone_number": ASAPUserDefaults.sharedInstance.mobileNumber()]
        
        ASAPHttpClinetManager.sharedInstance.resendOTP(parameters, success: { (_result) in
            
            if _result["result"]["status_code"] == "200" {
                print("Resend successful in", _result);
            
            }else {
                let alert = UIAlertController(title: "Error", message: _result["result"]["message"].string!, preferredStyle: UIAlertControllerStyle.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            
        }) { (Error) in
            let alert = UIAlertController(title: "Error", message: Error.localizedDescription, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    // MARK: UITextField Delegate Methods

    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    {
        switch textField {
        case verificationCodeTextField:
            
            if (range.length == 0 && (textField.text?.characters.count)! > 4) //Password limited to 4 characters
            {
                return false
            } else {
                return true
            }
            
        default:
            return true
        }
        
    }
    
    @IBAction func textFieldDidChange(_ textField: UITextField) {
        
        switch textField {
            
        // SignIn Fields
        case verificationCodeTextField:
            
            self.verificationCodeValidationLabel.text = ((self.verificationCodeTextField.text?.characters.count)! < 4) ? "Max. of 4 digits" : ""
            break
            
        default: break
            
        }
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        switch textField {
            
        // SignIn Fields
        case verificationCodeTextField:
            self.verificationCodeValidationLabel.text = ""
            break
            
        default: break

        }
    }
}
