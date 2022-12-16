//
//  WebServiceMananger.swift
//  NBSFramework
//
//  Created by Yo7ia on 11/12/18.
//

import Foundation

public extension Resources {
    
    public struct WebServiceMananger {
        public static var noInternetConnection: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لا يوجد اتصال بالانترنت"
                case false:
                    return "There is no internet connection!"
                }
            }
        }
        
        public static var loginRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عذرًا على الإزعاج، يجب تسجيل الخروج ومن ثم تسجيل الدخول مجددا"
                case false:
                    return "Sorry for interrupting, please logout then login again."
                }
            }
        }
        
        public static var connectionFailed: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "فشل الاتصال"
                case false:
                    return "Faild to connect."
                }
            }
        }
        
        public static var tokenFailed: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تعذّر جلب التوكين الخاص بالمستحدم"
                case false:
                    return "Could not fetch user's token."
                }
            }
        }
        
        public static var corruptedResponse: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لم يتم التعرّف على الرد القادم السيرفر."
                case false:
                    return "Server's response was not recognized."
                }
            }
        }
        
        public static var reviewErrors: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "فشل الطلب، يرجى مراجعة الأخطاء التالية: "
                case false:
                    return "Request failed, please review the following errors:"
                }
            }
        }
    }
}
