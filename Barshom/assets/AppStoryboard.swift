//
//  AppStoryBoards.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/30/20.
//

import Foundation
import UIKit


/// how to use --> let notificationVC = NotificationVC.instantiate( .Notification)

enum AppStoryboard : String {
  case Main
  case Profile
  case Cart
  case userOrders
  case sideMenu
  case Stores
  case ProductDetails
  case QuickOrder
  case packages
  case editPackage
  case rate
  case complaint
  case removeOrder
  case registration
  case forgertPassword
  case terms
  case contactUs
  case wallet
  case language
  case traderOrders
  case traderProfile
  case traderDepartment
  case driverOrders
  case driverProfile
  case balance
}

extension AppStoryboard {

var instance : UIStoryboard {

    return UIStoryboard(name: self.rawValue, bundle: Bundle.main)
}
  
  
func viewController<T : UIViewController>(viewControllerClass : T.Type, function : String = #function, line : Int = #line, file : String = #file) -> T {

    let storyboardID = (viewControllerClass as UIViewController.Type).storyboardID

    guard let scene = instance.instantiateViewController(withIdentifier: storyboardID) as? T else {

        fatalError("ViewController with identifier \(storyboardID), not found in \(self.rawValue) Storyboard.\nFile : \(file) \nLine Number : \(line) \nFunction : \(function)")
    }

    return scene
}

  
func initialViewController() -> UIViewController? {

    return instance.instantiateInitialViewController()
}
  
  
}

extension UIViewController {

  // Not using static as it wont be possible to override to provide custom storyboardID then
class var storyboardID : String {

    return "\(self)"
}

  static func instantiate(_ storyboard: AppStoryboard) -> Self {

      return storyboard.viewController(viewControllerClass: self)
  }
  
  func getStoryBoard(_ name:String) -> UIStoryboard {
   
      return UIStoryboard(name:name, bundle: Bundle.main)
    
  }


  
  func getType(_ storyBoardName:String)->AppStoryboard  {
    return AppStoryboard(rawValue: storyBoardName)!
    
  }
  
//   func loadVC()-> Self {
//    return Self.instantiate(getType("\(self.storyboard!.value(forKey: "name")!)"))
//  }
}




