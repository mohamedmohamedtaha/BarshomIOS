//
//  pacakseAddressCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

class pacakseAddressCell: UITableViewCell {

  @IBOutlet weak var bg: UIView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func cellConfigration(){
    bg.dropShadow(roundCorner: 20)
  }

    
}
