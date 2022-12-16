//
//  traderDepartmentCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/12/21.
//

import UIKit

protocol traderDepartmentDelegate {
    func details(cat: Category)
    func delete(cat: Category)
}
class traderDepartmentCell: UICollectionViewCell {

  @IBOutlet weak var bg: UIView!
  
  @IBOutlet weak var hightConstraint: NSLayoutConstraint!
  @IBOutlet weak var widthConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var trashConstraint: NSLayoutConstraint!
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var catIV: UIImageView!

  var delegate:traderDepartmentDelegate?
  var showTrash = true
    var cat: Category?
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  

  func cellConfigration(_ size:CGSize,cat: Category){
    self.cat = cat
    hightConstraint.constant = size.height
    widthConstraint.constant = size.width
    if showTrash {
      trashConstraint.constant = 30
    }else {
      trashConstraint.constant = 0
    }
    bg.dropShadow(roundCorner:20)
    nameLbl.text = cat.cat_name!
    catIV.sd_setImage(with: URL(string: cat.image ?? ""), placeholderImage: UIImage(named: "logoWhite")!)
  }
  
  
  @IBAction func detailsAction(_ sender: UIButton) {
    delegate?.details(cat: self.cat!)
  }
  
    
    @IBAction func deleteAction(_ sender: UIButton) {
        delegate?.delete(cat: self.cat!)
    }
}
