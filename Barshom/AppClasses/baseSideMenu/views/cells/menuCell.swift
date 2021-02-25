//
//  menuCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/25/20.
//

import UIKit

class menuCell: UITableViewCell {

  @IBOutlet weak var img: UIImageView!
  @IBOutlet weak var titleLb: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
      
    }
  
  func cellConfigration(_ m:sideMenu){
    img.image = m.img
    titleLb.text = m.title
  }


}
