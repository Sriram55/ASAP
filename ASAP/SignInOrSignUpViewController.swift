//
//  SignIn:SignUpViewController.swift
//  ASAP
//
//  Created by Sriram Velaga on 13/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation
import UIKit

class SignInOrSignUpViewController: UIViewController, UITextFieldDelegate, UIScrollViewDelegate
{
    @IBOutlet weak var signInSignUpContainerScrollView: UIScrollView!
    // MARK: SignInControls
    
    @IBOutlet weak var logoImageView: UIImageView!
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
    
    @IBOutlet weak var signUpSelectionIndicatorView: UIView!
    @IBOutlet weak var signInSelectionIndicatorView: UIView!
    @IBOutlet weak var titleLabel: UILabel!

    var isSignInSelected: Bool!

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
        self.signInSignUpContainerScrollView.contentSize = CGSize(width: self.view.frame.size.width * 2,height: self.signInSignUpContainerScrollView.frame.size.height)
        
        self.logoImageView?.image = self.logoImageView?.image!.withRenderingMode(.alwaysTemplate)
        self.logoImageView?.tintColor = UIColor.white
        
        if (isSignInSelected!) {
            self.signInSelectionIndicatorView.backgroundColor = UIColor().selectionIndicatorSelectedColor()
            titleLabel.text = "Sign In"
        }else {
            self.signUpSelectionIndicatorView.backgroundColor = UIColor().selectionIndicatorSelectedColor()
            self.signInSignUpContainerScrollView.contentOffset = CGPoint(x: self.view.frame.size.width,y: 0)
            titleLabel.text = "Sign Up"
        }
        
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
        
        if self.signInEmailTextField.text == ""  {
            self.signInEmailValidationLabel.text = "Enter email"
            return
        }
        
        if self.signInPasswordTextField.text == ""  {
            self.signInPasswordValidationLabel.text = "Enter password"
            return
        }
        
        let parameters = ["_token": ASAPUserDefaults.sharedInstance.token(), "email": self.signInEmailTextField.text!,"password": self.signInPasswordTextField.text!]
        
