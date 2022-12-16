//
//  UserDefaultsManager.swift
//  Nepros
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import Foundation
import UIKit

public class UserDefaultsManager {
    private static let APPLE_LANGUAGE_KEY = "AppleLanguages"
    public static let SELECTED_CURRENCY = "Currency"
    private static let MsgKey = "MsgKey"
    private static let AdsKey = "AdsKey"
    private static let BillsKey = "BillsKey"

    class func setDefaults() {
        let defaultPrefsFile: String! = Bundle.main.path(forResource: "defaultPrefs", ofType: "plist") ?? ""
        let defaultPreferences: [String: AnyObject] = NSDictionary(contentsOfFile: defaultPrefsFile) as! [String: AnyObject]
        let defaults: UserDefaults = UserDefaults.standard

        defaults.register(defaults: defaultPreferences)
        defaults.set(["en"], forKey: APPLE_LANGUAGE_KEY)
//        defaults.set(["USD"], forKey: SELECTED_CURRENCY)
        defaults.synchronize()
    }
    
    public static func getUserPreference(_ key: String!) -> AnyObject {
        let defaults: UserDefaults = UserDefaults.standard
        return defaults.value(forKey: key) as AnyObject
        
    }
    
    public static func setUserPreference(_ value: AnyObject, key: String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    public static func getCurrencyPreference(_ key: String!) -> String? {
        let defaults: UserDefaults = UserDefaults.standard
        if let currencyString = defaults.value(forKey: key) as? String
        {
            return currencyString
        }
        if let currencyArray = defaults.value(forKey: key) as? [String]
        {
            return currencyArray[0]
        }
        
        return defaults.value(forKey: key) as? String
        
    }
    public static func getMsgsCount() -> Int {
        let defaults: UserDefaults = UserDefaults.standard
        if let currencyString = defaults.value(forKey: MsgKey) as? Int
        {
            return currencyString
        }
        return 0
    }
    public static func getAdsCount() -> Int {
        let defaults: UserDefaults = UserDefaults.standard
        if let currencyString = defaults.value(forKey: AdsKey) as? Int
        {
            return currencyString
        }
        return 0
    }
    public static func getBillsCount() -> Int {
        let defaults: UserDefaults = UserDefaults.standard
        if let currencyString = defaults.value(forKey: BillsKey) as? Int
        {
            return currencyString
        }
        return 0
    }
    
    public static func incrementBillsCount(clear: Bool? = false) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(!clear!  ? getBillsCount()+1 : 0, forKey: BillsKey)
        defaults.synchronize()
    }
    public static func incrementAdsCount(clear: Bool? = false) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(!clear!  ? getAdsCount()+1 : 0 , forKey: AdsKey)
        defaults.synchronize()
    }
    public static func incrementMsgCount(clear: Bool? = false) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(!clear! ? getMsgsCount()+1 : 0 , forKey: MsgKey)
        defaults.synchronize()
    }
    public static func setCurrencyPreference(_ value: String, key: String) {
        let defaults: UserDefaults = UserDefaults.standard
        defaults.set(value, forKey: key)
        defaults.synchronize()
    }
    
    public static func resetAppData() {
        
        let defaults: UserDefaults = UserDefaults.standard
        defaults.removePersistentDomain(forName: Bundle.main.bundleIdentifier!)
        defaults.synchronize()
    }
    
}
