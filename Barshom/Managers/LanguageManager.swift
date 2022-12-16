//
//  Languages.swift
//  Washer-Client
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2017 WaslTec. All rights reserved.
//

import Foundation
import UIKit
public enum Language: Int {
    case ar = 0
    case en = 1
}

public class LanguageManager {

    private static let CurrentLanguageKey = "CurrentLanguageKey"
    private static let APPLE_LANGUAGE_KEY = "AppleLanguages"

    public static var currentLanguage: Language {
        get {
            guard let rawValue = UserDefaultsManager.getUserPreference(CurrentLanguageKey) as? Int else {
                return AppHelper.appDelegate.defaultLanguage
            }
            return Language(rawValue: rawValue) ?? AppHelper.appDelegate.defaultLanguage
        }
        set {
            UserDefaultsManager.setUserPreference(newValue.rawValue as AnyObject, key: CurrentLanguageKey)
            let userdef = UserDefaults.standard
            userdef.set([newValue.rawValue == 0 ? "ar" : "en" ], forKey: APPLE_LANGUAGE_KEY)
            if newValue.rawValue == 0{
                UIView.appearance().semanticContentAttribute = .forceRightToLeft
            }else {
                UIView.appearance().semanticContentAttribute = .forceLeftToRight
            }
            userdef.synchronize()

        }
    }
    
    public static var isArabic: Bool {
        get {
            return LanguageManager.currentLanguage == .ar
        }
    }
}


