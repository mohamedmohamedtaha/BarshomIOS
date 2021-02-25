//
//  sideMenuConfigration.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/25/20.
//

import Foundation
import UIKit
import SideMenu

class sideMenu {
  
  var img:UIImage?
  var title:String?
  
  func clientMenu()->[String:(UIImage,Int)]{
    let Menu = ["Profile":(#imageLiteral(resourceName: "info"),1)]
    var dataSourceOptions = [sideMenu]()
    let sortedMenu = Menu.sorted{ $0.value.1 > $1.value.1 }
    return sortedMenu
  }
  
   func openMenu(_ v:UIViewController){
    updateMenus()
    let vc = Constants.storyBoard.sideMenu.instantiateViewController(withIdentifier: SideMenuNavigationController.identifier) as! SideMenuNavigationController
    if Language.currentLanguage() == "ar" {
      vc.leftSide = false
    }else{
      vc.leftSide = true
    }
    vc.settings = makeSettings()
    
    v.present(vc, animated: true, completion: nil)
  }
  func selectedPresentationStyle() -> SideMenuPresentationStyle {
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
