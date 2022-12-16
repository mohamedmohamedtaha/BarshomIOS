//
//  traderBalanceVC.swift
//  Barshom
//
//  Created by Ahmed Yehia on 13/07/2021.
//

import UIKit

class traderBalanceVC: UIViewController {

  
  @IBOutlet weak var currentBalanceBg: RSView!
    @IBOutlet weak var balanceLb: UILabel!

  override func viewDidLoad() {
        super.viewDidLoad()
    Utilities.addLogoTitleView(self)
    currentBalanceBg.dropShadow(roundCorner: 25)
    balanceLb.text = (UserManager.getUserData!.adv_balance ?? "0") + " \(Resources.Common.sar)"
    }
    
  @IBAction func rechargeAction(_ sender: UIButton) {
    AppHelper.showInfoAlert(message: Resources.Common.notavailable)
//    let vc = paymentTypeActionVC.instantiate(.Cart)
//    self.show(vc, sender: nil)
  }
  

}
