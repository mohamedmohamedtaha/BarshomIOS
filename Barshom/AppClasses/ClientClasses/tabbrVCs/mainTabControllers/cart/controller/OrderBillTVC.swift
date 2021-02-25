//
//  OrderBillTVC.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/6/21.
//

import UIKit

class OrderBillTVC: UITableViewController {

  @IBOutlet weak var headerBg: UIView!
  @IBOutlet weak var addressBg: UIView!
  @IBOutlet weak var notesBg: UIView!
  @IBOutlet weak var paymentBg: UIView!
  var roundValue:CGFloat = 15
  override func viewDidLoad() {
        super.viewDidLoad()
      handleUI()
    }
  
  func handleUI(){
    Utilities.addLogoTitleView(self)
    headerBg.dropShadow(roundCorner: roundValue)
    addressBg.dropShadow(roundCorner: roundValue)
    notesBg.dropShadow(roundCorner: roundValue)
    paymentBg.dropShadow(roundCorner: roundValue)
  }

}
