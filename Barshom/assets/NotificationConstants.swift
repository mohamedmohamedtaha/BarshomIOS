//
//  NotificationConstant.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import Foundation
import UIKit

enum notificationEnum :String{
       case selectIndex = "selectIndex"
       case menuType = "menuType"
}

class Notify {
  
  static func post(_ name:notificationEnum,object: Any?){
    NotificationCenter.default.post(name: NSNotification.Name(rawValue: name.rawValue), object: object)
  }
  
  static func listen(_ vc:UIViewController,name:notificationEnum,selector:Selector){
    
    NotificationCenter.default.addObserver(vc, selector: selector, name: Notification.Name(name.rawValue), object: nil)

  }
    
}
