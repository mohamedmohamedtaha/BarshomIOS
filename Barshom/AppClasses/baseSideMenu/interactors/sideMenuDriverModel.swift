//
//  sideMenuDriverModel.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import Foundation
import UIKit

enum driverMenuType:String {
  
    case myOrders = "My Orders"
    case driverInformation = "Driver Information"
    case Balance = "Balance"
    case complaint = "Complaint/Tickets"
    case langue = "Language"
    case notifications = "Notifications"
    case termsAndConditions = "terms And Conditions"
    case questions = "Questions"
    case aboutApp = "About App"
    case contactUs = "Contact Us"
    case logOut = "Log Out"
   
  
  init?(str: String) {
      self.init(rawValue:str.Localized)
  }
}

class driverSideMenu {
  
  func getRawValue(_ t:driverMenuType)->String{
    return t.rawValue
  }
  
  func getDriverMenuEnum(_ index:String)->driverMenuType{
    return driverMenuType(str: index)!
  }
  
  func driverMenuDic() -> [String:(UIImage?,Int)] {
    return [
      getRawValue(.myOrders):(#imageLiteral(resourceName: "requests"),1),
      getRawValue(.driverInformation):(#imageLiteral(resourceName: "info"),2),
      getRawValue(.Balance):(#imageLiteral(resourceName: "balance"),3),
      getRawValue(.complaint):(#imageLiteral(resourceName: "requests"),4),
      getRawValue(.langue):(#imageLiteral(resourceName: "language"),7),
      getRawValue(.notifications):(#imageLiteral(resourceName: "notification"),6),
      getRawValue(.termsAndConditions):(#imageLiteral(resourceName: "conditions"),8),
      getRawValue(.questions):(#imageLiteral(resourceName: "Path 6010"),9),
      getRawValue(.aboutApp):(#imageLiteral(resourceName: "about"),10),
      getRawValue(.contactUs):(#imageLiteral(resourceName: "contact"),11),
      getRawValue(.logOut):(#imageLiteral(resourceName: "logout"),12)
    ]
  }
  
  func didSelectRow(_ vc:UITableViewController,Type:driverMenuType) {
    print(Type)
    switch Type{
    case .myOrders:
      let wallet = driverOrderVC.instantiate(.traderOrders)
      vc.show(wallet, sender: nil)
    case .driverInformation:
      let profile = driverProfileTVC.instantiate(.driverProfile)
      vc.show(profile, sender: nil)
    case .Balance:
      let b = balanceVC.instantiate(.balance)
      vc.show(b, sender: nil)
    case .complaint:
      let packages = complaintListVC.instantiate(.complaint)
      vc.show(packages, sender: nil)
    case .langue:
      sheetPresenter.opensheetVC(vc, storeyBoard: .language, screenHeight: 1.3)
    case .notifications:
      let notification = notificationVC.instantiate(.Main)
      notification.navigationItem.leftBarButtonItems = nil
      vc.show(notification, sender: nil)
    case .termsAndConditions:
      let packages = aboutVC.instantiate(.terms)
      packages.type = .terms
      vc.show(packages, sender: nil)
    case .questions:
      print(Type)
    case .aboutApp:
      let packages = aboutVC.instantiate(.terms)
      packages.type = .about
      vc.show(packages, sender: nil)
    case .contactUs:
      let packages = contactUsTVC.instantiate(.contactUs)
      vc.show(packages, sender: nil)
    case .logOut:
      let nav = AppStoryboard.registration.instance.instantiateViewController(withIdentifier: "loginNav")
      vc.present(nav, animated: true, completion: nil)
    }
    
    if ((Type != .langue) && (Type != .logOut)) {
    vc.dismiss(animated: true, completion: nil)
    }
    
    
  }
  
}
