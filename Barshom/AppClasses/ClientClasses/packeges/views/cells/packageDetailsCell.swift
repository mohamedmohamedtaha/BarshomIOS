//
//  packageDetailsCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

class packageDetailsCell: UITableViewCell {

  @IBOutlet weak var packageBg: UIView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func cellConfigration(){
    packageBg.dropShadow(roundCorner: 20)
  }
    
}
