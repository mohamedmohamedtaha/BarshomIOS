//
//  departmentsCell.swift
//  sharkeya
//
//  Created by Mohamed Elmakkawy on 4/4/18.
//  Copyright © 2018 Mohamed Elmakkawy. All rights reserved.
//

import UIKit
import SDWebImage

protocol sectionDelegate {
    func Select(_ index:IndexPath)
}

class topSectionCell: UICollectionViewCell {

    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var widthConstraint: NSLayoutConstraint!
  
    var delegate:sectionDelegate?
    var index:IndexPath?
    var fromOrders = false
   var section:topSection?
  func cellConfigration(_ s:topSection,index:Int,selected:Int,width:CGFloat) {
    section  = s
        if selected == index {
          indicatorView.backgroundColor = fromOrders ? Color.mainColor:Color.tintColor
          titleLb.textColor = fromOrders ? Color.mainColor:.white
        }else {
          indicatorView.backgroundColor = fromOrders ? .white:.clear
          titleLb.textColor = fromOrders ? Color.tintGray:.white
        }
        widthConstraint.constant = width
        titleLb.text = s.Title
    }
    
    
    
    @IBAction func SectionAction(_ sender: UIButton)
    {
        delegate?.Select(index!)
    }
}
