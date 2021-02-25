//
//  traderDepartmentCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/12/21.
//

import UIKit

protocol traderDepartmentDelegate {
  func details()
}
class traderDepartmentCell: UICollectionViewCell {

  @IBOutlet weak var bg: UIView!
  
  @IBOutlet weak var hightConstraint: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var trashConstraint: NSLayoutConstraint!
  
  var delegate:traderDepartmentDelegate?
  var showTrash = false
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  

  func cellConfigration(_ size:CGSize){
    
    hightConstraint.constant = size.height
    widthConstraint.constant = size.width
    if showTrash {
      trashConstraint.constant = 30
    }else {
      trashConstraint.constant = 0
    }
    bg.dropShadow(roundCorner:20)
  }
  
  
  @IBAction func detailsAction(_ sender: UIButton) {
    delegate?.details()
  }
  

}
