//
//  WebServiceMananger.swift
//  Nepros
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import Foundation
import Alamofire

public class WebServiceMananger {

    // MARK: - Get Access Token
   
    
    // MARK: - Upload
    public static func upload(
        method: Alamofire.HTTPMethod,
        urlString : String,
        parameters: [String: Any]? = nil,
        headers: [String:String]? = nil,
        attachments: [Attachment],
        showProgress: Bool? = true,
        completion : @escaping (_ data: AnyObject, _ status: Bool) -> ()) -> Void
    {
        if showProgress!
               {
                   Indicator.sharedInstance.show()
               }
        if !Reachability.isConnectedToNetwork() {
            Indicator.sharedInstance.dismiss()
            AppHelper.showWarningAlert(message: Resources.WebServiceMananger.noInternetConnection)
            return
        }
        
        var heads: [String : String] = headers ?? [:]
        heads["Content-Type"] = "multipart/form-data"
        if UserManager.isLoggedIn
        {
//            heads.updateValue(UserManager.isLoggedIn ? "Token " + UserManager.getUserData!.token : "", forKey: "Authorization")
//            heads.updateValue(UserManager.isLoggedIn ? "token " + UserManager.getUserData!. : "", forKey: "Authorization")
        }
        
        var pars = parameters == nil ? [:] : parameters!
        pars.updateValue(Constants.accessPassword, forKey: "access_password")
        pars.updateValue(Constants.accessKey, forKey: "access_key")
//        pars.updateValue(LanguageManager.isArabic ? "ar":"en", forKey: "lang")
        if urlString != Constants.APIProvider.getTerms  && urlString != Constants.APIProvider.getAbout
        {
            pars.updateValue(LanguageManager.isArabic ? "ar":"en", forKey: "lang")
        }
        
        AlamofireHelper.uploadRequest(
            method: method,
            urlString: urlString,
            parameters: pars,
            headers: heads,
            attachments: attachments,
            completion: completion)
    }
    
    
    // MARK: - Make Call
    public static func makeCall(method: Alamofire.HTTPMethod,
                         urlString : String,
                         parameters: [String: Any]? = nil,
                         headers: [String:String]? = nil,
                         completion : @escaping (_ data: AnyObject, _ status: Bool) -> ()) -> Void
    {

        Indicator.sharedInstance.show()
        
        if !Reachability.isConnectedToNetwork() {
            Indicator.sharedInstance.dismiss()
            AppHelper.showWarningAlert(message: Resources.WebServiceMananger.noInternetConnection)
            return
        }
        
        var heads: [String : String] = headers ?? [:]
        heads["Content-Type"] = "multipart/form-data"
        if UserManager.isLoggedIn
        {
//            heads.updateValue(UserManager.isLoggedIn ? "Token " + UserManager.getUserData!.token : "", forKey: "Authorization")
//            heads.updateValue(UserManager.isLoggedIn ? "token " + UserManager.getUserData!.token : "", forKey: "Authorization")
        }
        
        var pars = parameters == nil ? [:] : parameters!
        pars.updateValue(Constants.accessPassword, forKey: "access_password")
        pars.updateValue(Constants.accessKey, forKey: "access_key")
//        pars.updateValue(LanguageManager.isArabic ? "ar":"en", forKey: "app_lang")
        pars.updateValue(LanguageManager.isArabic ? "ar":"en", forKey: "lang")

        AlamofireHelper.uploadRequest(
            method: method,
            urlString: urlString,
            parameters: pars,
            headers: heads,
            attachments: [],
            completion: completion)
}
    
    
    // MARK: - Make Call
    public static func makeCallJSON(method: HTTPMethod,
                                urlString : String,
                                parameters: [String: Any]? = nil,
                                headers: [String:String]? = nil,
                                showProgress: Bool? = true,
                                completion : @escaping (_ data: AnyObject, _ status: Bool) -> ()) -> Void
    {
        
        if showProgress!
        {
            Indicator.sharedInstance.show()
        }
        if !Reachability.isConnectedToNetwork() {
            Indicator.sharedInstance.dismiss()
            AppHelper.showWarningAlert(message: Resources.WebServiceMananger.noInternetConnection)
            return
        }
        
        var heads: [String : String] = headers ?? [:]
        if UserManager.isLoggedIn
        {
//            heads.updateValue(UserManager.isLoggedIn ? "Token " + UserManager.getUserData!.token : "", forKey: "Authorization")
//            heads.updateValue(UserManager.isLoggedIn ? "token " + UserManager.getUserData!.token : "", forKey: "Authorization")

        }
        if LanguageManager.isArabic
        {
            heads.updateValue("ar-eg", forKey: "Accept-Language")
        }
//        if urlString == Constants.APIProvider.Users.login
//        {
//        heads.updateValue("application/json", forKey: "Content-Type")
//        heads.updateValue("application/json", forKey: "content-type")
//        }
        var pars = parameters == nil ? [:] : parameters!
        pars.updateValue(Constants.accessPassword, forKey: "access_password")
        pars.updateValue(Constants.accessKey, forKey: "access_key")
//        pars.updateValue(LanguageManager.isArabic ? "ar":"en", forKey: "app_lang")
//
        pars.updateValue(LanguageManager.isArabic ? "ar":"en", forKey: "lang")

        AlamofireHelper.makeCallRequest(
            method: method,
            urlString: urlString,
            parameters: pars,
            headers: heads,
            completion: completion)
    }
    
