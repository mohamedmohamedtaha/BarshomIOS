//
//  cartDetailsCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/31/20.
//

import UIKit

protocol cartDetailsDelegate {
  func payOrder()
}
class cartDetailsCell: UITableViewCell {

  @IBOutlet weak var coponBg: UIView!
  @IBOutlet weak var addressBg: UIView!
  
  @IBOutlet weak var detailsBg: UIView!
  
  var delegate:cartDetailsDelegate?
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func cellConfigration(){
    coponBg.dropShadow(roundCorner: 15)
    addressBg.dropShadow(roundCorner: 15)
    detailsBg.dropShadow(roundCorner: 15)
  }
    
  @IBAction func coponAction(_ sender: UIButton) {
    
  }
  
  @IBAction func payAction(_ sender: UIButton) {
    delegate?.payOrder()
  }
}
