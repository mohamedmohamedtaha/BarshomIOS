//
//  walletVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/10/21.
//

import UIKit

class walletVC: UIViewController {

  
  @IBOutlet weak var currentBalanceBg: RSView!
    @IBOutlet weak var pointsBg: RSView!
    @IBOutlet weak var balanceLb: UILabel!
    @IBOutlet weak var pointsLb: UILabel!

  override func viewDidLoad() {
        super.viewDidLoad()
    Utilities.addLogoTitleView(self)
    currentBalanceBg.dropShadow(roundCorner: 25)
    pointsBg.dropShadow(roundCorner: 25)
    balanceLb.text = (UserManager.getUserData!.adv_balance ?? "0") + " \(Resources.Common.sar)"
    pointsLb.text = (UserManager.getUserData!.adv_points ?? "0") + " \(Resources.Common.point)"
    }
    
  @IBAction func rechargeAction(_ sender: UIButton) {
    AppHelper.showInfoAlert(message: Resources.Common.notavailable)
//    let vc = paymentTypeActionVC.instantiate(.Cart)
//    self.show(vc, sender: nil)
  }
  

}
