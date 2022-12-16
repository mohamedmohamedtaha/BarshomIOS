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
  
    @IBOutlet weak var categoryLb: UILabel!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var quanLb: UILabel!
    @IBOutlet weak var prodImg: UIImageView!
    
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  

    func cellConfigration(_ size:CGSize,productData:Package_products){
    
//    hightConstraint.constant = size.height
//    widthConstraint.constant = size.width
        prodImg.sd_setImage(with: URL(string: productData.imageUrl ?? "empty"),placeholderImage: #imageLiteral(resourceName: "logoWhite").maskWithColor(color: UIColor.gray))
    nameLb.text = productData.product_name!
        categoryLb.text = productData.product_quantity_types ?? "kg"
        quanLb.text = "\(productData.product_quantity!) \(productData.product_quantity_types ?? "kg") "
    bg.dropShadow(roundCorner:20)
  }
}
