//
//  Common.swift
//  Al Qarra Medical Complex
//
//  Created by Yo7ia on 12/6/18.
//  Copyright © 2018 Yo7ia. All rights reserved.
//


import Foundation

public extension Resources {
    
    public struct Common {
        
        public static var choose: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "اختيار"
                case false:
                    return "Choose"
                }
            }
        }
        static var receiveOn: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تفعيل"
                case false:
                    return "Enable"
                }
            }
        }
        static var receiveOff: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تعطيل"
                case false:
                    return "Disable"
                }
            }
        }
        static var adNumber: String {
                   get {
                       switch LanguageManager.isArabic {
                       case true:
                           return "إعلان رقم : "
                       case false:
                           return "Ad number : "
                       }
                   }
               }
        public static var sessionExpired: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "انتهت جلستك ، سيتم تسجيل خروجك"
                case false:
                    return "Your session expired, you will be logged out"
                }
            }
        }
        public static var partnership: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "للشراكة"
                case false:
                    return "Partnership"
                }
            }
        }
        public static var hasPaid: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم الدفع"
                case false:
                    return "Paid"
                }
            }
        }
        public static var commision: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عمولة تسويق الكتروني"
                case false:
                    return "e-Marketing commission"
                }
            }
        }
        public static var notPaid: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لم يتم الدفع"
                case false:
                    return "Not Paid"
                }
            }
        }
        public static var funding: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "للتمويل"
                case false:
                    return "For Fund"
                }
            }
        }
        static var closeTicket: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إغلاق التذكرة"
                case false:
                    return "Close ticket"
                }
            }
        }
        static var showAllTickets: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عرض كل رسائل الدعم"
                case false:
                    return "Show all tickets"
                }
            }
        }
        static var ticketSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم إرسال رسالتك ، سيتم الرد عليك من الدعم الفني في أقرب وقت ممكن"
                case false:
                    return "Your message has been sent , the technical support will reply as soon as possible"
                }
            }
        }
        static var ticketClosed: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "شكراً ، تم إغلاق التذكرة"
                case false:
                    return "Thanks , your ticket has been closed"
                }
            }
        }
        static var messageNo: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رسالة رقم : "
                case false:
                    return "Message no. : "
                }
            }
        }
        public static var selling: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "للبيع"
                case false:
                    return "For Sale"
                }
            }
        }
        public static var innovations: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الإبتكارات"
                case false:
                    return "Innovations"
                }
            }
        }
        public static var innovator: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مبتكر / رائد أعمال"
                case false:
                    return "Innovator / Enterpreneur"
                }
            }
        }
        public static var ownerType: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نوع المعلن"
                case false:
                    return "Owner Type"
                }
            }
        }
        public static var companyOrganization: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "شركة / مؤسسة"
                case false:
                    return "Company / Organization"
                }
            }
        }
        public static var challenges: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تحديات العمل"
                case false:
                    return "Business Challenges"
                }
            }
        }
        public static var basic: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "بسيط"
                case false:
                    return "Basic"
                }
            }
        }
        public static var advanced: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "متقدم"
                case false:
                    return "Advanced"
                }
            }
        }
        public static var contactWhatsApp: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تواصل عبر الواتساب"
                case false:
                    return "Connect via Whatsapp"
                }
            }
        }
        public static var noWhatsapp: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الواتساب غير مثبت علي جهازك"
                case false:
                    return "Whatsapp is not installed on your device"
                }
            }
        }
        public static var contactEmail: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تواصل عبر البريد الإلكتروني"
                case false:
                    return "Connect via Email"
                }
            }
        }
        public static var edit: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تعديل"
                case false:
                    return "Edit"
                }
            }
        }
        public static var editProfile: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تعديل البيانات"
                case false:
                    return "Edit Profile"
                }
            }
        }
        public static var delete: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "حذف"
                case false:
                    return "Delete"
                }
            }
        }
        public static var at: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return " في "
                case false:
                    return " at "
                }
            }
        }
        public static var callAgrement: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أقر بأنني أعلم وأوافق على شروط وأحكام استخدام هذا التطبيق، بما في ذلك شروط عدم الإفشاء وحماية الحقوق الفكرية والتجارية لمن أتصل بهم ؛ وأنا أعلم أن جميع الاتصالات النصية والصوتية مسجلة."
                case false:
                    return "I acknowledge that I know and agree to the terms and conditions of using this application, including the terms of non disclosure and the protection of intellectual and commercial rights for those who I contact them; and I know that all text and voice contacting are recorded."
                }
            }
        }
        
        public static var accept: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أوافق"
                case false:
                    return "I Agree"
                }
            }
        }
        
        public static var sarFull: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "ريال سعودي"
                case false:
                    return "Saudi Arabian Riyal"
                }
            }
        }
        public static var sar: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "ريال"
                case false:
                    return "SAR"
                }
            }
        }
        public static var point: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نقطة"
                case false:
                    return "Point"
                }
            }
        }

        public static var sponsored: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "برعاية"
                case false:
                    return "Sponsored"
                }
            }
        }
        public static var extend: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تمديد الباقة"
                case false:
                    return "Extend package"
                }
            }
        }
        public static var upgrade: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "ترقية الباقة"
                case false:
                    return "Upgrade package"
                }
            }
        }
        public static var ok: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم"
                case false:
                    return "Ok"
                }
            }
        }
        public static var deleteAlert: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "هل تريد إلغاء الطلب ؟"
                case false:
                    return "Do you want to cancel the order ?"
                }
            }
        }
        
        static func required(fieldName: String) -> String {
            switch LanguageManager.isArabic {
            case true:
                return "إن \(fieldName) هو حقل مطلوب"
            case false:
                return "\(fieldName) is required"
            }
        }
        static func packageSetter(pckName: String,weeks: String,price: String) -> String {
            switch LanguageManager.isArabic {
            case false:
                return "\(pckName) for \(weeks) day/s with \(price) only"
            case true:
                return "\(pckName) لمدة \(weeks) يوم بسعر \(price) فقط"
            }
        }
        
        static var upload: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رفع صورة"
                case false:
                    return "Upload image"
                }
            }
        }
        
        static var pleaseSelect: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الرجاء الاختيار٫٫٫"
                case false:
                    return "Please select..."
                }
            }
        }
        
        static var cancel: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إلغاء"
                case false:
                    return "Cancel"
                }
            }
        }
        static var close: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إغلاق"
                case false:
                    return "Close"
                }
            }
        }
        
        static var cancelGoBack: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تراجع"
                case false:
                    return "Cancel"
                }
            }
        }
        static var back: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "السابق"
                case false:
                    return "Back"
                }
            }
        }
        
        
        
        static var from: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "من"
                case false:
                    return "from"
                }
            }
        }
        
        static var to: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إلى"
                case false:
                    return "to"
                }
            }
        }
        static var male: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "ذكر"
                case false:
                    return "Male"
                }
            }
        }
        
        static var female: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أنثى"
                case false:
                    return "Female"
                }
            }
        }
        
        static var years: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return " سنة "
                case false:
                    return " Years "
                }
            }
        }
        static var year: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return " السنة "
                case false:
                    return " Year "
                }
            }
        }
        
        static var currentRevenueOfYear : String {
            get {
                switch LanguageManager.isArabic {
                case false:
                    return "Current Revenues"
                case true:
                    return "الإيرادات الحالية"
                }
            }
        }
        static var yearAlreadyExist: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لقد تم إدخال النتائج المالية لهذه السنة من قبل"
                case false:
                    return "Financial result for this year has been entered before"
                }
            }
        }
        static var totalExpenses: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return " إجمالي المصروفات "
                case false:
                    return " Total expenses "
                }
            }
        }
        static var totalRevenues: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return " إجمالي الإيرادات "
                case false:
                    return " Total revenues "
                }
            }
        }
        static var netProfit: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return " صافي الربح "
                case false:
                    return " Net profit "
                }
            }
        }
        static var about: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عن التطبيق"
                case false:
                    return "About App"
                }
            }
        }
        static var slogan: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "فرص الأعمال والابتكارات الدولية"
                case false:
                    return "International Business and Innovation Opportunity"
                }
            }
        }
        
        static var saudiarabia: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الدولي"
                case false:
                    return "International"
                }
            }
        }
        static var confidentialLocation: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عذرا صاحب الاعلان يرغب بالحفاظ على خصوصية الموقع"
                case false:
                    return "Sorry the advertiser wants to maintain the location's privacy"
                }
            }
        }
        static var bio: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نبذة"
                case false:
                    return "Bio"
                }
            }
        }
        static var appliedPrice: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "المبلغ المستحق : "
                case false:
                    return "Amount Due : "
                }
            }
        }
        static var rateNow: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تقييم الأن"
                case false:
                    return "Rate now"
                }
            }
        }
        static var rateApp: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تقييم التطبيق"
                case false:
                    return "Rate app"
                }
            }
        }
        static var shareApp: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مشاركة التطبيق"
                case false:
                    return "Share app"
                }
            }
        }
        static var suggession: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الإقتراحات"
                case false:
                    return "Suggessions"
                }
            }
        }
        static var nearest: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "قريب مني"
                case false:
                    return "Near me"
                }
            }
        }
        static var chatNow: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "راسله الأن"
                case false:
                    return "Chat now"
                }
            }
        }
        static var showConversation: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "شاهد المحادثة"
                case false:
                    return "Show chat"
                }
            }
        }
        static var showBill: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عرض الفاتورة"
                case false:
                    return "Preview your bill"
                }
            }
        }
        static var payNow: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إدفع الأن"
                case false:
                    return "Pay now"
                }
            }
        }
        
        
        
        static var secondStep: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الخطوة الثانية"
                case false:
                    return "2nd step"
                }
            }
        }
        static var finalStep: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إنهاء الحجز"
                case false:
                    return "Finalize reservation"
                }
            }
        }
        static var contactoffice: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مراسلة"
                case false:
                    return "Contact"
                }
            }
        }
        static var car: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سيارات متاحة"
                case false:
                    return "Available cars"
                }
            }
        }
        static var carDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "التفاصيل"
                case false:
                    return "Details"
                }
            }
        }
        static var categoryName: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إسم القسم"
                case false:
                    return "Category name"
                }
            }
        }
        static var productName: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إسم المنتج"
                case false:
                    return "Product name"
                }
            }
        }
        static var producDesc: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "وصف المنتج"
                case false:
                    return "Product description"
                }
            }
        }
        static var prodCategory: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "القسم"
                case false:
                    return "Category"
                }
            }
        }
        static var productQuanKG: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كمية المنتج للكيلو"
                case false:
                    return "Quantity in KG"
                }
            }
        }
        
        static var productQuanUnit: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كمية المنتج للحبة"
                case false:
                    return "Quantity in Unit"
                }
            }
        }
        
        
        static var productQuanBox: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كمية المنتج للصندوق"
                case false:
                    return "Quantity in Box"
                }
            }
        }
        static var productPriceKG: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سعر المنتج للكيلو"
                case false:
                    return "Price of KG"
                }
            }
        }
        
        static var productPriceUnit: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سعر المنتج للحبة"
                case false:
                    return "Price of Unit"
                }
            }
        }
        
        
        static var productPriceBox: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سعر المنتج للصندوق"
                case false:
                    return "Price of Box"
                }
            }
        }
        static var productDiscPriceKG: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سعر المنتج بعد الخصم للكيلو"
                case false:
                    return "Discount Price of KG"
                }
            }
        }
        static var productDiscPriceBox: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سعر المنتج بعد الخصم للصندوق"
                case false:
                    return "Discount Price of Box"
                }
            }
        }
        
        static var unitDiscPriceBox: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سعر الحبة بعد الخصم "
                case false:
                    return "Discount Price of Unit"
                }
            }
        }
        
        
        static var invalidDiscPriceKG: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سعر المنتج بعد الخصم للكيلو يجب ان يكون اقل من سعر المنتج للكيلو"
                case false:
                    return "Discount price of kg must be less than price of kg"
                }
            }
        }
        static var invalidDiscPriceBox: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سعر المنتج بعد الخصم للصندوق يجب ان يكون اقل من سعر المنتج للصندوق"
                case false:
                    return "Discount price of box must be less than price of box"
                }
            }
        }
        static var productKilosInBox: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عدد الكيلوهات في الصندوق"
                case false:
                    return "Number of Kilos in Box"
                }
            }
        }
        static var adsNumber :String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عدد الإعلانات : "
                case false:
                    return "Adv No. : "
                }
            }
        }
        static var call: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إتصال"
                case false:
                    return "Call"
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
        static var sendemail: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "البريد الإلكتروني"
                case false:
                    return "Mail"
                }
            }
        }
        static var sms: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رسالة"
                case false:
                    return "SMS"
                }
            }
        }
        static var msg: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "محادثة"
                case false:
                    return "Chat"
                }
            }
        }
        static var newsDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تفاصيل الخبر"
                case false:
                    return "New's details"
                }
            }
        }
        static var rentPrice: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سعر الإيجار"
                case false:
                    return "Reservation price"
                }
            }
        }
        static var reserve: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تأجير"
                case false:
                    return "Rent"
                }
            }
        }
        static var invalidCartStores: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لا يمكن أن يحتوي طلبك على منتجات من متاجر أخري، هل ترغب بحذف طلبك السابق وإضافة هذا الطلب ؟"
                case false:
                    return "Your order cannot contain products from other stores. Do you want to delete your previous order and add this order?"
                }
            }
        }
        
        static var developer: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تصميم و تطوير"
                case false:
                    return "Developed by "
                }
            }
        }
        static var versionno: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رقم النسخة"
                case false:
                    return "Version no."
                }
            }
        }
        static var offers: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "العروض"
                case false:
                    return "Offers"
                }
            }
        }
        static var details: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "التفاصيل"
                case false:
                    return "Details"
                }
            }
        }
        static var subscribeToPckg: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الإشتراك في الباقة"
                case false:
                    return "Subscribe to package"
                }
            }
        }
        static var reservationDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تفاصيل الحجز"
                case false:
                    return "Reservation details"
                }
            }
        }
        static var aboutclinic: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "من نحن"
                case false:
                    return "About"
                }
            }
        }
        static var nightshift: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الفترة المسائية"
                case false:
                    return "Night shift"
                }
            }
        }
        static var morningshift: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الفترة الصباحية"
                case false:
                    return "Morning shift"
                }
            }
        }
        static var notRegistered: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "انت غير مسجل في التطبيق، فضلا سجل لتتمكن من الدخول"
                case false:
                    return "You are not registered , register to be able to login"
                }
            }
        }
        static var notavailable: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "هذه الخدمة غير متاحة الأن"
                case false:
                    return "This feature is not available at the  moment"
                }
            }
        }
        static var notEnoughQuant: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الكمية المختارة غير متاحة"
                case false:
                    return "The selected quantity is not avaialble in stock"
                }
            }
        }
        static var notavailablePhone: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تسجيل الدخول برقم الجوال غير متاح الأن"
                case false:
                    return "Login with mobile number is not avaialble at this moment"
                }
            }
        }
        static var reservetime: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إختر موعد الحجز"
                case false:
                    return "Choose reservation time"
                }
            }
        }
        
        static var reservationtime: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الموعد :"
                case false:
                    return "Time :"
                }
            }
        }
        static var reservedate: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إختر تاريخ الحجز"
                case false:
                    return "Choose reservation date"
                }
            }
        }
        static var reservationdate: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "التاريخ :"
                case false:
                    return "Date :"
                }
            }
        }
        static var reservationcost: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سعر الكشف :"
                case false:
                    return "Reservation cost :"
                }
            }
        }
        static var continuereserve: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "متابعة الحجز"
                case false:
                    return "Continue reservation"
                }
            }
        }
        static var editreserve: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تعديل الحجز"
                case false:
                    return "Edit reservation"
                }
            }
        }
        static var clinicdoctors: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "طاقم الأطباء"
                case false:
                    return "Doctors' Staff"
                }
            }
        }
        static var availabletill: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "ساري حتي "

                case false:
                    return "Avaialable till  "
                }
            }
        }
        static var noMobileFound: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لا يوجد رقم جوال"
                case false:
                    return "No mobile mumber found "
                }
            }
        }
        static var noLinksFound: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لا يوجد رابط"
                case false:
                    return "No link found "
                }
            }
        }
        static var noAttachFound: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لا يوجد مرفق"
                case false:
                    return "No attachement found "
                }
            }
        }
        
        static var noSmsFound: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لا يوجد رقم جوال للمراسلة"
                case false:
                    return "No mobile number found to send SMS"
                }
            }
        }
        
        static func couldNotCall(phoneNumber: String) -> String {
            switch LanguageManager.isArabic {
            case true:
                return "لا يمكن الاتصال برقم الجوّال: \(phoneNumber)"
            case false:
                return "Could not call mobile number: \(phoneNumber)"
            }
        }
        
        static func couldNotText(phoneNumber: String) -> String {
            switch LanguageManager.isArabic {
            case true:
                return "لا يمكن ارسال رسالة نصية إلى رقم الجوّال: \(phoneNumber)"
            case false:
                return "Could not text mobile number: \(phoneNumber)"
            }
        }
        
        static var estimatedTime: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الوقت المتوقع للوصول من السائق :"
                case false:
                    return "estimated time by driver : "
                }
            }
        }
        static var age: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "العمر : "
                case false:
                    return "Age : "
                }
            }
        }
        static var photoLibrary: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مكتبة الصور"
                case false:
                    return "Photo Library"
                }
            }
        }
        static var type: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نوع العضوية"
                case false:
                    return "Membership type"
                }
            }
        }
        static var mark: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الماركة"
                case false:
                    return "Brand"
                }
            }
        }
        static var carname: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "السيارة"
                case false:
                    return "Car"
                }
            }
        }
        static var reservationPlace: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مكان الحجز"
                case false:
                    return "Reservation place"
                }
            }
        }
        static var numberofDays: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عدد الأيام"
                case false:
                    return "No. of days"
                }
            }
        }
        static var days: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يوم"
                case false:
                    return "Days"
                }
            }
        }
        static var minutes: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "دقيقة"
                case false:
                    return "Minutes"
                }
            }
        }
        static var hours: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "ساعات"
                case false:
                    return "Hours"
                }
            }
        }
        static var km: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كم"
                case false:
                    return "KM"
                }
            }
        }
        static var kg: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كيلو"
                case false:
                    return "Kg"
                }
            }
        }
        static var box: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "صندوق"
                case false:
                    return "Box"
                }
            }
        }
        
        static var unit: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "حبة"
                case false:
                    return "unit"
                }
            }
        }
        
        
        static var pricePerDay: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "السعر في اليوم"
                case false:
                    return "Price per day"
                }
            }
        }
        static var totalPrice: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إجمالي المبلغ"
                case false:
                    return "Total price"
                }
            }
        }
        static var choosePaymentTypes: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إختر طريقة الدفع"
                case false:
                    return "Choose payment type"
                }
            }
        }
        static var epayment: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الدفع الإلكتروني"
                case false:
                    return "EPayment"
                }
            }
        }
        static var bankPayment: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تحويل بنكي"
                case false:
                    return "Bank Transfer"
                }
            }
        }
        static var payWallet: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الدفع عن طريق المحفظة"
                case false:
                    return "Pay By Wallet"
                }
            }
        }
        static var cashOnDelivery: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الدفع عند الإستلام"
                case false:
                    return "Cash On Delivery"
                }
            }
        }
        static var netOnDelivery: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "شبكة"
                case false:
                    return "Network"
                }
            }
        }
        static var fastOrder: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "طلب سريع"
                case false:
                    return "Fast order"
                }
            }
        }
        static var normalOrder: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "طلب عادي"
                case false:
                    return "Normal order"
                }
            }
        }
        static var chooseDeliveryType: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إختر طريقة الإستلام"
                case false:
                    return "Choose delivery type"
                }
            }
        }
        static var chooseDeliveryAddress: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إختر عنوان التوصيل "
                case false:
                    return "Choose delivery address"
                }
            }
        }
        static var choosePeriods: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تحديد الفترات"
                case false:
                    return "Determine the periods"
                }
            }
        }
        static var invalidDeliveryTimes: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الفترات المحددة اكثر من عدد مرات التوصيل للباقة"
                case false:
                    return "Periods selected exceeded the delivery times of this package"
                }
            }
        }
        
        
        static var chooseUnitAndQuantity: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تحديد الوحدة والكمية"
                case false:
                    return "Choose unit & quantity"
                }
            }
        }
        static var quantity: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الكمية"
                case false:
                    return "Quantity"
                }
            }
        }
        static var fromOffice: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إستلام من المكتب"
                case false:
                    return "From office"
                }
            }
        }
        
        static var homeDelivery: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "توصيل للمنزل"
                case false:
                    return "Home delivery"
                }
            }
        }
        static var color: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "اللون"
                case false:
                    return "Color"
                }
            }
        }
        static var model: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الموديل"
                case false:
                    return "Model"
                }
            }
        }
        static var all: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الكل"
                case false:
                    return "All"
                }
            }
        }
        
        static var camera: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الكاميرا"
                case false:
                    return "Camera"
                }
            }
        }
        
        static var appName: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "هلا هلا كار"
                case false:
                    return "Hala Hala Car"
                }
            }
        }
        static var selectImg: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إختار صورة"
                case false:
                    return "Select Image"
                }
            }
        }
        static var fromPhotoLibrary: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "من مجلد الصور"
                case false:
                    return "From Photo Library"
                }
            }
        }
        static var reviews: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "التقييمات"
                case false:
                    return "Reviews"
                }
            }
        }
        static var views: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "المشاهدات : "
                case false:
                    return "Views : "
                }
            }
        }
        static var comments: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "التعليقات"
                case false:
                    return "Comments"
                }
            }
        }
        static var addcomment: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أضف تعليق"
                case false:
                    return "Add comment"
                }
            }
        }
        static var addNewAd: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أضف إعلان جديد"
                case false:
                    return "Add new ad"
                }
            }
        }
        static var addOffer: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إضافة عرض"
                case false:
                    return "Add Offer"
                }
            }
        }
        static var editOffer: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تعديل العرض"
                case false:
                    return "Edit Offer"
                }
            }
        }
        static var addCategory: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إضافة قسم"
                case false:
                    return "Add Category"
                }
            }
        }
        static var editCategory: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تعديل القسم"
                case false:
                    return "Edit Category"
                }
            }
        }
        static var addProduct: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إضافة منتج"
                case false:
                    return "Add Product"
                }
            }
        }
        static var editProduct: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تعديل المنتج"
                case false:
                    return "Edit Product"
                }
            }
        }
        static var editMeal: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تعديل الوجبة"
                case false:
                    return "Edit Meal"
                }
            }
        }
        static var add: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إضافة"
                case false:
                    return "Add"
                }
            }
        }
        static var addedToCart: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم الإضافة الى السلة"
                case false:
                    return "Product has been added to cart"
                }
            }
        }
        static var price: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "السعر"
                case false:
                    return "Price"
                }
            }
        }
        static var valuationPrice: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "قيمة التقييم"
                case false:
                    return "Valuation amount"
                }
            }
        }
        static var speed: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "السرعة"
                case false:
                    return "Speed"
                }
            }
        }
        static var easy: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "السهولة"
                case false:
                    return "Ease of use"
                }
            }
        }
        static var safety: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الأمان"
                case false:
                    return "Safety"
                }
            }
        }
        static var week: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الإسبوع"
                case false:
                    return "Week"
                }
            }
        }
        static var saturday: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "السبت"
                case false:
                    return "Sat"
                }
            }
        }
        static var sunday: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الأحد"
                case false:
                    return "Sun"
                }
            }
        }
        static var monday: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الإثنين"
                case false:
                    return "Mon"
                }
            }
        }
        static var tuesday: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الثلاثاء"
                case false:
                    return "Tue"
                }
            }
        }
        static var wednesday: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الأربعاء"
                case false:
                    return "Wed"
                }
            }
        }
        static var thursday: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الخميس"
                case false:
                    return "Thu"
                }
            }
        }
        static var friday: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الجمعة"
                case false:
                    return "Fri"
                }
            }
        }
        static var customerservice: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "خدمة العملاء"
                case false:
                    return "Customer service"
                }
            }
        }
        static var servicequality: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "جودة الخدمة"
                case false:
                    return "Service's quality"
                }
            }
        }
        static var communication: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "التواصل"
                case false:
                    return "Communication"
                }
            }
        }
        
        static var untill: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "حتى "
                case false:
                    return "Untill "
                }
            }
        }
        static var statistics: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الإحصائيات"
                case false:
                    return "Statistics"
                }
            }
        }
        static var view: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مشاهدة"
                case false:
                    return "View"
                }
            }
        }
      
        
        
        
        
        
        
        static var fromcamera: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إلتقط صورة"
                case false:
                    return "From Camera"
                }
            }
        }
        
        
        static var important: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "هام !!!"
                case false:
                    return "IMPORTANT !!"
                }
            }
        }
        static var accessLibrary: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الوصول إلى المكتبة مطلوب للحصول على الصور"
                case false:
                    return "Library access required for getting photos"
                }
            }
        }
        static var accessCamera: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الوصول إلى الكاميرا مطلوب لالتقاط الصور"
                case false:
                    return "Camera access required for capturing photos"
                }
            }
        }
        static var allow: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "السماح"
                case false:
                    return "Allow Access"
                }
            }
        }
        
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
        static var register: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إنشاء حساب جديد"
                case false:
                    return "Create new account"
                }
            }
        }
        static var registerViaGoogle: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تسجيل بجوجل"
                case false:
                    return "Login with Google"
                }
            }
        }
        static var registerViaFacebok: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تسجيل بفيسبوك"
                case false:
                    return "Login with Facebook"
                }
            }
        }
        static var skip: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تخطي"
                case false:
                    return "Skip"
                }
            }
        }
        static var byregistering: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سجل الآن لتستطيع الحصول على أفضل العروض والأسعار والخصومات"
                case false:
                    return "Register now to get the best offers , prices and discounts"
                }
            }
        }
        static var user: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مستخدم"
                case false:
                    return "Customer"
                }
            }
        }
        static var company: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "شركة"
                case false:
                    return "Company"
                }
            }
        }
        static var registerWithMail: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تسجيل بالبريد الإلكتروني"
                case false:
                    return "Register with email"
                }
            }
        }
        static var asTraveler: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مسافر"
                case false:
                    return "As A Traveler"
                }
            }
        }
        static var asDriver: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سائق"
                case false:
                    return "As A Driver"
                }
            }
        }
        static var myOrders: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "طلباتي"
                case false:
                    return "My Orders"
                }
            }
        }
        static var orderDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تفاصيل الطلب"
                case false:
                    return "Order Details"
                }
            }
        }
        static var moreDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "المزيد من التفاصيل"
                case false:
                    return "More details"
                }
            }
        }
        static var reservationSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم إرسال الطلب بنجاح"
                case false:
                    return "Your order has been sent successfuly"
                }
            }
        }
        static var adPublishedSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم نشر الإعلان بنجاح"
                case false:
                    return "Your ad has been published successfuly"
                }
            }
        }
        static var addOfferSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم إضافة العرض بنجاح"
                case false:
                    return "Your offer has been added successfuly"
                }
            }
        }
        static var addMealSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم إضافة الوجبة بنجاح"
                case false:
                    return "Your meal has been added successfuly"
                }
            }
        }
        static var editMealSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم تعديل الوجبة بنجاح"
                case false:
                    return "Your meal has been edited successfuly"
                }
            }
        }
        static var addAdditionSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم إضافة الإضافة بنجاح"
                case false:
                    return "Your addition has been added successfuly"
                }
            }
        }
        static var editAdditionSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم تعديل الإضافة بنجاح"
                case false:
                    return "Your addition has been edited successfuly"
                }
            }
        }
        static var unfavSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم الحذف من المفضلة بنجاح"
                case false:
                    return "Has been removed from favorites successfuly"
                }
            }
        }
        static var deleteNotificationSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم الحذف من الإشعارات بنجاح"
                case false:
                    return "Has been removed from notification successfuly"
                }
            }
        }
        static var deleteNotificationAlert: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "هل تريد حذف الإشعار ؟"
                case false:
                    return "Do you want to delete the notification ?"
                }
            }
        }
        static var deleteProductAlert: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "هل تريد حذف المنتج ؟"
                case false:
                    return "Do you want to delete this product ?"
                }
            }
        }
        static var deleteCatAlert: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "هل تريد حذف القسم ؟"
                case false:
                    return "Do you want to delete this category ?"
                }
            }
        }
        static var activateAdAlert: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "هل تريد تنشيط الإعلان لمدة شهر ؟"
                case false:
                    return "Do you want to activate the Ad for one month?"
                }
            }
        }
        static var alreadyCancelled: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "هذا الإعلان مغلق بالفعل"
                case false:
                    return "This ad is already closed"
                }
            }
        }
        static var deleteAdSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم إغلاق الإعلان"
                case false:
                    return "Ad has been closed"
                }
            }
        }
        static var activateAdSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم تنشيط الإعلان"
                case false:
                    return "Ad has been activated"
                }
            }
        }
        static var deleteMessageAlert: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "هل تريد حذف المحادثة ؟"
                case false:
                    return "Do you want to delete the message ?"
                }
            }
        }
        static var deleteMessageSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم الحذف من المراسلات بنجاح"
                case false:
                    return "Has been removed from messages successfuly"
                }
            }
        }
        static var favSuccess: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم الإضافة إلى المفضلة بنجاح"
                case false:
                    return "Has been added to favorites successfuly"
                }
            }
        }
        static var faq: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الأسئلة المتكررة"
                case false:
                    return "FAQ"
                }
            }
        }
        
        static var holesaleMarket: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سوق الجملة"
                case false:
                    return "Holesale market"
                }
            }
        }
        
        
        
        static var reservationSuccessHint: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سيتم مراجعة طلبك من قبل الإدارة و من ثم تفعيله"
                case false:
                    return "Your request will be reviewed by the administration and then activated"
                }
            }
        }
        static var confirmed: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الطلبات السابقة"
                case false:
                    return "Finished Orders"
                }
            }
        }
        static var pending: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "في الإنتظار"
                case false:
                    return "Pending"
                }
            }
        }
        static var newOrders: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "جديدة"
                case false:
                    return "New Orders"
                }
            }
        }
        static var inProgress: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "قيد التنفيذ"
                case false:
                    return "In Progress"
                }
            }
        }
        static var finishedOrdeer: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "منتهية"
                case false:
                    return "Finished"
                }
            }
        }
        static var inDelivery: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "جاري التوصيل"
                case false:
                    return "In Delivery"
                }
            }
        }
        static var delivered: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم التوصيل"
                case false:
                    return "Delivered"
                }
            }
        }
        static var cancelled: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم الإلغاء"
                case false:
                    return "Cancelled"
                }
            }
        }
        static var imagesGallery: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "معرض الصور"
                case false:
                    return "Images gallery"
                }
            }
        }
        static var videosGallery: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "معرض الفيديو"
                case false:
                    return "Videos gallery"
                }
            }
        }
        static var menu: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "القائمة"
                case false:
                    return "Menu"
                }
            }
        }
        static var home: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إكتشف"
                case false:
                    return "Discover"
                }
            }
        }
        static var searchResults: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نتائج البحث"
                case false:
                    return "Search results"
                }
            }
        }
        static var categories: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الأقسام"
                case false:
                    return "Departments"
                }
            }
        }
        static var products: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "المنتجات"
                case false:
                    return "Products"
                }
            }
        }
        static var duration: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مدة الباقة"
                case false:
                    return "Duration"
                }
            }
        }
        static var determinedPeriods: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "المواعيد المحددة"
                case false:
                    return "Selected periods"
                }
            }
        }
        
        static var startSearch: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إبدأ البحث"
                case false:
                    return "Start your search"
                }
            }
        }
        static var articlesAndNews: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مقالات"
                case false:
                    return "Articles"
                }
            }
        }
        static var allarticles: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كل المقالات"
                case false:
                    return "All articles"
                }
            }
        }
        static var estsharaOrQadeya: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "اطلب إستشارة او قضية"
                case false:
                    return "Order consultation"
                }
            }
        }
        static var order: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "اطلب"
                case false:
                    return "Order"
                }
            }
        }
        static var mediaLibrary: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أحدث العروض و الإعلانات"
                case false:
                    return "Latest offers & advertisments"
                }
            }
        }
        static var allMedia: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عرض الكل"
                case false:
                    return "Show all"
                }
            }
        }
        static var changeLang: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تغيير لغة التطبيق"
                case false:
                    return "Change app language"
                }
            }
        }
        static var sendSuggession: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "شاركنا مقترحاتك"
                case false:
                    return "Share your suggestion"
                }
            }
        }
        static var changeCurrency: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تغيير العملة "
                case false:
                    return "Change currency"
                }
            }
        }
        static var info: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "صفحة تعريفية"
                case false:
                    return "Introductory page"
                }
            }
        }
        static var chat: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الرسائل"
                case false:
                    return "Messages"
                }
            }
        }
        static var myProfile: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الملف الشخصي"
                case false:
                    return "My Profile"
                }
            }
        }
        static var memberSince: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عضو منذ "
                case false:
                    return "Member since "
                }
            }
        }
        static var contactUs: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إتصل بنا"
                case false:
                    return "Contact Us"
                }
            }
        }
        static var msgSentSuccessfuly: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم إرسال رسالتك بنجاح"
                case false:
                    return "Your message has been sent successfully"
                }
            }
        }
        
        static var cancelOrderSuccessfuly: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم إلغاء الطلب بنجاح"
                case false:
                    return "Your order has been cancelled"
                }
            }
        }
        static var rateSentSuccessfuly: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "شكراً ، تم إرسال تقييمك"
                case false:
                    return "Thanks, Your rate has been sent"
                }
            }
        }
        static var rateUpdatedSuccessfuly: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "شكراً ، تم تعديل تقييمك"
                case false:
                    return "Thanks, Your rate has been updated"
                }
            }
        }
        static var statusUpdatedSuccessfuly: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "شكراً ، تم تعديل حالة الطلب"
                case false:
                    return "Thanks, Your order status has been updated"
                }
            }
        }
        static var profileUpdatedSuccessfuly: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم تعديل الحساب بنجاح"
                case false:
                    return "Profile has been updated successfully"
                }
            }
        }
        
        static var switchToArabic: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "عربي"
                case false:
                    return "Arabic"
                }
            }
        }
        
        static var switchToEnglish: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إنجليزي"
                case false:
                    return "English"
                }
            }
        }
        
        static var logout: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تسجيل خروج"
                case false:
                    return "Logout"
                }
            }
        }
        static var myRequests: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "طلباتي"
                case false:
                    return "My Requests"
                }
            }
        }
        static var requestReasons: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أسباب الطلب"
                case false:
                    return "Reasons of request"
                }
            }
        }
        static var myAds: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إعلاناتي"
                case false:
                    return "My Ads"
                }
            }
        }
        static var myLocation: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مكاني الحالي"
                case false:
                    return "My Location"
                }
            }
        }
        
        static var Location: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الموقع"
                case false:
                    return "Location"
                }
            }
        }
        static var packages: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الإشتراكات و الباقات"
                case false:
                    return "Packages"
                }
            }
        }
        static var acceptAgreement: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يرجى الموافقة على إقرار صحة المحتوى الإعلاني"
                case false:
                    return "Kindly accept the validity of advertising content"
                }
            }
        }
        static var invalidLocation: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لم يتم التعرف على الموقع"
                case false:
                    return "Couldn't find location"
                }
            }
        }
        static var invalidCode: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كود التفعيل غير صحيح"
                case false:
                    return "Activation code is not valid"
                }
            }
        }
        static var propertyName: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "موضوع الإعلان"
                case false:
                    return "Ad Title"
                }
            }
        }
        static var propertyType: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نوع العمل"
                case false:
                    return "Business Type"
                }
            }
        }
        static var propertyTypeSell: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "كيان المنشأة"
                case false:
                    return "Business Type"
                }
            }
        }
        static var purpose: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "غرض الإعلان"
                case false:
                    return "Purpose of your ad"
                }
            }
        }
        static var propertyActivityType: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "قطاع العمل الرئيسي"
                case false:
                    return "Main Business"
                }
            }
        }
        static var propertySubActivityType: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "قطاع العمل الفرعي"
                case false:
                    return "Sub Business"
                }
            }
        }
        static var challengeDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تفاصيل التحدي"
                case false:
                    return "Challenge Details"
                }
            }
        }
        static var innovationDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "المشكلة التي يحلها الابتكار"
                case false:
                    return "Problem or challenge that innovation solved"
                }
            }
        }
        static var propertyDesc: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "وصف المنشأة"
                case false:
                    return "Property description"
                }
            }
        }
        static var propertyKeywords: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الكلمات الدالة"
                case false:
                    return "Keywords"
                }
            }
        }
        static var propertyAssets: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أصول المنشأة"
                case false:
                    return "Property assets"
                }
            }
        }
        static var enterAssetName: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إدخل اسم الإصل"
                case false:
                    return "Enter asset name"
                }
            }
        }
        static var enterAddressName: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إدخل اسم العنوان"
                case false:
                    return "Enter address name"
                }
            }
        }
        static var propertyPrice: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "المطلوب ( الحد )"
                case false:
                    return "Requested amount"
                }
            }
        }
        static var challengePrice: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "قيمة عرضك"
                case false:
                    return "Your offer"
                }
            }
        }
        static var objectiveAndPrice: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الغرض و السعر"
                case false:
                    return "Purpose & Price"
                }
            }
        }
        static var objectiveAndValuation: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الغرض و التقييم"
                case false:
                    return "Purpose & Valuation"
                }
            }
        }
        static var objectiveAndAmount: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الغرض و القيمة المطلوبة"
                case false:
                    return "Purpose & Requested amount"
                }
            }
        }
        static var objectiveAndOffer: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الغرض و العرض المالي"
                case false:
                    return "Purpose & Offer"
                }
            }
        }
        static var pricerequested: String {
                   get {
                       switch LanguageManager.isArabic {
                       case true:
                           return "المبلغ المطلوب"
                       case false:
                           return "Requested price"
                       }
                   }
               }
        static var youroffer: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "قيمة عرضك"
                case false:
                    return "Your offer"
                }
            }
        }
        
        static var against: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مقابل"
                case false:
                    return "Against"
                }
            }
        }
        static var againstpart: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مقابل الشراكة"
                case false:
                    return "Partnership's Against"
                }
            }
        }
        static var partpurpose: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الغرض"
                case false:
                    return "Purpose"
                }
            }
        }
        static var propertyInformation: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "معلومات المنشأة"
                case false:
                    return "Property Informations"
                }
            }
        }
        static var propertyData: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "معلومات الإعلان و المعلن"
                case false:
                    return "Ad & Owner Informations"
                }
            }
        }
        static var innovationPhase: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مرحلة الإبتكار"
                case false:
                    return "Innovation Phase"
                }
            }
        }
        static var establishDate: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تاريخ التأسيس"
                case false:
                    return "Establish Date"
                }
            }
        }
        static var ofEquity: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "٪ من حقوق الملكية"
                case false:
                    return "% of business equity"
                }
            }
        }
        static var jpgOnly: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يجب ان تكون الصورة من نوع JPG فقط"
                case false:
                    return "The image must be in JPG format only"
                }
            }
        }
        static var invalidImage: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لا يمكن اختيار صورة من نوع PNG"
                case false:
                    return "Sorry , PNG images are not supported"
                }
            }
        }
        static var partSale: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "للبيع ( تخارج )"
                case false:
                    return "For Sale"
                }
            }
        }
        static var innovSale: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لبيع حقوق الإبتكار"
                case false:
                    return "For Sale the innovative rights"
                }
            }
        }
        static var challengeSale: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لشراء حقوق الإبتكار"
                case false:
                    return "To Buy the innovative solution rights"
                }
            }
        }
        static var partRaising: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لرفع رأس المال"
                case false:
                    return "For Capital raising"
                }
            }
        }
        static var propertyPricePart: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "المبلغ المطلوب"
                case false:
                    return "Requested price"
                }
            }
        }
        static var totalAssetsValue: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "قيمة الأصول"
                case false:
                    return "Assets value"
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
        
        static var note: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "ملاحظة"
                case false:
                    return "Note"
                }
            }
        }
        static var notifications: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الإشعارات"
                case false:
                    return "Notifications"
                }
            }
        }
        static var map: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الخريطة"
                case false:
                    return "Map"
                }
            }
        }
        
        static var mobileNumber: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رقم الجوال "
                case false:
                    return "Mobile "
                }
            }
        }
        static var phoneNumber: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رقم الهاتف "
                case false:
                    return "Phone "
                }
            }
        }
        static var companyName: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إسم الشركة"
                case false:
                    return "Company name"
                }
            }
        }
        static var bankHolder: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إسم المحول"
                case false:
                    return "Sender's name"
                }
            }
        }
        static var bankAccount: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الحساب المحول منه"
                case false:
                    return "Sender's account"
                }
            }
        }
        static var bankName: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "البنك"
                case false:
                    return "Bank"
                }
            }
        }
        static var bankTransferImage: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "صورة التحويل"
                case false:
                    return "Transfer image"
                }
            }
        }
        
        static var companyNameAr: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إسم الشركة بالعربي"
                case false:
                    return "Company name ( arabic )"
                }
            }
        }
        static var companyNameEn: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إسم الشركة بالإنجليزية"
                case false:
                    return "Company name ( english )"
                }
            }
        }
        static var companyDetailsAr: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "وصف الشركة بالعربي"
                case false:
                    return "Company details ( arabic )"
                }
            }
        }
        static var companyDetailsEn: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "وصف الشركة بالإنجليزية"
                case false:
                    return "Company details ( english )"
                }
            }
        }
        static var companyMainImage: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "صورة أساسية للحساب"
                case false:
                    return "Main profile's image"
                }
            }
        }
        static var commingsoon: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "هذه الخدمة ستكون متاحة قريباً"
                case false:
                    return "This feature will be available soon"
                }
            }
        }
        static var companySubImage: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "صورة فرعية للحساب"
                case false:
                    return "Sub profile's image"
                }
            }
        }
       
        static var instagram: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إنستجرام"
                case false:
                    return "Instagram"
                }
            }
        }
        static var twitter: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تويتر"
                case false:
                    return "Twitter"
                }
            }
        }
        
        static var likedin: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "لينكد إن"
                case false:
                    return "LinkedIn"
                }
            }
        }
        static var mapLocation: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "موقع العميل على الخريطة"
                case false:
                    return "User's location on map"
                }
            }
        }
        static var website: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الويب"
                case false:
                    return "Website"
                }
            }
        }
        static var workingHours: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "أوقات الدوام"
                case false:
                    return "Working time"
                }
            }
        }
        static var userDisplayName: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الإسم "
                case false:
                    return "Name "
                }
            }
        }
        static var referrerCode: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "الكود المرجعي"
                case false:
                    return "Referrer code"
                }
            }
        }
        static var email: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رقم الجوال/البريد الإلكتروني "
                case false:
                    return "Mobile / E-mail"
                }
            }
        }
        static var emailonly: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "البريد الإلكتروني"
                case false:
                    return "E-mail"
                }
            }
        }
        static var noaccount: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "ليس لديك حساب ؟"
                case false:
                    return "Don't have account ?"
                }
            }
        }
        static var hasaccount: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return " لديك حساب ؟"
                case false:
                    return "Have account ?"
                }
            }
        }
        static var verified: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "موثوق"
                case false:
                    return "Verified"
                }
            }
        }
        static var activateAd: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تنشيط"
                case false:
                    return "Activate"
                }
            }
        }
        
        static var msgDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تفاصيل الرسالة"
                case false:
                    return "Message details"
                }
            }
        }
        static var memberDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تفاصيل العضو"
                case false:
                    return "Member details"
                }
            }
        }
        static var propertyDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تفاصيل المنشأة"
                case false:
                    return "Property details"
                }
            }
        }
        static var productImages: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "صور المنتج"
                case false:
                    return "Product photos"
                }
            }
        }
        static var categoryImages: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "صور القسم"
                case false:
                    return "Category photos"
                }
            }
        }
        static var financialResults: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "النتائج المالية"
                case false:
                    return "Financial results"
                }
            }
        }
        static var financialResultsErrorHandling: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سياسة ادخال البيانات المالية\n* لا يمكن ادخال قيم المصروفات بدون قيم الإيرادات.\n* يمكن ادخال قيم الإيرادات فقط.\n* في حال إدخال قيم الإيرادات والمصروفات يتم حساب صافي الربح اوتوماتيكيا.\n* في حال البدء في إدخال قيم بأي عمود يجب إكمال جميع قيم العمود."
                case false:
                    return "Financial entries policy\n* Expense values cannot be entered without revenue values.\n* Only revenue values can be entered.\n* In case of revenue and expense values, net profit is calculated automatically.\n* If you start entering values in any column, you must complete all column values."
                }
            }
        }
       
        static var financialResultsOptional: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "النتائج المالية (إختياري)"
                case false:
                    return "Financial results (Optional)"
                }
            }
        }
        static var free: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "مجاني"
                case false:
                    return "Free"
                }
            }
        }
        static var goPremium: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "خليك مميز"
                case false:
                    return "Go Premium"
                }
            }
        }
        static var publishAd: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نشر الإعلان"
                case false:
                    return "Publish your ad"
                }
            }
        }
        static var sendmsg: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إرسال رسالة"
                case false:
                    return "Send message"
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
        static var entermsgDetails: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يرجى إدخال نص الرسالة"
                case false:
                    return "Enter your message"
                }
            }
        }
        
        static var submit: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إرسال"
                case false:
                    return "Send"
                }
            }
        }
        
        static var confirm: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تأكيد"
                case false:
                    return "Confirm"
                }
            }
        }
        static var billNumber: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "رقم العملية"
                case false:
                    return "Operation No."
                }
            }
        }
        
        static var done: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "تم"
                case false:
                    return "Done"
                }
            }
        }
        static var publish: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "نشر"
                case false:
                    return "Publish"
                }
            }
        }
        static var doctors: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "طبيب"
                case false:
                    return "doctors"
                }
            }
        }
        
        static var termsAndConditions: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "شروط الإستخدام"
                case false:
                    return "Terms & Conditions"
                }
            }
        }
        static var agreeon: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "بإنشائك حساب ، انت توافق على "
                case false:
                    return "By creating an account , you agree to our"
                }
            }
        }
        static var privacy: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "سياسة الخصوصية"
                case false:
                    return "Privacy policy"
                }
            }
        }
        static var and: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "و"
                case false:
                    return "And"
                }
            }
        }
        static var addImages: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إضافة صورة"
                case false:
                    return "Add Image"
                }
            }
        }
        static var addTwoImages: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يرجى إضافة صورة"
                case false:
                    return "Kindly Add Image"
                }
            }
        }
        static var attachType: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "إضافة مرفق"
                case false:
                    return "Add Attachement"
                }
            }
        }
        
        static var imageSource: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يرجى تحديد مصدر المرفق"
                case false:
                    return "Please choose the image's source"
                }
            }
        }
        static var attachSource: String {
            get {
                switch LanguageManager.isArabic {
                case true:
                    return "يرجى تحديد مصدر المرفق"
                case false:
                    return "Please choose the attachement's source"
                }
            }
        }
        
    }
}
