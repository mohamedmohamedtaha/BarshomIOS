//
//  RSView.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/6/21.
//

import UIKit

@IBDesignable class RSView: UIView {

  @IBInspectable var cornerNumber:CGFloat = 0.0
  
    override func draw(_ rect: CGRect) {
      handleUI()
    }
    
  func handleUI(){
    
//    self.layer.borderWidth = 1
//    self.layer.borderColor = Color.borderViewColor?.cgColor
//    self.layer.cornerRadius = cornerNumber
//    self.layer.masksToBounds = true
//    self.layer.maskedCorners = CACornerMask(rawValue: UInt(cornerNumber))
//    self.clipsToBounds = true
//    self.layoutIfNeeded()
    Utilities.delay(0.1) {
      self.dropShadow(roundCorner: self.cornerNumber)
    }
    
  }
  
}
