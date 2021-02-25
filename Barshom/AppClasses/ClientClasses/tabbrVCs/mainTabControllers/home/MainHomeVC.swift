//
//  MainHomeVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/24/20.
//

import UIKit
import SideMenu

class MainHomeVC: UIViewController {

  @IBOutlet weak var quickOrderBg: UIView!
  @IBOutlet weak var storesBg: UIView!
  
  var halfModalTransitioningDelegate: HalfModalTransitioningDelegate?
  
  override func viewDidLoad() {
        super.viewDidLoad()
      Utilities.addLogoTitleView(self)
      handleUI()
    }
  
  func handleUI(){
    quickOrderBg.dropShadow(roundCorner:20)
    storesBg.dropShadow(roundCorner:20)
  }
    
 
  @IBAction func menuAction(_ sender: UIButton) {
    sideMenu().openMenu(self, type: .client)
  }

  @IBAction func barshomStoreAction(_ sender: UIButton) {
    performSegue(withIdentifier: "stores", sender: nil)
  }
  
 
  @IBAction func storesAction(_ sender: UIButton) {
    let vc = storesVC.instantiate(.Stores)
    self.navigationController?.show(vc, sender: nil)
  }
  
  @IBAction func quickOrderAction(_ sender: UIButton) {
    sheetPresenter.opensheetVC(self, storeyBoard: .QuickOrder, screenHeight: 3)

  }
  
  
}