    // MARK: - Make Call
    public static func makeCallJSONCreate(method: HTTPMethod,
                                    urlString : String,
                                    parameters: [String: Any]? = nil,
                                    headers: [String:String]? = nil,
                                    showProgress: Bool? = true,
                                    completion : @escaping (_ data: AnyObject, _ status: Bool,_ statuscode : Bool) -> ()
                                    ) -> Void
    {
        
        if showProgress!
        {
            Indicator.sharedInstance.show()
        }
        
        if !Reachability.isConnectedToNetwork() {
            Indicator.sharedInstance.dismiss()
            AppHelper.showWarningAlert(message: Resources.WebServiceMananger.noInternetConnection)
            return
        }
        
        var heads: [String : String] = headers ?? [:]
        if UserManager.isLoggedIn
        {
//            heads.updateValue(UserManager.isLoggedIn ? "token " + UserManager.getUserData!.token : "", forKey: "Authorization")
        }
       
        //        heads.updateValue("application/json", forKey: "Content-Type")
        //        heads.updateValue("application/json", forKey: "content-type")
        
        var pars = parameters == nil ? [:] : parameters!
        pars.updateValue(Constants.accessPassword, forKey: "access_password")
        pars.updateValue(Constants.accessKey, forKey: "access_key")
        pars.updateValue(LanguageManager.isArabic ? "ar":"en", forKey: "lang")
        //
        AlamofireHelper.makeCallRequestCreate(
            method: method,
            urlString: urlString,
            parameters: pars,
            headers: heads,
            completion: completion)
    }
    
    // MARK: - Load Data
    public static func loadData(method: HTTPMethod,
                         urlString : String,
                         parameters: [String: Any]? = nil,
                         headers: [String:String]? = nil,
                         completion : @escaping (_ data: AnyObject, _ status: Bool) -> ()) -> Void    {
        Indicator.sharedInstance.show()
        
        if !Reachability.isConnectedToNetwork() {
            Indicator.sharedInstance.dismiss()
            AppHelper.showWarningAlert(message: Resources.WebServiceMananger.noInternetConnection)
            return
        }
        
        var heads: [String : String] = headers ?? [:]
        

        AlamofireHelper.makeCallRequest(method: method, urlString: urlString, parameters: parameters, headers: heads, completion: completion)
}
}

