//
//  complaintCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/9/21.
//

import UIKit

class complaintCell: UITableViewCell {

  @IBOutlet weak var bg: UIView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
    }

  func cellConfigration(){
    bg.dropShadow(roundCorner: 17)
  }
    
}
