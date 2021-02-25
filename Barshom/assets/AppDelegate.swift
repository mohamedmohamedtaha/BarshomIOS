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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

  var window: UIWindow?

  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    IQKeyboardManager.shared.enable = true
    Localizer.doExtchangeLang()
    let navigationBarAppearace = UINavigationBar.appearance()
     navigationBarAppearace.tintColor = UIColor.white
     navigationBarAppearace.titleTextAttributes = [.foregroundColor: UIColor.white]
     navigationBarAppearace.barTintColor = Color.mainColor
    UIApplication.shared.statusBarStyle = .lightContent
    //UIFont.overrideInitialize()
    UIApplication.shared.statusBarUIView?.backgroundColor = Color.mainColor
    
    return true
  }

 
  
}

