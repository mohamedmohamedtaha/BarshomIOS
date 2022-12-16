//
//  mainTabBarVC.swift
//   Barshom
//
//  Created by Mohamed Elmakkawy on 12/22/20.
//

import UIKit

var isFastOrder = false
var cartList = [OrderProducts]()
var rootVC: UIViewController?
func isCompanyCartCount(prod: Products) ->Bool
{
    return (cartList.filter { (product) -> Bool in
        return product.pro_adv_id == prod.pro_adv_id
    }.count > 0)
}
func isHasSameProductInCart(prod:OrderProducts) ->Bool
{
    let kgQuan = prod.pro_kg_quantity ?? "0"
    let boxQuan = prod.pro_box_quantity ?? "0"
    let unitQuan = prod.pro_unit_quantity ?? "0"
    
    var isExist = false
    for (index,i) in cartList.enumerated()
    {
        if i.pro_id! == prod.pro_id! &&  i.unit! == prod.unit!{
            if prod.unit == "kg" {
                let newQuan = Int(i.quantity!)!+Int(prod.quantity!)!
                if (newQuan > Int(kgQuan)!)
                {
                    AppHelper.showInfoAlert(message: Resources.Common.notEnoughQuant)
                    return false
                }
            }else if prod.unit == "box" {
                let newQuan = Int(i.quantity!)!+Int(prod.quantity!)!
                if (newQuan > Int(boxQuan)!)
                {
                    AppHelper.showInfoAlert(message: Resources.Common.notEnoughQuant)
                    return false
                }
            }else {
                let newQuan = Int(i.quantity!)!+Int(prod.quantity!)!
                if (newQuan > Int(unitQuan)!)
                {
                    AppHelper.showInfoAlert(message: Resources.Common.notEnoughQuant)
                    return false
                }
            }
            cartList[index].quantity =  ("\(Int(i.quantity!)!+Int(prod.quantity!)!)")
            isExist = true
            return true
        }
    }
    if !isExist
    {
        if prod.unit == "kg" {
            let newQuan = Double(prod.quantity!)!
            if (newQuan > Double((kgQuan))!)
            {
                AppHelper.showInfoAlert(message: Resources.Common.notEnoughQuant)
                return false
            }
        }
        else {
            let newQuan = Double(prod.quantity!)!
            if (newQuan > Double((boxQuan))!)
            {
                AppHelper.showInfoAlert(message: Resources.Common.notEnoughQuant)
                return false
            }
        }
        cartList.append(prod)
        return true
    }
    return false
    
}
class mainTabBarVC: UITabBarController, UITabBarControllerDelegate {

  let menuButton = UIButton()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        updateUserToken()
      selectedIndex = 2
      let menuButtonHeight = (self.tabBar.frame.height-10)
      print("menuButtonHeight = \(menuButtonHeight)")
      self.setNeedsStatusBarAppearanceUpdate()
      Notify.listen(self, name: .selectIndex, selector: #selector(self.selectIndx(notification:)))
        
    }
    
  override var preferredStatusBarStyle: UIStatusBarStyle {
      return .lightContent
  }
  
  @objc func selectIndx(notification:Notification){
    selectedIndex = (notification.object as! Int)
  }
  override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
      let index = tabBar.items?.firstIndex(of: item)
    
  }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        if UserManager.isLoggedIn {
            return true
        }
        else{
            if let x = (viewController as! UINavigationController).topViewController as? MainHomeVC {
                return  true
            }
            else{
                AppHelper.showLoginAlert(vc: self)
                return false
            }
        }
    }
    
  
  @objc private func menuButtonAction(sender: UIButton) {
    selectedIndex = 2
    
  }
  
}
