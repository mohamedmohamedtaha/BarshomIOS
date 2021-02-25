//
//  rateCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/27/20.
//

import UIKit

class rateCell: UITableViewCell {

  @IBOutlet weak var bg: UIView!
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func celllConfigration(){
    bg.dropShadow(roundCorner:20)
  }
    
}
