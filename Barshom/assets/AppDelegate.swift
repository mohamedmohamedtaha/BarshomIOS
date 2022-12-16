//
//  AppDelegate.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/21/20.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftyUserDefaults
import SideMenu
import Firebase
import GooglePlaces
import MFSDK

@UIApplicationMain
class AppDelegate: UIResponder, BaseAppDelegate {
    func reloadApp() {
        UserManager.logout()
    }
    
    var getAccessTokenURL =  ""
    
    var fontName =  ""
    
    let gcmMessageIDKey = "gcm.message_id"

  var window: UIWindow?
  var defaultLanguage: Language = Language.en
    
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    FirebaseApp.configure()
    UserDefaultsManager.setDefaults()
    IQKeyboardManager.shared.enable = true
//    if let languageCode = Locale.current.languageCode
//    {
//        defaultLanguage = languageCode == "en" ? Language.en : Language.ar
//        LanguageManager.currentLanguage = defaultLanguage
//    }
    Localizer.doExtchangeLang()
    
    UIFont.overrideInitialize()
    if #available(iOS 10.0, *) {
        // For iOS 10 display notification (sent via APNS)
        UNUserNotificationCenter.current().delegate = self
        let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
        UNUserNotificationCenter.current().requestAuthorization(
            options: authOptions,
            completionHandler: {_, _ in })
        Messaging.messaging().delegate = self
        
    } else {
        
        let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
        application.registerUserNotificationSettings(settings)
    }
    application.registerForRemoteNotifications()
    GMSPlacesClient.provideAPIKey("AIzaSyAK1lHVo4AmffT1ZoGTr3ZENS9IG8C2KLM")
    UIApplication.shared.applicationIconBadgeNumber = 0
      
    
//      UINavigationBar.appearance().setTranslucent(tintColor: Color.mainColor!, titleColor: .white)
   
      
    setUpMyFatoorah()
      
      if #available(iOS 15, *) {
          let navigationBarAppearance = UINavigationBarAppearance()
                    navigationBarAppearance.configureWithOpaqueBackground()
                    navigationBarAppearance.titleTextAttributes = [
                        NSAttributedString.Key.foregroundColor : UIColor.white
                    ]
          navigationBarAppearance.backgroundColor = Color.mainColor
                    UINavigationBar.appearance().standardAppearance = navigationBarAppearance
                    UINavigationBar.appearance().compactAppearance = navigationBarAppearance
          UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance

          
      }
     
    return true
  }

    func applicationDidFinishLaunching(_ application: UIApplication) {
        FirebaseApp.configure()
        UserDefaultsManager.setDefaults()

        IQKeyboardManager.shared.enable = true
        if let languageCode = Locale.current.languageCode
        {
            defaultLanguage = languageCode == "en" ? Language.en : Language.ar
            LanguageManager.currentLanguage = defaultLanguage
        }
        Localizer.doExtchangeLang()
        
        UIFont.overrideInitialize()
        if #available(iOS 10.0, *) {
            // For iOS 10 display notification (sent via APNS)
            UNUserNotificationCenter.current().delegate = self
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            Messaging.messaging().delegate = self
            
        } else {
            
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        application.registerForRemoteNotifications()
        GMSPlacesClient.provideAPIKey("AIzaSyAK1lHVo4AmffT1ZoGTr3ZENS9IG8C2KLM")
        UIApplication.shared.applicationIconBadgeNumber = 0
        setUpMyFatoorah()
    }
    func setUpMyFatoorah(){
            let url = "https://api.myfatoorah.com"
            let token = "_mqxW9Zp70XDAlVhYrII0Dqg_mO8FYEwh94NCKLtLwADHMuhiBfCnpT7lD1gdwp0TDd0WHaXcq56xHz9388-LALPtq818TsnRhBXKuxj11sD7KJWYnOtvtyMj8A55RHwEqmqeprm_SaDJj4cLmi2Fm-hP-fu3ILe7HQkhhpaqb2FA0TeF-TB7mb10RGxzED_rAeD2VxkXHRlSlezKATqkW5ItSoFYXhjJxS1eVWEFok3z1mx9wpneCkPyN5c1w_StSJgXDxx8nfONXeRS_yq2b6q5TN40sBqBB4W3ZZHHgA7iM50Y2skSFvs69CVI1y9H1O_pKWNAEW_f2gqvNv0GACiE4STvS115_OXyc-rvbFSQvKmYaVdbjoQghTDWngmFAXBvkWF0yW0ogCWkNeQNuw_COR4JWUde9_KHiYcTmAxOyu7mQ_WONCjNqGjxfxIjnk8bUkCLqcDTduanQdEbJb-M8GyXuzh3ee32J_wicPboIcaWdJuF_ECxTUNnBTzJpCAgJTkUsbvDzFQTUxRyLzTyzSefhTCVQ8Il4lvsxwO44Qtn3q-1b_TNAx3Csx0n25DYPMQZlRcFS4kHt3AiBSvNg5e7oN5Ff4rS2qioXZFcV-KaELzpTvXU1uVn-AzajzgEjG_st_MMRilafULdvJFuK2YUCqEQlqvLH723YxCRCSn4g7K4H7x9QQacrqu2fWEvdHCY6p3jjLnOF3jYapuSQhcksLY2SDFmaKLq_Y50wq-"
            
            MFSettings.shared.configure(token: token, baseURL: MFBaseURL(rawValue: url)!)
            let them = MFTheme(navigationTintColor: .white, navigationBarTintColor: .lightGray, navigationTitle: "Payment", cancelButtonTitle: "Cancel")
            MFSettings.shared.setTheme(theme: them)
            
        }
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        Messaging.messaging().apnsToken = deviceToken
        Messaging.messaging().token { (result, error) in
        if let error = error {
        print("Error fetching remote instange ID: \(error)")
        } else if let result = result {
        print("Remote instance ID token: \(result)")
         }
        }
        
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
        
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any],
                     fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // If you are receiving a notification message while your app is in the background,
        // this callback will not be fired till the user taps on the notification launching the application.
        // TODO: Handle data of notification
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        //         Messaging.messaging().appDidReceiveMessage(userInfo)
        //        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        let body = userInfo["body"] != nil ? userInfo["body"] as! String : ""
        let bodyDic = body.convertToDictionary()
        
        let detail = (bodyDic != nil && bodyDic!.keys.contains("detail")) ? (bodyDic!["detail"]! as! String) : ""
        let type = (bodyDic != nil && bodyDic!.keys.contains("type")) ? (bodyDic!["type"]! as! String) : "-1"
        
        switch type {
        case "0":
            BaseUserManager.billsCount = 1
            break
        case "2":
            BaseUserManager.adsCount = 1
            break
        case "1":
            BaseUserManager.msgCount = 1
            break
        default:
            break
        }
        NotificationCenter.default.post(
            name: Notification.Name("notif"),
            object: nil,
            userInfo: nil)
        
        let title = userInfo["title"] != nil ? userInfo["title"] as! String :  LanguageManager.isArabic ? "إشعار جديد" : "New Notification"
        
        AppHelper.scheduleNotification(at: Date().addingTimeInterval(2), title: title, body: detail)
        // Print full message.
        print(userInfo)
        
        completionHandler(UIBackgroundFetchResult.newData)
    }
    func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey: Any]) -> Bool {
        
        //        let urls = URL(string: "swifter://success")!
        //        if Swifter.handleOpenURL(url, callbackURL: urls)
        //        {
        //            return true
        //        }
        //
        //
        //       var signedIn: Bool =  Simplicity.application(app, open: url, options: options)
        print(url)
        
        
        return true
    }
    
    func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
        
        //       TWTRTwitter.sharedInstance().start(withConsumerKey:"mGHgHRTkaveGtArIJqOezPT39", consumerSecret:"ZIaydrRLlOaXEinQnowXdP0wH4wFQbKgWDuKpr9yTeCQ41XneD")
        
        //        return Simplicity.application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
        return true
    }
}

