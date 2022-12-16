//
//  sideMenuClientModel.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/25/20.
//

import Foundation
import UIKit

enum clientMenuType:String {
    case Profile = "Profile"
    case Wallet = "Wallet"
    case Packages = "Packages"
    case complaint = "Complaint/Tickets"
    case myOrders = "My Orders"
    case registerStore = "Register Store"
    case registerRepresentative = "Register Representative"
    case questions = "Questions"
    case notifications = "Notifications"
    case aboutApp = "About App"
    case termsAndConditions = "Terms & Conditions"
    case contactUs = "Contact Us"
    case langue = "Language"
    case logOut = "Logout"
    case login = "Login"

  init?(str: String) {
      self.init(rawValue:str)
  }
}

class clientSideMenu {
  
  func getClientMenuEnum(_ index:String)->clientMenuType{
    return clientMenuType(str: index)!
  }
  
  func getRawValue(_ t:clientMenuType)->String{
    return t.rawValue
  }
  func cleintMenuDic() -> [String:(UIImage?,Int)] {
    return [
      getRawValue(.Profile):(#imageLiteral(resourceName: "info"),1),
      getRawValue(.Wallet):(#imageLiteral(resourceName: "offers"),2),
      getRawValue(.Packages):(#imageLiteral(resourceName: "ic_gradient_24px"),3),
      getRawValue(.complaint):(#imageLiteral(resourceName: "categories"),4),
      getRawValue(.myOrders):(#imageLiteral(resourceName: "requests"),5),
      getRawValue(.registerStore):(#imageLiteral(resourceName: "str"),6),
      getRawValue(.registerRepresentative):(#imageLiteral(resourceName: "info"),7),
      getRawValue(.questions):(#imageLiteral(resourceName: "Path 6010"),8),
      getRawValue(.notifications):(#imageLiteral(resourceName: "notification"),9),
      getRawValue(.aboutApp):(#imageLiteral(resourceName: "about"),10),
      getRawValue(.termsAndConditions):(#imageLiteral(resourceName: "conditions"),11),
      getRawValue(.contactUs):(#imageLiteral(resourceName: "contact"),12),
      getRawValue(.langue):(#imageLiteral(resourceName: "language"),13),
      getRawValue(UserManager.isLoggedIn ? .logOut : .login):(#imageLiteral(resourceName: "logout"),14)
    ]
  }
  
  func didSelectRow(_ vc:UITableViewController,Type:clientMenuType) {
    print(Type)
    switch Type{
    case .Profile:
        if !UserManager.isLoggedIn {
            AppHelper.showLoginAlert(vc: vc)
            return
        }
      Notify.post(.selectIndex,object:4)
    case .Wallet:
        if !UserManager.isLoggedIn {
            AppHelper.showLoginAlert(vc: vc)
            return
        }
      let wallet = walletVC.instantiate(.wallet)
        vc.navigationController?.isNavigationBarHidden = false

      vc.show(wallet, sender: nil)
    case .Packages:
        if !UserManager.isLoggedIn {
            AppHelper.showLoginAlert(vc: vc)
            return
        }
      let packages = packagesVC.instantiate(.packages)
        vc.navigationController?.isNavigationBarHidden = false
      vc.show(packages, sender: nil)
    case .complaint:
        if !UserManager.isLoggedIn {
            AppHelper.showLoginAlert(vc: vc)
            return
        }
      let packages = complaintListVC.instantiate(.complaint)
        vc.navigationController?.isNavigationBarHidden = false

      vc.show(packages, sender: nil)
    case .myOrders:
        if !UserManager.isLoggedIn {
            AppHelper.showLoginAlert(vc: vc)
            return
        }
      Notify.post(.selectIndex,object:1)
    case .registerStore:
        let packages = registerTraderTVC.instantiate(.registerTrader)
          vc.navigationController?.isNavigationBarHidden = false
        vc.show(packages, sender: nil)
      print(Type)
    case .registerRepresentative:
        let packages = registerDriverTVC.instantiate(.registerDriver)
          vc.navigationController?.isNavigationBarHidden = false
        vc.show(packages, sender: nil)
      print(Type)
    case .questions:
        let packages = faqVC.instantiate(.faq)
        vc.navigationController?.isNavigationBarHidden = false

        vc.show(packages, sender: nil)
    case .notifications:
        if !UserManager.isLoggedIn {
            AppHelper.showLoginAlert(vc: vc)
            return
        }
      Notify.post(.selectIndex,object:3)
    case .aboutApp:
      let packages = aboutVC.instantiate(.terms)
        vc.navigationController?.isNavigationBarHidden = false

      packages.type = .about
      vc.show(packages, sender: nil)
    case .termsAndConditions:
      let packages = aboutVC.instantiate(.terms)
        vc.navigationController?.isNavigationBarHidden = false
        packages.userType = "user"

      packages.type = .terms
      vc.show(packages, sender: nil)
    case .contactUs:
      let packages = contactUsTVC.instantiate(.contactUs)
        vc.navigationController?.isNavigationBarHidden = false

      vc.show(packages, sender: nil)
    case .langue:
      sheetPresenter.opensheetVC(vc, storeyBoard: .language, screenHeight: 1.3)
    case .logOut:
       
            UserManager.logout()
            vc.MakeHomeRoot()
    
      
    case .login:
        
            let nav = AppStoryboard.registration.instance.instantiateViewController(withIdentifier: "loginNav")
            vc.present(nav, animated: true, completion: nil)
        
    }
    if ((Type != .langue) && (Type != .logOut)  && (Type != .login)) {
    vc.dismiss(animated: true, completion: nil)

    }
    
    
  }
  
}
