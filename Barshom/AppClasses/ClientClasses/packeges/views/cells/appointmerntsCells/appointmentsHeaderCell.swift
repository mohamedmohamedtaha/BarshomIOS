//
//  appointmentsHeaderCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/29/20.
//

import UIKit

class appointmentsHeaderCell: UITableViewCell {

  @IBOutlet weak var titleLb: UILabel!
  @IBOutlet weak var dayBg: UIView!
  @IBOutlet weak var lastBg: UIView!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func cellConfigration(_ title:String){
    titleLb.text = title
    dayBg.round((Language.currentLanguage() == "ar" ? [.topRight]:[.topLeft]), corner: 20)
    lastBg.round((Language.currentLanguage() == "ar" ? [.topLeft]:[.topRight]), corner: 20)
  }
    
}
