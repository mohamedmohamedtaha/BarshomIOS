//
//  traderDepartmentProductCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/12/21.
//

import UIKit

protocol traderDepartmentProductDelegate {
  func edit()
}

class traderDepartmentProductCell: UICollectionViewCell {

  @IBOutlet weak var bg: UIView!
  
  @IBOutlet weak var kiloBeforePriceLb: UILabel!
  @IBOutlet weak var boxBeforePriceLb: UILabel!
  
  @IBOutlet weak var hightConstraint: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
  
  var delegate:traderDepartmentProductDelegate?
  
  override func awakeFromNib() {
        super.awakeFromNib()
      
    }

  func cellConfigration(_ size:CGSize){
    
    hightConstraint.constant = size.height
    widthConstraint.constant = size.width
    
    kiloBeforePriceLb.attributedText = "30 SAR".strikeThrough(.red)
    boxBeforePriceLb.attributedText = "40 SAR".strikeThrough(.red)
    
    bg.dropShadow(roundCorner:20)
  }
  
  @IBAction func editAction(_ sender: UIButton) {
    delegate?.edit()
  }
  
}
