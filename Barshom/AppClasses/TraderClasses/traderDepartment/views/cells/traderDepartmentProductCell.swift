//
//  traderDepartmentProductCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/12/21.
//

import UIKit

protocol traderDepartmentProductDelegate {
    func edit(product: Products)
    func delete(product: Products)
    func share(product: Products)
}

class traderDepartmentProductCell: UICollectionViewCell {

  @IBOutlet weak var bg: UIView!
  

  @IBOutlet weak var hightConstraint: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
    @IBOutlet weak var kiloBeforePriceLb: UILabel!
    @IBOutlet weak var boxBeforePriceLb: UILabel!
      @IBOutlet weak var kiloAfterPriceLb: UILabel!
    @IBOutlet weak var boxAfterPriceLb: UILabel!
    @IBOutlet weak var kgQuantityLb: UILabel!
    @IBOutlet weak var boxQuantityLb: UILabel!
    @IBOutlet weak var unitQuantityLb: UILabel!

    @IBOutlet weak var unitBeforePriceLb: UILabel!
    @IBOutlet weak var unitAfterPriceLb: UILabel!
    
     
      @IBOutlet weak var nameLb: UILabel!
      @IBOutlet weak var prodImg: UIImageView!

  var delegate:traderDepartmentProductDelegate?
  var product: Products?
  override func awakeFromNib() {
        super.awakeFromNib()
      
    }

  func cellConfigration(_ size:CGSize,product: Products){
    self.product = product
    hightConstraint.constant = size.height
    widthConstraint.constant = size.width
    
    bg.dropShadow(roundCorner:20)
    if product.discount_per == "" || product.discount_per == "0" || product.discount_per == nil {
        kiloBeforePriceLb.isHidden = true
        boxBeforePriceLb.isHidden = true
        unitBeforePriceLb.isHidden = true
        
        boxAfterPriceLb.text = ("\(product.pro_box_price!.isEmpty ? "0" : product.pro_box_price!) \(Resources.Common.sar)")
        kiloAfterPriceLb.text = ("\(product.pro_kg_price!.isEmpty ? "0" : product.pro_kg_price!) \(Resources.Common.sar)")
        unitBeforePriceLb.text = ("\(product.pro_unit_price!.isEmpty ? "0" : product.pro_unit_price!) \(Resources.Common.sar)")
        
    }
    else
    {
        kiloBeforePriceLb.isHidden = false
        boxBeforePriceLb.isHidden = false
        unitBeforePriceLb.isHidden = false

        boxAfterPriceLb.text = ("\(product.pro_box_discount_price!.isEmpty ? "0" : product.pro_box_discount_price!) \(Resources.Common.sar)")
        
        kiloAfterPriceLb.text = ("\(product.pro_kg_discount_price!.isEmpty ? "0" : product.pro_kg_discount_price!) \(Resources.Common.sar)")
        
        unitAfterPriceLb.text = ("\(product.pro_unit_discount_price!.isEmpty ? "0" : product.pro_unit_discount_price!) \(Resources.Common.sar)")

        
        kiloBeforePriceLb.attributedText = ("\(product.pro_kg_price!) \(Resources.Common.sar)").strikeThrough(.red)
        boxBeforePriceLb.attributedText = ("\(product.pro_box_price!) \(Resources.Common.sar)").strikeThrough(.red)
        unitBeforePriceLb.attributedText = ("\(product.pro_unit_price!) \(Resources.Common.sar)").strikeThrough(.red)

    }

    
    prodImg.sd_setImage(with: URL(string: product.imageUrl ?? "empty"),placeholderImage: #imageLiteral(resourceName: "logoWhite"))
    nameLb.text = product.pro_name!
    kgQuantityLb.text = "\(Resources.Common.quantity) : \(product.pro_kg_quantity!.isEmpty ? "0" : product.pro_kg_quantity!) \(Resources.Common.kg)"
    boxQuantityLb.text = "\(Resources.Common.quantity) : \(product.pro_box_quantity!.isEmpty ? "0" : product.pro_box_quantity!) \(Resources.Common.box)"
      
      unitQuantityLb.text = "\(Resources.Common.quantity) : \(product.pro_unit_quantity!.isEmpty ? "0" : product.pro_unit_quantity!) \(Resources.Common.box)"
  }
  
  @IBAction func editAction(_ sender: UIButton) {
    delegate?.edit(product: self.product!)
  }
    @IBAction func deleteAction(_ sender: UIButton) {
      delegate?.delete(product: self.product!)
    }
    @IBAction func shareAction(_ sender: UIButton) {
      delegate?.share(product: self.product!)
    }
  
}
