//
//  traderOrderCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 1/11/21.
//

import UIKit

protocol traderOrderDelegate {
  func showDetails()
  func Accept()
  func reject()
  func complaint()
  func Done()
  
}

class traderOrderCell: UITableViewCell {

  @IBOutlet weak var statusNameLb: UILabel!
  @IBOutlet weak var detailsIndicatorLb: UILabel!
  @IBOutlet weak var actionsStack: UIStackView!
  
  @IBOutlet weak var bg: UIView!
  var delegate:traderOrderDelegate?
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

  func cellConfigration(_ type:traderOrderType){
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
  
  @IBAction func detailsAction(_ sender: UIButton) {
    delegate?.showDetails()
  }
  
  @IBAction func acceptAction(_ sender: UIButton) {
    delegate?.Accept()
  }
  
  @IBAction func rejectAction(_ sender: UIButton) {
    delegate?.reject()
  }
  
  @IBAction func complaintAction(_ sender: UIButton) {
    delegate?.complaint()
  }

  @IBAction func doneAction(_ sender: UIButton) {
    delegate?.Done()
  }
  
  
  
  

    
}
