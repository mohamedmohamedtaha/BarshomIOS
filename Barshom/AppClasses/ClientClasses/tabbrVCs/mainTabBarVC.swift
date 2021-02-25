//
//  mainTabBarVC.swift
//   Barshom
//
//  Created by Mohamed Elmakkawy on 12/22/20.
//

import UIKit

class mainTabBarVC: UITabBarController {

  let menuButton = UIButton()
  
  
    override func viewDidLoad() {
        super.viewDidLoad()
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
      //let index = tabBar.items?.firstIndex(of: item)

  }
  
 
 
  
  @objc private func menuButtonAction(sender: UIButton) {
    selectedIndex = 2
    
  }
  
}
