//
//  orderCell.swift
//  Barshom
//
//  Created by Mohamed Elmakkawy on 12/21/20.
//

import UIKit

protocol orderDelegate {
  func showDetails()
  func rate()
  func resend()
  func complaint()
  func reject()
}

class orderCell: UITableViewCell {

  @IBOutlet weak var addRateConstraint: NSLayoutConstraint!
  @IBOutlet weak var resendConstraint: NSLayoutConstraint!
  @IBOutlet weak var complanConstraint: NSLayoutConstraint!
  @IBOutlet weak var rejectConstraint: NSLayoutConstraint!
  
  @IBOutlet weak var statusNameLb: UILabel!
  @IBOutlet weak var detailsIndicatorLb: UILabel!
  @IBOutlet weak var actionsStack: UIStackView!
  
  @IBOutlet weak var bg: UIView!
  var delegate:orderDelegate?
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
  
  func cellConfigration(_ type:orderType){
    handleUI()
    selectType(type)
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
  func selectType(_ type:orderType){
    
    switch type {
      case .Waiting:
        handleSpacing(0)
        viewActions([complanConstraint,rejectConstraint])
      case .Process:
        clearSpacing()
        viewActions([complanConstraint])
      case .Delivered:
        handleSpacing(2)
        viewActions([resendConstraint,addRateConstraint])
      case .Canceld:
        resetActions()
    }
  }
  
  func handleSpacing(_ index:Int){
    clearSpacing()
    actionsStack.setCustomSpacing(5, after: actionsStack.subviews[index])
    
  }
  
  func clearSpacing(){
    actionsStack.setCustomSpacing(0, after: actionsStack.subviews[0])
    actionsStack.setCustomSpacing(0, after: actionsStack.subviews[2])
  }
  
  func viewActions(_ constraint:[NSLayoutConstraint]){
    resetActions()
    for i in constraint {
      i.constant = 80
    }
  }
  
  func resetActions(){
    addRateConstraint.constant = 0
    resendConstraint.constant = 0
    complanConstraint.constant = 0
    rejectConstraint.constant = 0
  }
  
  @IBAction func detailsAction(_ sender: UIButton) {
    delegate?.showDetails()
  }
  
  @IBAction func rateAction(_ sender: UIButton) {
    delegate?.rate()
  }

  @IBAction func resendAction(_ sender: UIButton) {
    delegate?.resend()
  }
  
  @IBAction func complaintAction(_ sender: UIButton) {
    delegate?.complaint()
  }
  
  @IBAction func rejectAction(_ sender: UIButton) {
    delegate?.reject()
  }
  
  
}