        ASAPHttpClinetManager.sharedInstance.authenticateUser(parameters, success: { (_result) in
            
            if _result["result"]["status_code"] == "200" {
                print("User Logged in", _result);
                ASAPUserDefaults.sharedInstance.setUserId(_result["result"]["data"]["info"]["users_id"].string!)
                ASAPUserDefaults.sharedInstance.setEmail(_result["result"]["data"]["info"]["email"].string!)
                ASAPUserDefaults.sharedInstance.setMobileNumber(_result["result"]["data"]["info"]["phone_number"].string!)
                ASAPUserDefaults.sharedInstance.setFirstName(_result["result"]["data"]["info"]["first_name"].string!)

                
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
    
    @IBAction func navigateToRegistrationPage(_ sender: UIButton) {
        self.signInSignUpContainerScrollView.setContentOffset(CGPoint(x: self.view.frame.size.width, y: 0), animated: true)
    }
    
    // MARK: SignUp
    // MARK: IBAction Methods
    
    @IBAction func registerUser(_ sender: UIButton) {
        
        if self.signUpUsernameTextField.text == ""  {
            self.signUpUsernameValidationLabel.text = "Enter your name"
            return
        }
        
        if self.signUpEmailTextField.text == ""  {
            self.signUpEmailValidationLabel.text = "Enter email"
            return
        }
        
        if self.signUpPasswordTextField.text == ""  {
            self.signUpPasswordValidationLabel.text = "Enter password"
            return
        }
        
        if self.signUpMobileNumberTextField.text == ""  {
            self.signUpMobileNumberValidationLabel.text = "Enter mobile"
            return
        }
        
        let parameters = ["_token": ASAPUserDefaults.sharedInstance.token(), "email": self.signUpEmailTextField.text!,"password": self.signUpPasswordTextField.text!, "phone_number" : self.signUpMobileNumberTextField.text!, "first_name": self.signUpUsernameTextField.text!, "last_name" : ""]
        
        ASAPHttpClinetManager.sharedInstance.registerUser(parameters, success: { (_result) in
            
            print("Result is ", _result)
            
            if _result["result"]["status_code"] == "200" {
                
                
                ASAPUserDefaults.sharedInstance.setUserId(_result["result"]["data"]["info"]["users_id"].string!)
                ASAPUserDefaults.sharedInstance.setEmail(_result["result"]["data"]["info"]["email"].string!)
                ASAPUserDefaults.sharedInstance.setMobileNumber(_result["result"]["data"]["info"]["phone_number"].string!)
                ASAPUserDefaults.sharedInstance.setFirstName(_result["result"]["data"]["info"]["first_name"].string!)

                print("User Registered in", _result);
                let verificationCodeVC = self.storyboard!.instantiateViewController(withIdentifier: "VerificationCodeViewController") as! VerificationCodeViewController
                self.navigationController?.pushViewController(verificationCodeVC, animated: true)
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
    
    @IBAction func navigateToLoginPage(_ sender: UIButton) {
        self.signInSignUpContainerScrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
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
            
        // SignIn Fields
        case signInEmailTextField:
            
            self.signInEmailValidationLabel.text = isValidEmail(testStr: textField.text!) ? "" : "Invalid email"
            
            break
            
        case signInPasswordTextField:
            
           self.signInPasswordValidationLabel.text = ((self.signInPasswordTextField.text?.characters.count)! < 5) ? "Min. of 5 characters" : ((self.signInPasswordTextField.text?.characters.count)! >= 5 && (self.signInPasswordTextField.text?.characters.count)! < 8) ? "Max. of 8 characters" : ""
            break
            
        // SignUp Fields
        case signUpEmailTextField:
            
            self.signUpEmailValidationLabel.text = isValidEmail(testStr: textField.text!) ? "" : "Invalid email"
            
            break
    
        case signUpPasswordTextField:
            
            self.signUpPasswordValidationLabel.text = ((self.signUpPasswordTextField.text?.characters.count)! < 5) ? "Min. of 5 characters" : ((self.signUpPasswordTextField.text?.characters.count)! >= 5 && (self.signUpPasswordTextField.text?.characters.count)! < 8) ? "Max. of 8 characters" : ""
            break

        case signUpConfirmPasswordTextField:
            
            self.signUpConfirmPasswordValidationLabel.text = (self.signUpConfirmPasswordTextField.text == self.signUpPasswordTextField.text) ? "" : "Password doesn't matched"
            break
            
        default: break
            
        }
        
        
    }
    
    public func textFieldDidEndEditing(_ textField: UITextField, reason: UITextFieldDidEndEditingReason) {
        
        switch textField {

        // SignIn Fields
        case signInEmailTextField:
            self.signInEmailValidationLabel.text = ""
            break
    
        case signInPasswordTextField:
            self.signInPasswordValidationLabel.text = ""
            break
            
        // SignUp Fields
        case signUpEmailTextField:
            self.signUpEmailValidationLabel.text = ""
            
            break
            
        case signUpPasswordTextField:
            self.signUpPasswordValidationLabel.text = ""
            
            break
            
        case signUpConfirmPasswordTextField:
            self.signUpConfirmPasswordValidationLabel.text = ""
            
            break
            
        default:
            break
        }
        
    }
    
    // MARK: ScrollView Delegate Methods
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) // any offset changes
    {
     
       let currentPage = round(self.signInSignUpContainerScrollView.contentOffset.x/self.signInSignUpContainerScrollView.bounds.size.width)
        
        if currentPage == 0 {
            self.signInSelectionIndicatorView.backgroundColor = UIColor().selectionIndicatorSelectedColor()
            self.signUpSelectionIndicatorView.backgroundColor = UIColor().selectionIndicatorNotSelectedColor()
            titleLabel.text = "Sign In"

        } else {
            self.signInSelectionIndicatorView.backgroundColor = UIColor().selectionIndicatorNotSelectedColor()
            self.signUpSelectionIndicatorView.backgroundColor = UIColor().selectionIndicatorSelectedColor()
            titleLabel.text = "Sign Up"

        }

    }
    
}
