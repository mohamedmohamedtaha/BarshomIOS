//
//  packageProductCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

class packageProductCell: UICollectionViewCell {

  @IBOutlet weak var bg: UIView!
  
  @IBOutlet weak var hightConstraint: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
  
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  

  func cellConfigration(_ size:CGSize){
    
    hightConstraint.constant = size.height
    widthConstraint.constant = size.width
  
    bg.dropShadow(roundCorner:20)
  }
}
