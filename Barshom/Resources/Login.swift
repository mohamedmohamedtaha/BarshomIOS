//
//  LoginControllerResources.swift
//  TTMarket
//
//  Created by Yo7ia on 11/12/18.
//  Copyright © 2018 RMG. All rights reserved.
//

import Foundation


extension Resources{
    
    struct Login {
        
        static var login: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تسجيل دخول"
                case false:
                    return "Login"
                }
            }
        }
        
        static var confirmPassword: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تأكيد كلمة المرور "
                case false:
                    return "Confirm Password "
                }
            }
        }
        static var newpassword: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كلمة المرور الجديدة "
                case false:
                    return "New Password"
                }
            }
        }
        static var confNewPassword: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تأكيد كلمة المرور الجديدة "
                case false:
                    return "Confirm New Password"
                }
            }
        }
        
        static var useraddress: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "العنوان"
                case false:
                    return "Address"
                }
            }
        }
        static var industry: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الصناعة"
                case false:
                    return "Industry"
                }
            }
        }
        static var establishDate: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سنة التأسيس"
                case false:
                    return "Established date"
                }
            }
        }
        static var uploadIdentityImg: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إرفاق صور سجلات الشركة"
                case false:
                    return "Attach Company Commercial's Images"
                }
            }
        }
        static var uploadPaymentImg: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إرفاق سند الدفع"
                case false:
                    return "Attach payment's receipt"
                }
            }
        }
        static var paymentReceived: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم إرسال سند الدفع ، سيتم التأكد منه في أسرع وقت"
                case false:
                    return "Payment's receipt has been sent , it will be reviewed as soon as possible"
                }
            }
        }
        
        static var uploadAuthorizationImg: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إرفاق خطاب التفويض"
                case false:
                    return "Attach authorization letter"
                }
            }
        }
        static var contactRepresentative: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مسئول الإتصال"
                case false:
                    return "Contact Representative"
                }
            }
        }
        static var birthdate: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تاريخ الميلاد"
                case false:
                    return "Birthdate"
                }
            }
        }
        static var city: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "المدينة"
                case false:
                    return "City"
                }
            }
        }
       
        static var licenseImg: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "اثبات المهنة او بطاقة عمل"
                case false:
                    return "Proof of profession or business card"
                }
            }
        }
        
        static var country: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "البلد"
                case false:
                    return "Country"
                }
            }
        }
        static var choosecity: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إختر مدينة"
                case false:
                    return "Choose city"
                }
            }
        }
        static var choosecountry: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إختر البلد"
                case false:
                    return "Choose country"
                }
            }
        }
        static var region: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الحي"
                case false:
                    return "Region"
                }
            }
        }
        static var street: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الشارع"
                case false:
                    return "Street"
                }
            }
        }
        static var contactDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "معلومات التواصل"
                case false:
                    return "Contact details"
                }
            }
        }
        static var marketerDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "معلومات المسوق"
                case false:
                    return "Marketer details"
                }
            }
        }
        static var whatsapp: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "واتساب"
                case false:
                    return "Whatsapp"
                }
            }
        }
        static var facebook: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "فيسبوك"
                case false:
                    return "Facebook"
                }
            }
        }
        
        static var hasMarketers: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "هل يوجد مسوق؟"
                case false:
                    return "Have marketers ?"
                }
            }
        }
        
        static var marketerName: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إسم المسوق"
                case false:
                    return "Marketer name"
                }
            }
        }
        static var marketerPhone: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رقم جوال المسوق"
                case false:
                    return "Marketer mobile number"
                }
            }
        }
        
        
        
        
        
        static var activationCode: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رمز التفعيل "
                case false:
                    return "Activation code"
                }
            }
        }
        static var withDrawRequest: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "طلب سحب الرصيد"
                case false:
                    return "Withdraw request"
                }
            }
        }
        static var enterAmount: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أدخل الكمية"
                case false:
                    return "Enter amount"
                }
            }
        }
        static var activate: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تفعيل الحساب"
                case false:
                    return "Activate your account"
                }
            }
        }
        
        static var password: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كلمة المرور "
                case false:
                    return "Password"
                }
            }
        }
        static var forgetpassword: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نسيت كلمة المرور ؟"
                case false:
                    return "Forgot password ?"
                }
            }
        }
        static var clickhere: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إضغط هنا"
                case false:
                    return "Click here"
                }
            }
        }
        static var loginLater: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "التسجيل لاحقاً"
                case false:
                    return "Register later"
                }
            }
        }
        static var or: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أو"
                case false:
                    return "or"
                }
            }
        }

        static var newuser: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تسجيل حساب جديد"
                case false:
                    return "Register new user"
                }
            }
        }
        static var newcompany: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تسجيل حساب شركة"
                case false:
                    return "Register new company"
                }
            }
        }
        static var mobileRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رقم الجوال هو حقل مطلوب"
                case false:
                    return "Mobile Number is a required field"
                }
            }
        }
        static var reservationTime: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "موعد الحجز"
                case false:
                    return "Reservation time"
                }
            }
        }
        static var reserveDate: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تاريخ الحجز"
                case false:
                    return "Reservation date"
                }
            }
        }
        static var orderType: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نوع الطلب"
                case false:
                    return "Order type"
                }
            }
        }
        static var caseType: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نوع القضية"
                case false:
                    return "Case type"
                }
            }
        }
        static var orderTitle: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عنوان الطلب"
                case false:
                    return "Order title"
                }
            }
        }
        static var orderDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تفاصيل الطلب"
                case false:
                    return "Order details"
                }
            }
        }
        static var orderSubmit: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "قدم الطلب"
                case false:
                    return "Submit order"
                }
            }
        }
        static var reserveADate: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "حجز موعد "
                case false:
                    return "Reserve a date"
                }
            }
        }
        static var confirmreserveADate: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تأكيد حجز موعد "
                case false:
                    return "Confirm Reserving a date"
                }
            }
        }
        static var patientDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "بيانات المريض"
                case false:
                    return "Patient's info"
                }
            }
        }
        static var passwordRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كلمة المرور هو حقل مطلوب"
                case false:
                    return "Password is a required field"
                }
            }
        }
        static var passwordChangedSuccessfuly: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم تغيير كلمة المرور بنجاح"
                case false:
                    return "Password has been changed successfuly"
                }
            }
        }
        static var newpasswordRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كلمة المرور الجديدة هو حقل مطلوب"
                case false:
                    return "New Password is a required field"
                }
            }
        }
        static var newconfpasswordRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تأكيد كلمة المرور الجديدة هو حقل مطلوب"
                case false:
                    return "Confirm New Password is a required field"
                }
            }
        }
        static var nameRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الإسم هو حقل مطلوب"
                case false:
                    return "Name is a required field"
                }
            }
        }
        static var familyNameRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إسم الأسرة هو حقل مطلوب"
                case false:
                    return "Family name is a required field"
                }
            }
        }
        static var familyImageRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "صورة الأسرة هو حقل مطلوب"
                case false:
                    return "Family logo is a required field"
                }
            }
        }
        static var familyAddressRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "العنوان هو حقل مطلوب"
                case false:
                    return "Address is a required field"
                }
            }
        }
        static var storeTypeRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نوع المتجر مطلوب"
                case false:
                    return "Store type is a required field"
                }
            }
        }
        
        static var prodNameRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إسم الوجبة هو حقل مطلوب"
                case false:
                    return "Meal name is a required field"
                }
            }
        }
        static var additionNameRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إسم الإضافة هو حقل مطلوب"
                case false:
                    return "Addition title is a required field"
                }
            }
        }
        static var prodImageRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "صورة الوجبة هو حقل مطلوب"
                case false:
                    return "Meal image is a required field"
                }
            }
        }
        static var prodDescRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "وصف الوجبة هو حقل مطلوب"
                case false:
                    return "Meal description is a required field"
                }
            }
        }
        static var prodCatRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "صنف الوجبة هو حقل مطلوب"
                case false:
                    return "Meal category is a required field"
                }
            }
        }
        static var familyCatRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تصنيف الأسرة هو حقل مطلوب"
                case false:
                    return "Family category is a required field"
                }
            }
        }
        static var prodDistanceRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "المسافة هو حقل مطلوب"
                case false:
                    return "Distance is a required field"
                }
            }
        }
        static var prodTimeRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الوقت المتوقع هو حقل مطلوب"
                case false:
                    return "Expected time is a required field"
                }
            }
        }
        static var additionCaloriesRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "السعر الحرارية للإضافة هو حقل مطلوب"
                case false:
                    return "Addition calories is a required field"
                }
            }
        }
        static var additionPriceRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سعر الإضافة هو حقل مطلوب"
                case false:
                    return "Addition price is a required field"
                }
            }
        }
        static var prodCaloriesRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "السعر الحرارية هو حقل مطلوب"
                case false:
                    return "Calories is a required field"
                }
            }
        }
        static var prodPriceRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سعر الوجبة هو حقل مطلوب"
                case false:
                    return "Meal price is a required field"
                }
            }
        }
        static var bankNameRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إسم البنك هو حقل مطلوب"
                case false:
                    return "Bank name is a required field"
                }
            }
        }
        static var bankIpanRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الايبان هو حقل مطلوب"
                case false:
                    return "IBAN is a required field"
                }
            }
        }
        static var offerNameRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إسم العرض هو حقل مطلوب"
                case false:
                    return "Offer name is a required field"
                }
            }
        }
        static var offerImageRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "صورة العرض هو حقل مطلوب"
                case false:
                    return "Offer image is a required field"
                }
            }
        }
        static var offerPeriodRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مدة العرض هو حقل مطلوب"
                case false:
                    return "Offer period is a required field"
                }
            }
        }
        static var confirmpasswordRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تأكيد كلمة المرور هو حقل مطلوب"
                case false:
                    return "Confirm Password is a required field"
                }
            }
        }
        static var passwordMismatchRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كلمة المرور و تأكيد كلمة المرور غير متطابقين"
                case false:
                    return "Password and confirm password mismatch"
                }
            }
        }
        static var accepttermsRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يرجى الموافقة على الشروط و الأحكام للمتابعة"
                case false:
                    return "Kindly accept terms and conditions to continue"
                }
            }
        }
        static var emailRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "البريد الإلكتروني/رقم الجوال هو حقل مطلوب"
                case false:
                    return "E-mail/Mobile is a required field"
                }
            }
        }
        static var emailOnlyRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "البريد الإلكتروني هو حقل مطلوب"
                case false:
                    return "E-mail is a required field"
                }
            }
        }
        static var invalidEmail: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يرجى إدخال بريد إلكتروني صحيح"
                case false:
                    return "Kindly enter a valid email"
                }
            }
        }
        
        static var userImageRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يجب إضافة صورة"
                case false:
                    return "You have to add an image"
                }
            }
        }
        static var loginRequired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يرجى تسجيل الدخول للمتابعة"
                case false:
                    return "To continue please login "
                }
            }
        }
        static var congratulations: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مبروك !"
                case false:
                    return "Congratulations !"
                }
            }
        }
        static var registrationSuccessonly: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم التسجيل حساب بنجاح"
                case false:
                    return "Your account has been registered successfuly"
                }
            }
        }
        static var deleteReservationsuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم إلغاء الطلب بنجاح"
                case false:
                    return "Order has been cancelled successfuly"
                }
            }
        }
        static var confirmReservationsuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم تأكيد الطلب بنجاح"
                case false:
                    return "Order has been confirmed successfuly"
                }
            }
        }
        static var deleteNotificationsuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم حذف الإشعار بنجاح"
                case false:
                    return "Notification has been deleted successfuly"
                }
            }
        }
        static var editReservationsuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم تعديل الحجز بنجاح"
                case false:
                    return "Your reservation has been updated successfuly"
                }
            }
        }
        static var registrationSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم التسجيل بنجاح ، يرجى إدخال رمز التفعيل للإستمرار"
                case false:
                    return "Registration success , kindly enter activation code to continue"
                }
            }
        }
        static var loginSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يرجى إدخال رمز التفعيل للإستمرار"
                case false:
                    return "Kindly enter activation code to continue"
                }
            }
        }
        static var activationSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم تفعيل حسابك بنجاح"
                case false:
                    return "Your account have been activated successfuly"
                }
            }
        }
        static var codeSentSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم إرسال رمز التفعيل الجديد "
                case false:
                    return "Activation code has been sent"
                }
            }
        }
        static var invalidCode: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رمز التفعيل غير صحيح"
                case false:
                    return "Activation code not valid"
                }
            }
        }
        static var newPasswordSet: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم تغيير كلمة المرور "
                case false:
                    return "Password has been changed"
                }
            }
        }
        static var rateSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم إرسال التقييم بنجاح "
                case false:
                    return "Your rate has been sent successfuly"
                }
            }
        }
        static var enterNewPassword: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أدخل كلمة المرور الجديدة"
                case false:
                    return "Enter new password"
                }
            }
        }
        
        static var newPasswordNotSet: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يرجى التحقق من رمز التحقق"
                case false:
                    return "Please verfiy the activation code"
                }
            }
        }
    }
    
    
}
