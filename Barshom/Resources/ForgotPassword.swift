//
//  ForgotPassword.swift
//  TTMarket
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import Foundation

extension Resources {
    
    struct ForgotPassword {
        
        
       
        static var forgetpassword: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نسيت كلمة المرور"
                case false:
                    return "Forgot Password"
                }
            }
        }
        static var activate: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تأكيد البريد الإلكتروني"
                case false:
                    return "Confirm your email"
                }
            }
        }
        static var alreadyRegistered: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رقم الجوال مسجل من قبل ، سوف يتم تسجيل دخولك الآن"
                case false:
                    return "You have registered before , we will log you in"
                }
            }
        }
        static var activateProfile: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تأكيد تعديل الحساب"
                case false:
                    return "Verification for updating profile"
                }
            }
        }
        
        static var entermobiletoreset : String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أدخل بريدك الإلكتروني لإعادة تعيين كلمة المرور"
                case false:
                    return "Enter your email to reset your password"
                }
            }
        }
        static var entermobiletoactivate :String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يرجى إدخال كود التفعيل"
                case false:
                    return "Kindly enter the verifiction code"
                }
            }
        }
        static var send: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إرسال"
                case false:
                    return "Send"
                }
            }
        }
        static var next: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "التالي"
                case false:
                    return "Next"
                }
            }
        }
        static var resendCode: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إعادة ارسال كود التفعيل"
                case false:
                    return "Resend activation code"
                }
            }
        }
        static var resendCodeSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم ارسال كود التفعيل"
                case false:
                    return "Activation code has been sent"
                }
            }
        }
        static var activationCode: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كود التفعيل"
                case false:
                    return "Activation code"
                }
            }
        }
        static var notreceivecode: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لم يصلك كود التفعيل ؟"
                case false:
                    return "didn't receive code ?"
                }
            }
        }
        static var codeRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كود التفعيل هو حقل مطلوب"
                case false:
                    return "Verification code is a required field"
                }
            }
        }
        static var codeNotValid: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كود التفعيل غير صحيح"
                case false:
                    return "Verification code is not valid"
                }
            }
        }
    }
    
    
}

