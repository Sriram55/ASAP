//
//  APIConstants.swift
//  ASAP
//
//  Created by Sriram Velaga on 21/02/17.
//  Copyright © 2017 ASAP. All rights reserved.
//

import Foundation

class APIConstants {
    
    
    static let GET_TOKEN = ASAP_BASE_URL + "getToken"
    static let AUTHENTICATE_USER = ASAP_BASE_URL + "doLogin"
    static let REGISTER_USER = ASAP_BASE_URL + "doRegister"
    static let VERIFY_OTP = ASAP_BASE_URL + "doVerifyOtp"
    static let RESEND_OTP = ASAP_BASE_URL + "resendOtp"
    static let HOME_GET_MENUS_WITH_BANNERS = ASAP_BASE_URL + "getMenusWithBanners"
    static let HOME_GET_LOCATIONS_WITH_BANNERS = ASAP_BASE_URL + "getLocationsWithBanners"
    static let TELECOM_GET_SERVICE_PROVIDERS = ASAP_BASE_URL + "getServiceProviders"
    static let TELECOM_GET_COMPANIES = ASAP_BASE_URL + "getCompanies"
    static let TELECOM_GET_PLANS = ASAP_BASE_URL + "getPlans"
    static let TELECOM_GET_POSTPAID_NUMBERS = ASAP_BASE_URL + "getPostpaidNumbers"

    #if DEVELOPMENT
    
    static let ASAP_BASE_URL = "http://dev.goasap.co.in/"
    
    #elseif STAGING
    
    static let ASAP_BASE_URL = "http://dev.goasap.co.in/"
    
    #elseif PRODUCTION
    
    static let ASAP_BASE_URL = "http://dev.goasap.co.in/"
    
    #else
    
    static let ASAP_BASE_URL = "http://dev.goasap.co.in/"
    
    #endif
    
}
