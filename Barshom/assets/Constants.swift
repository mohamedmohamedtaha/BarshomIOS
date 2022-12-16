
import Foundation
import UIKit



struct Constants {
    
    fileprivate static let ScreenSize: CGRect = UIScreen.main.bounds
    static let ScreenWidth = ScreenSize.width
    static let ScreenHeight = ScreenSize.height
    static let DeviceType = UIDevice.current.modelName
    static let accessPassword = "Q20R30Uu10jyt1ES5WWsdQM"
    static let accessKey = "CCQQ2sfW222wwfyv5w557Rt"
    struct messages {
        static let netFaild = NSLocalizedString("The connection is slow .. please try again!", comment: "")
    }
    
    struct UserDefaultsConstants {
        static let Email = "email"
        static let UserData = "UserData"
        static let Password = "password"
        
    }
    
//    struct storyBoard {
//          static let Main = UIStoryboard(name: "Main", bundle: nil)
//          static let Registration = UIStoryboard(name: "Registration", bundle: nil)
//          static let Profile = UIStoryboard(name: "Profile", bundle: nil)
//          static let Cart = UIStoryboard(name: "Cart", bundle: nil)
//          static let userOrders = UIStoryboard(name: "userOrders", bundle: nil)
//          static let sideMenu = UIStoryboard(name: "sideMenu", bundle: nil)
//          static let Stores = UIStoryboard(name: "Stores", bundle: nil)
//          static let ProductDetails = UIStoryboard(name: "ProductDetails", bundle: nil)
//          static let QuickOrder = UIStoryboard(name: "QuickOrder", bundle: nil)
//          static let packages = UIStoryboard(name: "packages", bundle: nil)
//          //static let editPackage = UIStoryboard(name: "editPackage", bundle: nil)
//          static let rate = UIStoryboard(name: "rate", bundle: nil)
//          static let complaint = UIStoryboard(name: "complaint", bundle: nil)
//      }
    
    struct Notification {
      static let swichHome = "swichHome"
      static let swichHomeInManTabBar = "swichHomeInManTabBar"
      static let offers = "offers"
    }
    
    struct APIProvider {
        
        static var baseImg: String {
            get {
                    return "https://brshom.com/app_services/"
                }
        }
        static var base: String {
            get {
                return baseImg
            }
        }
        static let token  = base + "token"
        static func getPhotoUrl(fileId: String) -> String {
            return "\(baseImg)\(fileId)"
        }
        struct Users {
            static let register = base + "signup"
            static let generateCode = base + "api/auth/gencode/"
            static let login = base + "login"
            static let updateUserToken = base + "updateUserToken"
            static let activateProfile = base + "activateAccount"
            static let forgetPassword = base + "forgotPasswordByMobile"
            static let checkForgotPassword = base + "checkForgotPassword"
            static let resetPassword = base + "resetPassword"
            static let setNewPassword = base + "newchangenewpassword"
            static let getUserData = base + "getUserData"
            static let updateProfile = base + "updateProfile"
            static let updateTraderProfile = base + "update_userapppassword"
            
            static let updateCustomer = base + "update_beneficial"
            static let verifyForgotPasswordCode = base + "verifyForgotPasswordCode"
            static let getCurrentUserInfo  = base + "getuserdata"
        }
        static let getUserOrders = base + "getOrders"
        static let getOrderDetails = base + "getOrder"
        static let getSettings = base + "getSettings"
        static let changeReceiveOrders = base + "userGetOrders"
        static let getUserNotifications = base + "getUserNotifications"
        static let getUserAddress = base + "getUserAddress"
        static let addUserAddress = base + "addUserAddress"
        
        static let deleteNotification = base + "deleteNotification"
        static let rateOrder = base + "rateOrder"
        static let rateProduct = base + "rateProduct"
        static let commonQuestions = base + "commonQuestions"
        static let applyCoupon = base + "applyCoupon"
        static let deleteCategory = base + "deleteCategory"
        static let deleteProduct = base + "deleteProduct"
        
        
        static let sendComplaint = base + "addComplaint"
        static let closeComplaint = base + "closeComplaint"
        static let getComplaints = base + "getComplaints"
        static let getComplaintMessages = base + "getUserChat"
        static let sendComplainMessage = base + "sendMessage"
        
