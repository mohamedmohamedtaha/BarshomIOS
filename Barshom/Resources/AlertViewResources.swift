//
//  AlertViewResources.swift
//  NBSFramework
//
//  Created by Yo7ia on 11/12/18.
//

import Foundation

public extension Resources {
    
    public struct AlertView {
        public static var note: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "ملاحظة"
                case false:
                    return "Note"
                }
            }
        }
        
        public static var warning: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تنبيه"
                case false:
                    return "Warning"
                }
            }
        }
        
        public static var error: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "خطأ"
                case false:
                    return "Error"
                }
            }
        }
        public static var success: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم بنجاح"
                case false:
                    return "Success"
                }
            }
        }
    }
}
