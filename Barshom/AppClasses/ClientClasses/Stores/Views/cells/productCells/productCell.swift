//
//  productCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit
import Cosmos
protocol productDelegate {
    func reportProduct(product:Products)
    func addToCart(product:Products)
    func shareProduct(product:Products)
}
class productCell: UICollectionViewCell {


  @IBOutlet weak var bg: UIView!
  
  @IBOutlet weak var kiloBeforePriceLb: UILabel!
  @IBOutlet weak var boxBeforePriceLb: UILabel!
    @IBOutlet weak var kiloAfterPriceLb: UILabel!
    @IBOutlet weak var boxAfterPriceLb: UILabel!
    
    @IBOutlet weak var unitAfterPriceLb: UILabel!
    @IBOutlet weak var unitBeforePriceLb: UILabel!
    
    @IBOutlet weak var ratingView: CosmosView!

    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var discountLb: UILabel!
    @IBOutlet weak var categoryLb: UILabel!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var prodImg: UIImageView!

  @IBOutlet weak var hightConstraint: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
  
  var delegate:productDelegate?
  var productData:Products?
  override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    func cellConfigration(_ size:CGSize,productData:Products){
        self.productData = productData
    hightConstraint.constant = size.height
    widthConstraint.constant = size.width
    
        let  kgOldPrice = Double(productData.pro_kg_price!.isEmpty ? "0" : productData.pro_kg_price!)!
        let  boxOldPrice = Double(productData.pro_box_price!.isEmpty ? "0" : productData.pro_box_price!)!
        let  unitOldPrice = Double(productData.pro_unit_price!.isEmpty ? "0" : productData.pro_unit_price!)!

        
        let  kgNewPrice = Double(productData.pro_kg_discount_price!.isEmpty ? "0" : productData.pro_kg_discount_price!)!
        let  boxNewPrice = Double(productData.pro_box_discount_price!.isEmpty ? "0" : productData.pro_box_discount_price!)!
        let  unitNewPrice = Double(productData.pro_unit_discount_price!.isEmpty ? "0" : productData.pro_unit_discount_price!)!

        
        if kgNewPrice < kgOldPrice && kgNewPrice != 0 {
            kiloAfterPriceLb.text = ("\(productData.pro_kg_discount_price!.isEmpty ? "0" : productData.pro_kg_discount_price!) \(Resources.Common.sar)")
            kiloBeforePriceLb.attributedText = ("\(productData.pro_kg_price!) \(Resources.Common.sar)").strikeThrough(.red)
            kiloBeforePriceLb.isHidden = false
        }
        else
        {
            kiloBeforePriceLb.isHidden = true
            kiloAfterPriceLb.text = ("\(productData.pro_kg_price!.isEmpty ? "0" : productData.pro_kg_price!) \(Resources.Common.sar)")

        }
        if boxNewPrice < boxOldPrice && boxNewPrice != 0 {
            boxBeforePriceLb.isHidden = false
            boxAfterPriceLb.text = ("\(productData.pro_box_discount_price!.isEmpty ? "0" : productData.pro_box_discount_price!) \(Resources.Common.sar)")
            boxBeforePriceLb.attributedText = ("\(productData.pro_box_price!) \(Resources.Common.sar)").strikeThrough(.red)
            
        }
        else
        {
            boxBeforePriceLb.isHidden = true
            boxAfterPriceLb.text = ("\(productData.pro_box_price!.isEmpty ? "0" : productData.pro_box_price!) \(Resources.Common.sar)")

        }
        
        if unitNewPrice < unitOldPrice && unitNewPrice != 0 {
            unitBeforePriceLb.isHidden = false
            unitAfterPriceLb.text = ("\(productData.pro_unit_discount_price!.isEmpty ? "0" : productData.pro_unit_discount_price!) \(Resources.Common.sar)")
            unitBeforePriceLb.attributedText = ("\(productData.pro_unit_price!) \(Resources.Common.sar)").strikeThrough(.red)
            
        }
        else
        {
            unitBeforePriceLb.isHidden = true
            unitAfterPriceLb.text = ("\(productData.pro_unit_price!.isEmpty ? "0" : productData.pro_unit_price!) \(Resources.Common.sar)")
        }
        
        

        if productData.discount_per == "" || productData.discount_per == "0" || productData.discount_per == nil {
            
            discountView.isHidden = true
            
        }
        else
        {
            discountView.isHidden = false
            discountLb.text = "\(Int(Double(productData.discount_per!.isEmpty ? "0" : productData.discount_per!)!))%"

        }
        ratingView.rating =  Double(productData.pro_rate ?? "0") ?? 0
        prodImg.sd_setImage(with: URL(string: productData.imageUrl ?? "empty"),placeholderImage: #imageLiteral(resourceName: "logoWhite").maskWithColor(color: UIColor.gray))
        nameLb.text = productData.pro_name!
        categoryLb.text = productData.cat_name
    
    bg.dropShadow(roundCorner:20)
  }
  
  @IBAction func reportAction(_ sender: UIButton) {
    delegate?.reportProduct(product: productData!)
  }
  
  @IBAction func addToCartAction(_ sender: UIButton) {
    delegate?.addToCart(product: productData!)
  }
    @IBAction func shareAction(_ sender: UIButton) {
      delegate?.shareProduct(product: productData!)
    }
  
}
