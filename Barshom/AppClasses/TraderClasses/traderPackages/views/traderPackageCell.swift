//
//  traderPackageCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import UIKit

class traderPackageCell: UICollectionViewCell {

  @IBOutlet weak var img: UIImageView!
  @IBOutlet weak var bg: UIView!
  @IBOutlet weak var bt: UIButton!
  
  @IBOutlet weak var btConstraint: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
  @IBOutlet weak var heightConstraint: NSLayoutConstraint!
  
  var delegate:packageCellDelegate?
  var type:packagesTypes = .unSuscriped
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func cellConfigration(_ size:CGSize,Type:packagesTypes){
    img.round([.topLeft,.topRight], corner: 20)
    bg.dropShadow(roundCorner: 20)
  
    
      type = Type
      heightConstraint.constant = size.height
      widthConstraint.constant = size.width
      bg.dropShadow(roundCorner:20)
      switch Type {
      case .suscriped:
        btConstraint.constant = 0
      case .unSuscriped:
        btConstraint.constant = 35
        bt.setTitle(Strings.SubscribeTopackage.Localized, for: .normal)
      }
    }
  
  @IBAction func subscripeAction(_ sender: UIButton) {
    delegate?.select(type)
  }
  

}
