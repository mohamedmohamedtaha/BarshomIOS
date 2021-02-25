//
//  sideMenu.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/25/20.
//

import Foundation
import UIKit
import SideMenu

enum MenuType {
  case client,trader,driver
}
class sideMenu {
  
  var img:UIImage?
  var type:MenuType?
  var title:String?
  
  init(){}
  init(_ Imge:UIImage?,name:String?,Type:MenuType) {
    img = Imge
    type = Type
    title = name
  }
  
  func getMenu(_ T:MenuType)->[sideMenu]{
    self.type = T
    let Menu = getMenuBytype()
    var dataSourceMenu = [sideMenu]()
    let sortedDic = Menu.sorted{ $0.value.1 < $1.value.1 }
    for (key, val) in sortedDic  {
      dataSourceMenu.append(sideMenu(val.0, name: key, Type: T))
    }
    return dataSourceMenu
  }
  
   func openMenu(_ v:UIViewController,type:MenuType){
    updateMenus()
    let vc = AppStoryboard.sideMenu.instance.instantiateViewController(withIdentifier: SideMenuNavigationController.identifier) as! SideMenuNavigationController
    if Language.currentLanguage() == "ar" {
      vc.leftSide = false
    }else{
      vc.leftSide = true
    }
    vc.settings = makeSettings()
    self.type = type
    Utilities.delay(0.1) {
      Notify.post(.menuType, object: type)
    }
    v.present(vc, animated: true, completion: nil)
  }
  
  func select(_ vc:UITableViewController,index:IndexPath) {
    switch type! {
    case .client:
      let tpy = clientSideMenu().getClientMenuEnum(getMenu(type!)[index.row].title!)
      clientSideMenu().didSelectRow(vc, Type: tpy)
    case .trader:
      let tpy = traderSideMenu().getTradertMenuEnum(getMenu(type!)[index.row].title!)
      traderSideMenu().didSelectRow(vc, Type: tpy)
    case .driver:
      let tpy = driverSideMenu().getDriverMenuEnum(getMenu(type!)[index.row].title!)
      driverSideMenu().didSelectRow(vc, Type: tpy)
    }
  }
  
  
  private func getMenuBytype()->[String : (UIImage?, Int)]{
    switch type! {
    case .client:
      return clientSideMenu().cleintMenuDic()
    case .trader:
      return traderSideMenu().traderMenuDic()
    case .driver:
      return driverSideMenu().driverMenuDic()
    }
  }
  
  
  private func selectedPresentationStyle() -> SideMenuPresentationStyle {
      let modes: [SideMenuPresentationStyle] = [.menuSlideIn, .viewSlideOut, .viewSlideOutMenuIn, .menuDissolveIn]
      return modes[0]
  }
  
  private func makeSettings() -> SideMenuSettings {
      let presentationStyle = selectedPresentationStyle()
      presentationStyle.presentingEndAlpha = 0.6
      var settings = SideMenuSettings()
      settings.presentationStyle = presentationStyle
      settings.menuWidth = Constants.ScreenWidth-(Constants.ScreenWidth/4)
    
      return settings
  }
  
  private func updateMenus() {
      let settings = makeSettings()
      SideMenuManager.default.leftMenuNavigationController?.settings = settings
      SideMenuManager.default.rightMenuNavigationController?.settings = settings
  }
  
}
