//
//  productCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/26/20.
//

import UIKit

protocol productDelegate {
  func reportProduct()
  func addToCart()
}
class productCell: UICollectionViewCell {


  @IBOutlet weak var bg: UIView!
  
  @IBOutlet weak var kiloBeforePriceLb: UILabel!
  @IBOutlet weak var boxBeforePriceLb: UILabel!
  
  @IBOutlet weak var hightConstraint: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
  
  var delegate:productDelegate?
  
  override func awakeFromNib() {
        super.awakeFromNib()
      
    }

  func cellConfigration(_ size:CGSize){
    
    hightConstraint.constant = size.height
    widthConstraint.constant = size.width
    
    kiloBeforePriceLb.attributedText = "30 SAR".strikeThrough(.red)
    boxBeforePriceLb.attributedText = "40 SAR".strikeThrough(.red)
    
    bg.dropShadow(roundCorner:20)
  }
  
  @IBAction func reportAction(_ sender: UIButton) {
    delegate?.reportProduct()
  }
  
  @IBAction func addToCartAction(_ sender: UIButton) {
    delegate?.addToCart()
  }
  
}
