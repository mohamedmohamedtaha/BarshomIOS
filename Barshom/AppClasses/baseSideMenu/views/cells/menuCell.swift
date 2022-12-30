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
      if m.title! == "Store Information" {
          if UserManager.getUserData?.cat_name == "متاجر"{
              titleLb.text = "Store Information".localized()
          }else {
              titleLb.text = "Supplier Information".localized()

            }
          
      }else {
          titleLb.text = m.title!.localized()
       
      }
  }


}
