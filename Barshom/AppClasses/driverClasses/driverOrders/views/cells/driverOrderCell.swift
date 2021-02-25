//
//  driverOrderCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/13/21.
//

import UIKit

protocol driverOrderDelegate {
  func showDetails()
  func delivering()
  func delivered()
  func reject()
  func complaint()
  func rate()
  
}

class driverOrderCell: UITableViewCell {

  @IBOutlet weak var statusNameLb: UILabel!
  @IBOutlet weak var detailsIndicatorLb: UILabel!
  @IBOutlet weak var actionsStack: UIStackView!
  
  @IBOutlet weak var bg: UIView!
  var delegate:driverOrderDelegate?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func cellConfigration(_ type:driverOrderType){
    handleUI()
    bg.dropShadow(roundCorner: 17)
  }
  
  func handleUI(){
  
    if Language.currentLanguage() == "ar"
    {
      detailsIndicatorLb.text = "<"
    }else {
      detailsIndicatorLb.text = ">"
    }
  }
  
  @IBAction func showDetailsAction(_ sender: UIButton) {
    delegate?.showDetails()
  }
  
  @IBAction func deliveringAction(_ sender: UIButton) {
    delegate?.delivering()
  }
  
  @IBAction func deliveredAction(_ sender: UIButton) {
    delegate?.delivered()
  }
  
  @IBAction func rejectAction(_ sender: UIButton) {
    delegate?.reject()
  }
  
  @IBAction func complaintAction(_ sender: UIButton) {
    delegate?.complaint()
  }

  @IBAction func rateAction(_ sender: UIButton) {
    delegate?.rate()
  }
  
  
  

}
