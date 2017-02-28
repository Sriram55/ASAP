//
//  ASAPUserDefaults.swift
//  ASAP
//
//  Created by Sriram Velaga on 22/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation

class ASAPUserDefaults: NSObject {
    
    static let sharedInstance = ASAPUserDefaults()
    
    func setToken(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: "token")
    }
    
    func token() -> String {
       return (UserDefaults.standard.value(forKey: "token") as? String!)!
    }

    func setUserId(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: "user_id")
    }
    
    func userId() -> String {
        return (UserDefaults.standard.value(forKey: "user_id") as? String!)!
    }
    
    func setEmail(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: "email")
    }
    
    func email() -> String {
        return (UserDefaults.standard.value(forKey: "email") as? String!)!
    }
    
    func setMobileNumber(_ token: String) {
        UserDefaults.standard.setValue(token, forKey: "mobile_number")
    }
    
    func mobileNumber() -> String {
        return (UserDefaults.standard.value(forKey: "mobile_number") as? String!)!
    }
    
    func setFirstName(_ firstName: String) {
        UserDefaults.standard.setValue(firstName, forKey: "first_name")
    }
    
    func firstName() -> String {
        return (UserDefaults.standard.value(forKey: "first_name") as? String!)!
    }
}