        static let acceptOrder = base + "acceptorder"
        static let sendOrder = base + "addOrder"
        static let userCancelOrder = base + "cancelOrder"
        static let traderCancelOrder = base + "rejectOrder"
        static let traderAcceptOrder = base + "confirmOrder"
        static let traderFinishOrder = base + "orderDone"
        
        static let driverCancelOrder = base + "refuseOrder"
        static let driverInDeliveryOrder = base + "orderToDeliver"
        static let driverDeliveredOrder = base + "orderDelivered"
        
        static let finishOrder = base + "executedorder"
        static let submitFeedback = base + "saveContactUs"
        static let getTraderDepartments = base + "category_productivefamily"
        static let getSections = base + "getSections"
        static let getShifts = base + "getShifts"
        static let getMarketCategory = base + "getMarketCategory"
        static let getOtherMarkets = base + "getOtherMarkets"
        static let getUserPackages = base + "getUserPackages"
        static let getMarketPackages = base + "getMarketPackages"
        static let getMarketSubPackages = base + "getPrePackages"
        static let subscribeClientPackage = base + "subscribeClientPackage"
        static let subscribeUserPackage = base + "subscribeUserPackage"
        
        static let reportProduct = base + "reportProduct"
        static let getWithdrawRequests = base + "getWithdrawRequests"
        static let addWithdrawRequest = base + "addWithdrawRequest"
        
        static let getProducts = base + "getProducts"
        static let getCities = base + "getCities"
        static let getBanks = base + "getBanks"
        static let getAdsense = base + "getAdsense"
        static let getWorkers = base + "getWorkers"

        static let getTraderProductsByCat = base + "getmeal_bycategory"
        static let getTraderBills = base + "gettransferbank"
        static let getTraderOffers = base + "getfamilyoffers"
        static let addProduct = base + "addProduct"
        static let editProduct = base + "editProduct"
        static let addTraderDepartment = base + "addMarketCategory"
        static let editTraderDepartment = base + "editMarketCategory"

        static let addAddition = base + "insert_adds"
        static let editAddition = base + "update_adds"
        static let addAdditionProduct = base + "insert_adds_product"
        static let editAdditionProduct = base + "update_adds_product"
        static let getMealDetails = base + "getmeal_details"
        static let updateMeal = base + "update_meal"
        
        static let getAbout = base + "aboutApp"
        static let getAboutEN = base + "aboutAppen"
        static let getTerms = base + "appTerms"
        static let getTermsEN = base + "appTermsen"
        static let getTermsMarket = base + "appMarketTerms"
        static let getTermsMarketEN = base + "appMarketTermsen"
        static let getTermsDriver = base + "appDriverTerms"
        static let getTermsDriverEN = base + "appDriverTermsen"
        static let getContactUs = base + "basic_data/contact-us/"
        static func getPlaceByLocation(lat: String,lng: String) -> String {
            return "https://maps.googleapis.com/maps/api/geocode/json?latlng=\(lat),\(lng)&key=AIzaSyAK1lHVo4AmffT1ZoGTr3ZENS9IG8C2KLM"
        }
        static func getNearbyPlacesByLocation(lat: String,lng: String,pageToken: String) -> String {
            return "https://maps.googleapis.com/maps/api/place/nearbysearch/json?radius=50000&type=\(pageToken)&location=\(lat),\(lng)&key=AIzaSyDUFxKO76aItIw21lqPLNcMVCSjOcTlNP0&language=\(LanguageManager.isArabic ? "ar" : "en")"
        }
       

    }
    
    
}

var isIpad:Bool{
    let device = Constants.DeviceType
    if device == .iPad2 || device == .iPad3 || device == .iPad4 || device == .iPadAir || device == .iPadPro || device == .iPadAir2 || device == .iPadMini || device == .iPadMini2 || device == .iPadMini3 || device == .iPadMini4 {
        return true
    }
    return false
}

