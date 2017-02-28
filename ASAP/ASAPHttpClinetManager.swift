//
//  ASAPHttpClinetManager.swift
//  ASAP
//
//  Created by Sriram Velaga on 20/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//
import UIKit
import Foundation
import Alamofire
import SwiftyJSON

enum JSONValue
{
    case jNumber(NSNumber)
    case jString(String)
    case jBool(Bool)
    case jNull
    case jArray(Array<JSONValue>)
    case jObject(Dictionary<String,JSONValue>)
    case jInvalid(NSError)
}

enum DownloadImageType
{
    case site
    case userProfile
}

typealias AlamofireResponseCompletionBlock = (URLRequest, HTTPURLResponse?, AnyObject?, NSError?) -> Void

typealias APIResourceResponseCompletionBlock = (URLRequest, HTTPURLResponse?, JSONValue?, NSError?) -> Void
typealias APICollectionResponseCompletionBlock = (URLRequest, HTTPURLResponse?, [JSONValue]?, Int?, NSError?) -> Void

class ASAPHttpClinetManager: NSObject {

    static let sharedInstance = ASAPHttpClinetManager()

    func getTokenForDevice(_ deviceId: String, parameters: [String : Any], success:@escaping (_ result: JSON) -> Void, failure:@escaping (_ error: Error) -> Void) {
                
        Alamofire.request(APIConstants.GET_TOKEN, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: ["Content-Type": "application/json", "Accept": "application/json"]).responseJSON { (response: DataResponse<Any>) in
            
            switch response.result {
                            case .success(let data):
                                let swiftyJsonVar = JSON(data)
                                success(swiftyJsonVar)
                
                            case .failure(let error):
                                failure(error)
                            }
        }
        
    }
    
    func authenticateUser(_ parameters: [String : Any], success:@escaping (_ result: JSON) -> Void, failure:@escaping (_ error: Error) -> Void) {
        
        Alamofire.request(APIConstants.AUTHENTICATE_USER, method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type": "application/json", "Accept": "application/json"]).responseJSON { (response: DataResponse<Any>) in
            switch response.result {
            case .success(let data):
                let swiftyJsonVar = JSON(data)
                success(swiftyJsonVar)
                
            case .failure(let error):
                failure(error)
            }
        }
        
    }
    
    func registerUser(_ parameters: [String: Any],success:@escaping (_ result: JSON) -> Void, failure:@escaping (_ error: Error) -> Void) {
        
        Alamofire.request(APIConstants.REGISTER_USER, method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type": "application/json", "Accept": "application/json"]).responseJSON { (response: DataResponse<Any>) in
                            switch response.result {
                            case .success(let data):
                                let swiftyJsonVar = JSON(data)
                                success(swiftyJsonVar)
                                
                            case .failure(let error):
                                failure(error)
                            }
        }
    }

    func verifyOTP(_ parameters: [String: Any], success:@escaping (_ result: JSON) -> Void, failure:@escaping (_ error: Error) -> Void) {
        
        Alamofire.request(APIConstants.VERIFY_OTP, method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type": "application/json", "Accept": "application/json"]).responseJSON { (response: DataResponse<Any>) in
                            switch response.result {
                            case .success(let data):
                                let swiftyJsonVar = JSON(data)
                                success(swiftyJsonVar)
                                
                            case .failure(let error):
                                failure(error)
                            }
        }

    }
    
    
    func resendOTP(_ parameters: [String: Any], success:@escaping (_ result: JSON) -> Void, failure:@escaping (_ error: Error) -> Void) {
        
        Alamofire.request(APIConstants.RESEND_OTP, method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type": "application/json", "Accept": "application/json"]).responseJSON { (response: DataResponse<Any>) in
                            switch response.result {
                            case .success(let data):
                                let swiftyJsonVar = JSON(data)
                                success(swiftyJsonVar)
                                
                            case .failure(let error):
                                failure(error)
                            }
        }
        
    }

    func getMenusWithBanners(_ parameters: [String: Any], success: @escaping (_ result: JSON) -> Void, failure: @escaping (_ error: Error) -> Void) {
        
        Alamofire.request(APIConstants.HOME_GET_MENUS_WITH_BANNERS, method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type": "application/json", "Accept": "application/json"]).responseJSON { (response: DataResponse<Any>) in
                            switch response.result {
                            case .success(let data):
                                let swiftyJsonVar = JSON(data)
                                success(swiftyJsonVar)
                                
                            case .failure(let error):
                                failure(error)
                            }
        }
        
    }
    
    func getLocationsWithBanners(_ parameters: [String: Any], success: @escaping (_ result: JSON) -> Void, failure: @escaping (_ error: Error) -> Void) {
        
        Alamofire.request(APIConstants.HOME_GET_LOCATIONS_WITH_BANNERS, method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type": "application/json", "Accept": "application/json"]).responseJSON { (response: DataResponse<Any>) in
                            switch response.result {
                            case .success(let data):
                                let swiftyJsonVar = JSON(data)
                                success(swiftyJsonVar)
                                
                            case .failure(let error):
                                failure(error)
                            }
        }
        
    }
    

    func getTelecomServiceProviders(_ parameters: [String: Any], success: @escaping (_ result: JSON) -> Void, failure: @escaping (_ error: Error) -> Void) {
        
        Alamofire.request(APIConstants.TELECOM_GET_SERVICE_PROVIDERS, method: .get,
                          parameters: nil,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type": "application/json", "Accept": "application/json"]).responseJSON { (response: DataResponse<Any>) in
                            switch response.result {
                            case .success(let data):
                                let swiftyJsonVar = JSON(data)
                                success(swiftyJsonVar)
                                
                            case .failure(let error):
                                failure(error)
                            }
        }
        
    }
    
    func getCompanies(_ parameters: [String: Any], success: @escaping (_ result: JSON) -> Void, failure: @escaping (_ error: Error) -> Void) {
        
        Alamofire.request(APIConstants.TELECOM_GET_COMPANIES, method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type": "application/json", "Accept": "application/json"]).responseJSON { (response: DataResponse<Any>) in
                            switch response.result {
                            case .success(let data):
                                let swiftyJsonVar = JSON(data)
                                success(swiftyJsonVar)
                                
                            case .failure(let error):
                                failure(error)
                            }
        }
        
    }
    
    func getServiceProvidersPlans(_ parameters: [String: Any], success: @escaping (_ result: JSON) -> Void, failure: @escaping (_ error: Error) -> Void) {
        
        Alamofire.request(APIConstants.TELECOM_GET_PLANS, method: .post,
                          parameters: parameters,
                          encoding: JSONEncoding.default,
                          headers: ["Content-Type": "application/json", "Accept": "application/json"]).responseJSON { (response: DataResponse<Any>) in
                            switch response.result {
                            case .success(let data):
                                let swiftyJsonVar = JSON(data)
                                success(swiftyJsonVar)
                                
                            case .failure(let error):
                                failure(error)
                            }
        }
        
    }
    
}
