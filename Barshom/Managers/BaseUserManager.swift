//
//  UserInfoManager.swift
//  Nepros
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import UIKit

open class BaseUserManager {
    
    private static let UserDataKey = "UserDataKey"
    private static let UserPassKey = "UserPassKey"
    private static let UserCityKey = "UserCityKey"

    
    public static func saveUserInfo(user: [String: Any]) {
        self.userData = user
    }
    public static func saveUserCity(user: [String: Any]) {
        self.userCity = user
    }
    public static func saveUserPass(user: [String: Any]) {
        self.userPass = user
    }
    
    public static var userData: [String: Any]? {
        get {
            if let x = UserDefaultsManager.getUserPreference(UserDataKey) as? Data
            {
                let dict = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(x)as! [String: Any]
                
                return  dict
            }
            return nil
        }
        set {
            guard let value = newValue else { return }
            let data = try! NSKeyedArchiver.archivedData(withRootObject: value,requiringSecureCoding: false)
            UserDefaultsManager.setUserPreference(data as AnyObject , key: UserDataKey)
        }
    }
    
    public static var userCity: [String: Any]? {
        get {
            if let x = UserDefaultsManager.getUserPreference(UserCityKey) as? Data
            {
                let dict = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(x)as! [String: Any]
                
                return  dict
            }
            return nil
        }
        set {
            guard let value = newValue else { return }
            let data = try! NSKeyedArchiver.archivedData(withRootObject: value,requiringSecureCoding: false)
            UserDefaultsManager.setUserPreference(data as AnyObject , key: UserCityKey)
        }
    }
    
    public static var userPass: [String: Any]? {
        get {
            if let x = UserDefaultsManager.getUserPreference(UserPassKey) as? Data
            {
                let dict = try! NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(x)as! [String: Any]
                return  dict
            }
            return nil
        }
        set {
            guard let value = newValue else { return }
            let data = try! NSKeyedArchiver.archivedData(withRootObject: value,requiringSecureCoding: false)
            UserDefaultsManager.setUserPreference(data as AnyObject , key: UserPassKey)
        }
    }
    public static var currentCurrency: String? {
        get {
            var currency :String = "SAR"
            if let x = UserDefaultsManager.getCurrencyPreference(UserDefaultsManager.SELECTED_CURRENCY)
            {
                currency = x
            }
            return currency
        }
        set {
            guard let value = newValue else { return }
            
            UserDefaultsManager.setCurrencyPreference(value , key: UserDefaultsManager.SELECTED_CURRENCY)
        }
    }
    
    public static var msgCount: Int {
        get {
            return UserDefaultsManager.getMsgsCount()
        }
        set {
            UserDefaultsManager.incrementMsgCount(clear: newValue == 0 )
        }
    }
    public static var adsCount: Int {
        get {
            return UserDefaultsManager.getAdsCount()
        }
        set {
            UserDefaultsManager.incrementAdsCount(clear: newValue == 0 )
        }
    }
    public static var billsCount: Int {
        get {
            return UserDefaultsManager.getBillsCount()
        }
        set {
            UserDefaultsManager.incrementBillsCount(clear: newValue == 0 )
        }
    }
    public static var isLoggedIn: Bool {
        get {
            return userData != nil
        }
    }
    
    public static func logout()
    {
        let currency = currentCurrency!
        let isArabic = LanguageManager.isArabic
        UserDefaultsManager.resetAppData()
        LanguageManager.currentLanguage = isArabic ? .ar : .en
        currentCurrency = currency
    }
}