@available(iOS 10, *)
extension AppDelegate : UNUserNotificationCenterDelegate {
    
    // Receive displayed notifications for iOS 10 devices.
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        
        let userInfo = notification.request.content.userInfo
        
        // With swizzling disabled you must let Messaging know about the message, for Analytics
        Messaging.messaging().delegate = self
        
        Messaging.messaging().appDidReceiveMessage(userInfo)
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        let data = userInfo
        if let boddy = (userInfo["aps"])
        {
            let xx = ((userInfo["aps"] as! [String: AnyObject])["alert"] as! [String: AnyObject])
            let body = xx["body"] != nil ? xx["body"] as! String : ""
            let detail = body
            let type = (userInfo.keys.contains("type")) ? (userInfo["type"]! as! String) : "-1"
            switch type {
            case "0":
                BaseUserManager.billsCount = 1
                break
            case "2":
                BaseUserManager.adsCount = 1
                break
            case "1":
                BaseUserManager.msgCount = 1
                break
            default:
                break
            }
            NotificationCenter.default.post(
                name: Notification.Name("notif"),
                object: nil,
                userInfo: nil)
            let title = xx["title"] != nil ? xx["title"] as! String :  LanguageManager.isArabic ? "إشعار جديد" : "New Notification"
            AppHelper.scheduleNotification(at: Date().addingTimeInterval(2), title: title, body: detail)
        }
        
        
        // Print full message.
        //        print(userInfo)
        
        // Change this to your preferred presentation option
        if userInfo.keys.count == 0
        {
            completionHandler([.alert,.sound,.badge])
        }
        completionHandler([])
    }
    
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        if let messageID = userInfo[gcmMessageIDKey] {
            print("Message ID: \(messageID)")
        }
        
        // Print full message.
        print(userInfo)
        
        Messaging.messaging().delegate = self
        Messaging.messaging().appDidReceiveMessage(response.notification.request.content.userInfo)
        
        completionHandler()
    }
}
// [END ios_10_message_handling]

