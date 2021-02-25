//
//  packageCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit

protocol packageCellDelegate {
  func select(_ type:packagesTypes)
}
class packageCell: UICollectionViewCell {

  @IBOutlet weak var bg: UIView!
  
  @IBOutlet weak var hightConstraint: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
  @IBOutlet weak var bt: UIButton!
  var delegate:packageCellDelegate?
  var type:packagesTypes = .unSuscriped
  
  override func awakeFromNib() {
        super.awakeFromNib()
    
    }
  
  func cellConfigration(_ size:CGSize,Type:packagesTypes){
    type = Type
    hightConstraint.constant = size.height
    widthConstraint.constant = size.width
    bg.dropShadow(roundCorner:20)
    switch Type {
    case .suscriped:
      bt.setTitle(Strings.Details.Localized, for: .normal)
    case .unSuscriped:
      bt.setTitle(Strings.SubscribeTopackage.Localized, for: .normal)
    }
  }
  
  @IBAction func subscribePackageAction(_ sender: UIButton) {
    delegate?.select(type)
  }
  

}
