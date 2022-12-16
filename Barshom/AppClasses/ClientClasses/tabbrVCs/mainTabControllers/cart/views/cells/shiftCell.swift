//
//  shiftCell.swift
//  Barshom
//
//  Created by Ahmed Yehia on 17/06/2021.
//


import UIKit
protocol shiftDelegate {
  func selectShift(index:Int)
}

class shiftCell: UICollectionViewCell {
  
  @IBOutlet weak var bg: UIView!
    @IBOutlet weak var nameLb: UILabel!
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var selectView: UIImageView!
  
  var delegate:shiftDelegate?
  var storeData:Shifts?
    var index = 0
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
      
    }

    func cellConfigration(storeData:Shifts){
        self.storeData = storeData
        nameLb.text = storeData.shift_name!
        timeLb.text = "\(storeData.shift_from!) \(storeData.shift_to_period!) - \(storeData.shift_to!) \(storeData.shift_to_period!)"
        selectView.image = (storeData.isSelected ? #imageLiteral(resourceName: "checked_on") : #imageLiteral(resourceName: "checked_off")).maskWithColor(color: Color.tintColor!)
        bg.dropShadow(roundCorner:15)

  }
  
  @IBAction func storeProductAction(_ sender: UIButton) {
    delegate?.selectShift(index: index)
  }
  
}
