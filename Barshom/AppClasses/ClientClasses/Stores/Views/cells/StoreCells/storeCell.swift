//
//  storeCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit

protocol storeDelegate {
  func selectStore()
}

class storeCell: UICollectionViewCell {
  
  @IBOutlet weak var bg: UIView!
  @IBOutlet weak var heightConstriant: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
  var delegate:storeDelegate?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

  func cellConfigration(_ size:CGSize){
    heightConstriant.constant = size.height
    widthConstraint.constant = size.width
    bg.dropShadow(roundCorner:20)
  }
  
  @IBAction func storeProductAction(_ sender: UIButton) {
    delegate?.selectStore()
  }
  
}
