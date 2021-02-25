//
//  sideMenuTraderModel.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/11/21.
//

import Foundation
import UIKit

enum traderMenuType:String {
  
    case myOrders = "My Orders"
    case StoreInformation = "Store Information"
    case Departments = "Departments"
    case complaint = "Complaint/Tickets"
    case Packages = "Packages"
    case notifications = "Notifications"
    case langue = "Language"
    case termsAndConditions = "terms And Conditions"
    case questions = "Questions"
    case aboutApp = "About App"
    case contactUs = "Contact Us"
    case logOut = "Log Out"
   
  
  init?(str: String) {
      self.init(rawValue:str.Localized)
  }
}

class traderSideMenu {
  
  func getRawValue(_ t:traderMenuType)->String{
    return t.rawValue
  }
  
  func getTradertMenuEnum(_ index:String)->traderMenuType{
    return traderMenuType(str: index)!
  }
  
  func traderMenuDic() -> [String:(UIImage?,Int)] {
    return [
      getRawValue(.myOrders):(#imageLiteral(resourceName: "requests"),1),
      getRawValue(.StoreInformation):(#imageLiteral(resourceName: "info"),2),
      getRawValue(.Departments):(#imageLiteral(resourceName: "categories"),3),
      getRawValue(.complaint):(#imageLiteral(resourceName: "requests"),4),
      getRawValue(.Packages):(#imageLiteral(resourceName: "ic_gradient_24px"),5),
      getRawValue(.notifications):(#imageLiteral(resourceName: "notification"),6),
      getRawValue(.langue):(#imageLiteral(resourceName: "language"),7),
      getRawValue(.termsAndConditions):(#imageLiteral(resourceName: "conditions"),8),
      getRawValue(.questions):(#imageLiteral(resourceName: "Path 6010"),9),
      getRawValue(.aboutApp):(#imageLiteral(resourceName: "about"),10),
      getRawValue(.contactUs):(#imageLiteral(resourceName: "contact"),11),
      getRawValue(.logOut):(#imageLiteral(resourceName: "logout"),12)
    ]
  }
  
  func didSelectRow(_ vc:UITableViewController,Type:traderMenuType) {
    print(Type)
    switch Type{
    case .myOrders:
      let wallet = traderOrderVC.instantiate(.traderOrders)
      vc.show(wallet, sender: nil)
    case .StoreInformation:
      let profile = traderProfileTVC.instantiate(.traderProfile )
      vc.show(profile, sender: nil)
    case .Departments:
      let wallet = traderDepartmentVC.instantiate(.traderDepartment)
      vc.show(wallet, sender: nil)
    case .complaint:
      let packages = complaintListVC.instantiate(.complaint)
      vc.show(packages, sender: nil)
    case .Packages:
      let packages = packagesVC.instantiate(.packages)
      packages.uType = .trader
      vc.show(packages, sender: nil)
    case .notifications:
      let notification = notificationVC.instantiate(.Main)
      notification.navigationItem.leftBarButtonItems = nil
      vc.show(notification, sender: nil)
    case .langue:
      sheetPresenter.opensheetVC(vc, storeyBoard: .language, screenHeight: 1.3)
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
