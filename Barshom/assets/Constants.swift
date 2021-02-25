
import Foundation
import UIKit



struct Constants {
    
    fileprivate static let ScreenSize: CGRect = UIScreen.main.bounds
    static let ScreenWidth = ScreenSize.width
    static let ScreenHeight = ScreenSize.height
    static let DeviceType = UIDevice.current.modelName
    static let backgroundViewAlpha = CGFloat(0.50)
    
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
        
        static let APIBaseURL = ""
        static let ImagesBaseURL = ""
        static let loginuserapps = APIBaseURL + "loginuserapps"
       

    }
    
    
}

var isIpad:Bool{
    let device = Constants.DeviceType
    if device == .iPad2 || device == .iPad3 || device == .iPad4 || device == .iPadAir || device == .iPadPro || device == .iPadAir2 || device == .iPadMini || device == .iPadMini2 || device == .iPadMini3 || device == .iPadMini4 {
        return true
    }
    return false
}

