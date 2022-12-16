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
    case Balance = "Balance"
    case StoreInformation = "Store Information"
    case Departments = "Categories"
    case complaint = "Complaint/Tickets"
    case Packages = "Packages"
    case notifications = "Notifications"
    case langue = "Language"
    case termsAndConditions = "Trader Terms & Conditions"
    case questions = "Questions"
    case aboutApp = "About App"
    case contactUs = "Contact Us"
    case logOut = "Logout"
    case wholesaleMarket = "wholesale market"
       
  init?(str: String) {
      self.init(rawValue:str)
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
      getRawValue(.wholesaleMarket):(#imageLiteral(resourceName: "home_new"),3),
      getRawValue(.Balance):(#imageLiteral(resourceName: "balance"),4),
      getRawValue(.Departments):(#imageLiteral(resourceName: "categories"),5),
      getRawValue(.complaint):(#imageLiteral(resourceName: "requests"),6),
      getRawValue(.Packages):(#imageLiteral(resourceName: "ic_gradient_24px"),7),
      getRawValue(.notifications):(#imageLiteral(resourceName: "notification"),8),
      getRawValue(.langue):(#imageLiteral(resourceName: "language"),9),
      getRawValue(.termsAndConditions):(#imageLiteral(resourceName: "conditions"),10),
      getRawValue(.questions):(#imageLiteral(resourceName: "Path 6010"),11),
      getRawValue(.aboutApp):(#imageLiteral(resourceName: "about"),12),
      getRawValue(.contactUs):(#imageLiteral(resourceName: "contact"),13),
      getRawValue(.logOut):(#imageLiteral(resourceName: "logout"),14),
      
    ]
  }
  
  func didSelectRow(_ vc:UITableViewController,Type:traderMenuType) {
    print(Type)
    switch Type{
    case .Balance:
        if !UserManager.isLoggedIn {
            AppHelper.showLoginAlert(vc: vc)
            return
        }
        let b = balanceVC.instantiate(.balance)
          vc.navigationController?.isNavigationBarHidden = false
        vc.show(b, sender: nil)
        break
    case .myOrders:
      break
    case .StoreInformation:
      let profile = traderProfileTVC.instantiate(.traderProfile )
        vc.navigationController?.isNavigationBarHidden = false

      vc.show(profile, sender: nil)
    case .Departments:
      let wallet = traderDepartmentVC.instantiate(.traderDepartment)
        vc.navigationController?.isNavigationBarHidden = false

      vc.show(wallet, sender: nil)
    case .Packages:
      let packages = traderPackagesVC.instantiate(.packages)
      packages.uType = .trader
        vc.navigationController?.isNavigationBarHidden = false

      vc.show(packages, sender: nil)
    case .complaint:
        let packages = complaintListVC.instantiate(.complaint)
          vc.navigationController?.isNavigationBarHidden = false

        vc.show(packages, sender: nil)
    case .langue:
      sheetPresenter.opensheetVC(vc, storeyBoard: .language, screenHeight: 1.3)
    case .notifications:
      let notification = notificationVC.instantiate(.Main)
      notification.navigationItem.leftBarButtonItems = nil
        vc.navigationController?.isNavigationBarHidden = false

      vc.show(notification, sender: nil)
    
    case .questions:
        let packages = faqVC.instantiate(.faq)
        vc.navigationController?.isNavigationBarHidden = false

        vc.show(packages, sender: nil)
    case .aboutApp:
      let packages = aboutVC.instantiate(.terms)
        vc.navigationController?.isNavigationBarHidden = false
      packages.type = .about
      vc.show(packages, sender: nil)
    case .termsAndConditions:
      let packages = aboutVC.instantiate(.terms)
        vc.navigationController?.isNavigationBarHidden = false
        packages.userType = "company"

      packages.type = .terms
      vc.show(packages, sender: nil)
    case .contactUs:
        let packages = contactUsTVC.instantiate(.contactUs)
          vc.navigationController?.isNavigationBarHidden = false
        vc.show(packages, sender: nil)
    case .logOut:
        UserManager.logout()
        vc.MakeHomeRoot()
    case .wholesaleMarket:
//        if selectedCity == nil
//        {
//            AppHelper.showErrorAlert(message: Resources.Login.choosecity)
//            return
//        }
//        isFastOrder = false
        let vccc = storesVC.instantiate(.Stores)
        vc.navigationController?.show(vccc, sender: nil)
    }
    if ((Type != .langue) && (Type != .logOut)) {
    vc.dismiss(animated: true, completion: nil)
    }
    
    
  }
  
}
