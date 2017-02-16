//
//  SignIn:SignUpViewController.swift
//  ASAP
//
//  Created by Sriram Velaga on 13/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

class SignInOrSignUpViewController: UIViewController, UITextFieldDelegate
{
    @IBOutlet weak var signInSignUpContainerScrollView: UIScrollView!
    // MARK: SignInControls
    
    @IBOutlet weak var signInPasswordValidationLabel: UILabel!
    @IBOutlet weak var signInPasswordTextField: ACFloatingTextfield!
    @IBOutlet weak var signInEmailTextField: ACFloatingTextfield!
    @IBOutlet weak var signInEmailValidationLabel: UILabel!
    
    
    @IBOutlet weak var signInLoginBtn: UIButton!
    @IBOutlet weak var signInForgotPasswordBtn: UIButton!
    
    // MARK: SignUpControls
    @IBOutlet weak var signUpConfirmPasswordTextField: ACFloatingTextfield!
    @IBOutlet weak var signUpConfirmPasswordValidationLabel: UILabel!

    @IBOutlet weak var signUpPasswordTextField: ACFloatingTextfield!
    @IBOutlet weak var signUpPasswordValidationLabel: UILabel!

    @IBOutlet weak var signUpMobileNumberTextField: ACFloatingTextfield!
    @IBOutlet weak var signUpMobileNumberValidationLabel: UILabel!

    @IBOutlet weak var signUpEmailTextField: ACFloatingTextfield!
    @IBOutlet weak var signUpEmailValidationLabel: UILabel!

    @IBOutlet weak var signUpUsernameTextField: ACFloatingTextfield!
    @IBOutlet weak var signUpUsernameValidationLabel: UILabel!
    
    @IBOutlet weak var signUpLoginBtn: UIButton!
    @IBOutlet weak var signUpBtn: UIButton!
    
    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
    
    // MARK: View lifeCycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        prepareView()
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.statusBarStyle = .lightContent
        

    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    
    // MARK: SignIn

    // MARK: Private API
    
    func prepareView() {
        self.navigationItem.hidesBackButton = true
        signInLoginBtn.layer.cornerRadius = signInLoginBtn.frame.size.height/2.0
        signUpBtn.layer.cornerRadius = signUpBtn.frame.size.height/2.0
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardNotification(notification:)), name: NSNotification.Name.UIKeyboardWillChangeFrame, object: nil)

    }
    
    // MARK: Validations
    
    func isValidEmail(testStr:String) -> Bool {
        print("validate emilId: \(testStr)")
        let emailRegEx = "^(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?(?:(?:(?:[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+(?:\\.[-A-Za-z0-9!#$%&’*+/=?^_'{|}~]+)*)|(?:\"(?:(?:(?:(?: )*(?:(?:[!#-Z^-~]|\\[|\\])|(?:\\\\(?:\\t|[ -~]))))+(?: )*)|(?: )+)\"))(?:@)(?:(?:(?:[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)(?:\\.[A-Za-z0-9](?:[-A-Za-z0-9]{0,61}[A-Za-z0-9])?)*)|(?:\\[(?:(?:(?:(?:(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))\\.){3}(?:[0-9]|(?:[1-9][0-9])|(?:1[0-9][0-9])|(?:2[0-4][0-9])|(?:25[0-5]))))|(?:(?:(?: )*[!-Z^-~])*(?: )*)|(?:[Vv][0-9A-Fa-f]+\\.[-A-Za-z0-9._~!$&'()*+,;=:]+))\\])))(?:(?:(?:(?: )*(?:(?:(?:\\t| )*\\r\\n)?(?:\\t| )+))+(?: )*)|(?: )+)?$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        let result = emailTest.evaluate(with: testStr)
        return result
    }
    
    // MARK: IBAction Methods
    
    @IBAction func tapGestureRecognized(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    @IBAction func showForgotPasswordView(_ sender: UIButton) {
        
    }
    
    @IBAction func authenticateUser(_ sender: UIButton) {
        
    }
    
    @IBAction func navigateToRegistrationPage(_ sender: UIButton) {
        
    }
    
    // MARK: SignUp
    // MARK: IBAction Methods
    
    @IBAction func registerUser(_ sender: UIButton) {
        
    }
    
    @IBAction func navigateToLoginPage(_ sender: UIButton) {
        
    }
    
    // MARK: Keyboard Listeners
    
    func keyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let endFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let duration:TimeInterval = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue ?? 0
            let animationCurveRawNSN = userInfo[UIKeyboardAnimationCurveUserInfoKey] as? NSNumber
            let animationCurveRaw = animationCurveRawNSN?.uintValue ?? UIViewAnimationOptions.curveEaseInOut.rawValue
            let animationCurve:UIViewAnimationOptions = UIViewAnimationOptions(rawValue: animationCurveRaw)
            if (endFrame?.origin.y)! >= UIScreen.main.bounds.size.height {
                self.keyboardHeightLayoutConstraint?.constant = 0.0
//                self.signInSignUpContainerScrollView.isScrollEnabled = true
            } else {
                self.keyboardHeightLayoutConstraint?.constant = endFrame?.size.height ?? 0.0
//                self.signInSignUpContainerScrollView.isScrollEnabled = false
            }
            UIView.animate(withDuration: duration,
                           delay: TimeInterval(0),
                           options: animationCurve,
                           animations: { self.view.layoutIfNeeded() },
                           completion: nil)
        }
    }
    
    // MARK: UITextField Delegate Methods
    
    public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool // return NO to not change text
    {
        switch textField {
        case signInPasswordTextField:
            
            if (range.length == 0 && (textField.text?.characters.count)! > 7) //Password limited to 8 characters
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
        case signInEmailTextField:
            
            self.signInEmailValidationLabel.text = isValidEmail(testStr: textField.text!) ? "" : "Invalid email"
            
            break
            
        case signInPasswordTextField:
            
           self.signInPasswordValidationLabel.text = ((self.signInPasswordTextField.text?.characters.count)! < 5) ? "Min. of 5 characters" : ((self.signInPasswordTextField.text?.characters.count)! >= 5 && (self.signInPasswordTextField.text?.characters.count)! < 8) ? "Max. of 8 characters" : ""
            break
            
        default: break
            
        }
        
        
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        switch textField {
            
        case signInEmailTextField:
            self.signInEmailValidationLabel.text = ""
            break
    
        case signInPasswordTextField:
            self.signInPasswordValidationLabel.text = ""
            break
            
        default:
            break
        }
        
    }
    
}
