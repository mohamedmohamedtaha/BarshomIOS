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
  
  override func viewDidLoad() {
        super.viewDidLoad()
    currentBalanceBg.dropShadow(roundCorner: 25)
    pointsBg.dropShadow(roundCorner: 25)
    }
    
  @IBAction func rechargeAction(_ sender: UIButton) {
    let vc = paymentTypeActionVC.instantiate(.Cart)
    self.show(vc, sender: nil)
  }
  

}