extension AppDelegate : MessagingDelegate {
    // [START refresh_token]
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("Firebase registration token: \(String(describing: fcmToken))")

      let dataDict: [String: String] = ["token": fcmToken ?? ""]
      NotificationCenter.default.post(
        name: Notification.Name("FCMToken"),
        object: nil,
        userInfo: dataDict
      )
      // TODO: If necessary send token to application server.
      // Note: This callback is fired at each app startup and whenever a new token is generated.
    }
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
      Messaging.messaging().apnsToken = deviceToken
    }
    // [END refresh_token]
    // [START ios_10_data_message]
    // Receive data messages on iOS 10+ directly from FCM (bypassing APNs) when the app is in the foreground.
    // To enable direct data messages, you can set Messaging.messaging().shouldEstablishDirectChannel to true.
//    @available(iOS 15.0.0, *)
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) async -> UIBackgroundFetchResult {
//
//    }
//    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
//        print("Received data message: \(remoteMessage.appData)")
//
//        if  remoteMessage.appData["notification"] != nil
//        {
//
//            let data = remoteMessage.appData["notification"] as! [String: AnyObject]
//
//
//        }
//        else
//        {
//            let body = remoteMessage.appData["body"] as! String
//            let title = remoteMessage.appData["title"] != nil ? remoteMessage.appData["title"] as! String : "Bab Rezk"
//            //            let fixtureId = data!["FixtureId"] != nil ? data!["FixtureId"] as! String : "-1"
//            UIApplication.shared.applicationIconBadgeNumber += 1
//
//            AppHelper.scheduleNotification(at: Date().addingTimeInterval(2), title: title, body: body)
//
//        }
//        //        let userInfo = notification.request.content.userInfo
//        //
//        //                // With swizzling disabled you must let Messaging know about the message, for Analytics
//        //        //         Messaging.messaging().appDidReceiveMessage(userInfo)
//        //                // Print message ID.
//        //                if let messageID = userInfo[gcmMessageIDKey] {
//        //                    print("Message ID: \(messageID)")
//        //                }
//        //                let data = userInfo
//        //                if let boddy = (userInfo["aps"])
//        //                {
//        //                    let xx = ((userInfo["aps"] as! [String: AnyObject])["alert"] as! [String: AnyObject])
//        //                    let body = xx["body"] != nil ? xx["body"] as! String : ""
//        //                    let bodyDic = body.convertToDictionary()
//        //
//        //                    let detail = (bodyDic != nil && bodyDic!.keys.contains("detail")) ? (bodyDic!["detail"]! as! String) : ""
//        //                    let type = (bodyDic != nil && bodyDic!.keys.contains("type")) ? (bodyDic!["type"]! as! Int) : 0
//        //
//        //                    let title = xx["title"] != nil ? xx["title"] as! String :  LanguageManager.isArabic ? "إشعار جديد" : "New Notification"
//        //
//        //        //            if order_id != ""
//        //        //            {
//        //        //                notificationOrderId = Int(order_id)!
//        //        //            }
//        //        //            if orderStatus != ""
//        //        //            {
//        //        //                notificationOrderStatus = orderStatus
//        //        //            }
//        //                    //            DispatchQueue.main.asyncAfter(deadline: .now()+1, execute: {
//        //                    //                NotificationCenter.default.post(name: NSNotification.Name("UpdateOrder"), object:nil)
//        //                    //            })
//        //
//        //                    //            let fixtureId = data!["FixtureId"] != nil ? data!["FixtureId"] as! String : "-1"
//        //                    //            UIApplication.shared.applicationIconBadgeNumber += 1
//        //
//        //                    AppHelper.scheduleNotification(at: Date().addingTimeInterval(2), title: title, body: detail)
//        //                }
//        //
//        //
//    }
    
    // [END ios_10_data_message]
}

extension UINavigationBar {
    static let defaultBackgroundColor = UIColor.red
    static let defaultTintColor = UIColor.white
    
    func setOpaque() {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithOpaqueBackground()
            appearance.backgroundColor = UINavigationBar.defaultBackgroundColor
            appearance.titleTextAttributes = [.foregroundColor: UINavigationBar.defaultTintColor]
            
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        } else {
            setBackgroundImage(UIImage(), for: UIBarPosition.any, barMetrics: UIBarMetrics.defaultPrompt)
            shadowImage = UIImage()
            barTintColor = UINavigationBar.defaultBackgroundColor
            titleTextAttributes = [.foregroundColor: UINavigationBar.defaultTintColor]
        }
        isTranslucent = false
        tintColor = UINavigationBar.defaultTintColor
    }
    
    func setTranslucent(tintColor: UIColor, titleColor: UIColor) {
        if #available(iOS 15, *) {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.titleTextAttributes = [.foregroundColor: titleColor]
            standardAppearance = appearance
            scrollEdgeAppearance = appearance
        } else {
            titleTextAttributes = [.foregroundColor: titleColor]
            setBackgroundImage(UIImage(), for: UIBarMetrics.default)
            shadowImage = UIImage()
        }
        isTranslucent = true
        self.tintColor = tintColor
    }
}
