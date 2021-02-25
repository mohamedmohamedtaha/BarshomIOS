//
//  TopTabBar.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/21/20.
//

import UIKit

@IBDesignable class TopTabBar: UIView {


   @IBInspectable var indicatorColor: UIColor?
  
   @IBInspectable var selectedColor: UIColor = UIColor.black {
    didSet {
      layer.borderColor = selectedColor.cgColor
        setNeedsLayout()
    }
   }
  
  @IBInspectable var unselectedColor: UIColor = UIColor.black {
    willSet(v) {
              //self.backgroundColor = v
        }
  }
   @IBInspectable var titleTxt: String = "Title"
  
  
  
  override func draw(_ rect: CGRect) {
       guard let context = UIGraphicsGetCurrentContext() else { return }
       context.drawPath(using: .fillStroke)
        drawView(self)
   }
  
    func drawView(_ v:UIView){
    
    let Lb = UILabel()
    Lb.textColor = selectedColor
    self.addSubview(Lb)
    Lb.translatesAutoresizingMaskIntoConstraints = true
    NSLayoutConstraint.activate([
        Lb.centerXAnchor.constraint(equalTo: v.centerXAnchor),
        Lb.centerYAnchor.constraint(equalTo: v.centerYAnchor),
        Lb.topAnchor.constraint(equalTo: v.topAnchor, constant: 0),
        Lb.bottomAnchor.constraint(equalTo: v.bottomAnchor, constant: 0),
        Lb.leadingAnchor.constraint(equalTo: v.leadingAnchor,constant: 0),
        Lb.trailingAnchor.constraint(equalTo: v.trailingAnchor,constant: 0)
    ])
    
      self.backgroundColor = indicatorColor

  }
    

}
