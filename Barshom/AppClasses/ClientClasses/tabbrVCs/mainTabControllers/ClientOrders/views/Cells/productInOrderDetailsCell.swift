//
//  productInOrderDetailsCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/30/20.
//

import UIKit

class productInOrderDetailsCell: UITableViewCell {

    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var catLb: UILabel!
    @IBOutlet weak var quantityLb: UILabel!
    @IBOutlet weak var priceLb: UILabel!
    @IBOutlet weak var totalLb: UILabel!
    @IBOutlet weak var prodIv: UIImageView!
    var productData:OrderProducts?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func cellConfigration(productData:OrderProducts){
        self.productData = productData
        nameLb.text = productData.pro_name ?? ""
        catLb.text = LanguageManager.isArabic ? (productData.unit ?? "") : (productData.unitEn ?? "")
        quantityLb.text = "\(productData.quantity ?? "0") \(productData.getQuantity())"
        priceLb.text = "\(productData.single_price ?? "") \(Resources.Common.sar)"
        totalLb.text = "\(productData.q_price ?? 0) \(Resources.Common.sar)"
        prodIv.sd_setImage(with: URL(string: productData.imageUrl ?? ""), placeholderImage: #imageLiteral(resourceName: "logoWhite"))

    }
  
    
}
